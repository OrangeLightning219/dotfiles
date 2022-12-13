local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require ("telescope.sorters")
local make_entry = require ("telescope.make_entry")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local putils = require("telescope.previewers.utils")
local themes = require('telescope.themes')
local notify = require('notify')

local nvim_cpp = {}

function nvim_cpp.setup(opts)
    opts = opts or {}

    if opts["path_display"] == nil then
        opts["path_display"] = "hidden"  
    end
    if opts["symbol_width"] == nil then
        opts["symbol_width"] = 90
    end

    if nvim_cpp.previewer == nil then
        conf.dynamic_preview_title = true
        nvim_cpp.previewer = conf.qflist_previewer(opts)
    end    

    vim.api.nvim_create_user_command('FindDeclaration', nvim_cpp.show_declarations_picker, {nargs = 0, desc = ''}) 
    vim.api.nvim_create_user_command('CompileCpp', nvim_cpp.compile, {nargs = 0, desc = ''}) 
    vim.api.nvim_create_user_command('ExitCpp', nvim_cpp.exit, {nargs = 0, desc = ''}) 
    vim.api.nvim_create_user_command('SignatureHelp', nvim_cpp.signature_help, {nargs = 0, desc = ''}) 

    if nvim_cpp.channel_id == nil then
        local job = require('plenary.job')
        job:new({
            command = "nvim-cpp",
            cwd = vim.fn.getcwd(),
        }):start()
        vim.loop.sleep(100)
        nvim_cpp.channel_id = vim.fn.sockconnect("tcp", "localhost:12345", {rpc = true})
        nvim_cpp.get_declarations()
    end
end

function nvim_cpp.get_declarations()
    if nvim_cpp.channel_id == nil then
        return {}
    end
    local result = vim.fn.rpcrequest(nvim_cpp.channel_id, "GetDeclarations")
    local updated = result[1]

    if updated then
        local files = result[2]
        local functions_cache = {}
        local entries = {}
        for file, declarations in pairs(files) do
            local functions = declarations["functions"]
            local structs = declarations["structs"]
            local macros = declarations["macros"]

            for index, funct in ipairs(functions) do
                local entry = {}
                entry["bufnr"] = vim.uri_to_bufnr(file)
                entry["path"] = file
                entry["lnum"] = funct["line"]
                entry["symbol_type"] = "function"

                entry["type_length"] = #funct["return_type"]
                entry["name_length"] = #funct["name"]
                local display = funct["return_type"] .. " " .. funct["name"] .. "( "

                local arguments = funct["arguments"]
                entry["args"] = {}
                for index, arg in ipairs(arguments) do
                    table.insert(entry["args"], {#arg["type"], #arg["name"]})
                    display = display .. arg["type"] .. " " .. arg["name"]
                    if index == #arguments then
                        display = display .. " )"
                    else
                        display = display .. ", "
                    end
                end

                if arguments == nil or #arguments == 0 then
                        display = display .. " )"
                end
                entry["ordinal"] = display

                if functions_cache[funct["name"]] == nil then
                    functions_cache[funct["name"]] = {display}
                else
                    table.insert(functions_cache[funct["name"]], display)
                end
                
                table.insert(entries, entry)
            end

            for index, struct in ipairs(structs) do
                local entry = {}
                entry["bufnr"] = vim.uri_to_bufnr(file)
                entry["path"] = file
                entry["lnum"] = struct["line"]
                entry["symbol_type"] = "struct"
                entry["struct_type"] = struct["type"]
                entry["ordinal"] = struct["type"] .. " " .. struct["name"]

                table.insert(entries, entry)
            end

            for index, macro in ipairs(macros) do
                local entry = {}
                entry["bufnr"] = vim.uri_to_bufnr(file)
                entry["path"] = file
                entry["lnum"] = macro["line"]
                entry["symbol_type"] = "macro"
                entry["ordinal"] = macro["name"]

                table.insert(entries, entry)
            end
        end
        nvim_cpp.functions_cache = functions_cache
        nvim_cpp.declaration_entry_cache = entries
        return entries
    else
        return nvim_cpp.declaration_entry_cache or {}
    end
end

function nvim_cpp.create_declaration_entry(entry)
    entry["col"] = 0
    entry["start"] = 0
    entry["finish"] = 0
    entry["display"] = function(self, picker)
        local highlights = {}
        if entry["symbol_type"] == "macro" then
            highlights = {{{0, #entry["ordinal"]}, "Define"}}
        elseif entry["symbol_type"] == "struct" then
            highlights = 
            {
                {{0, #entry["struct_type"]}, "Keyword"}, 
                {{#entry["struct_type"] + 1, #entry["ordinal"]}, "Type"}
            }
        else -- function
            highlights = 
            {
                {{0, entry["type_length"]}, "Type"},
                {{entry["type_length"] + 1, entry["type_length"] + entry["name_length"] + 1}, "Function"}
            }
            local arg_offset = entry["type_length"] + entry["name_length"] + 3
            for index, arg in ipairs(entry["args"]) do
                table.insert(highlights, {{arg_offset, arg_offset + arg[1]}, "Type"})
                arg_offset = arg_offset + arg[1] + arg[2] + 3
            end
        end
        return entry["ordinal"], highlights
    end
    
    return entry
end

function nvim_cpp.default_declaration_action(prompt_bufnr, map)
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local location = 
    {
        uri = selection.path,
        range = 
        {
            start = { line = selection.lnum - 1, character = selection.col },
            ["end"] = { line = selection.lnum - 1, character = selection.col },
        },
    }
    local jump_successful = vim.lsp.util.jump_to_location(location, "utf-8", true)
end

function nvim_cpp.show_declarations_picker(opts)
    opts = opts or {}
    -- vim.api.nvim_set_hl(0, "TelescopeMatching", {link = "String"})

    -- if nvim_cpp.channel_id == nil then
    --     nvim_cpp.channel_id = vim.fn.sockconnect("tcp", "localhost:12345", {rpc = true})
    --     nvim_cpp.get_results()
    -- end
    local picker = pickers.new(opts, 
    {
        prompt_title = "Find symbol",
        previewer = nvim_cpp.previewer,
        finder = finders.new_table(
        {
            results = nvim_cpp.get_declarations(),
            entry_maker = nvim_cpp.create_declaration_entry
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                nvim_cpp.default_declaration_action(prompt_bufnr, map)
            end)
            return true
        end,
    })
    picker:find()
end

function nvim_cpp.compile()
    if nvim_cpp.channel_id == nil then
        return {}
    end
    local notify_config = {render = "minimal", stages = "fade", fps = 60 }
    local result = vim.fn.rpcrequest(nvim_cpp.channel_id, "Compile")

    local started = result["started"]
    local messages = result["messages"] or {}
    
    if started and #messages > 0 then
        local entries = {}
        for index, message in ipairs(messages) do
            local entry = {}
            -- entry["bufnr"] = vim.uri_to_bufnr("E:\\Projects\\nvim-cpp\\main.cpp")
            entry["filename"] = message["filename"] or ""
            entry["lnum"] = message["lnum"] or 1
            entry["col"] = message["col"] or 1
            entry["nr"] = message["nr"] or ""
            entry["text"] = message["text"]
            entry["type"] = message["type"]
            table.insert(entries, entry)
        end
        -- print(vim.inspect(entries))

        notify("Compilation failed", "error", notify_config)
        vim.fn.setqflist(entries, "r")
        vim.api.nvim_command("bot copen")
        -- vim.api.nvim_command("wincmd p")
    elseif started and #messages == 0 then
        notify("Compilation successful", "info", notify_config)
        vim.api.nvim_command("cclose")
    else
        notify("Compilation failed", "error", notify_config)
        vim.api.nvim_command("cclose")
    end
end

function nvim_cpp.signature_help()
    local opts = 
    {
        focusable = false,
        close_events = {"InsertLeave"} --{ 'CursorMoved', 'CursorMovedI'}
    }
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local col = cursor[2]
    local current_char = line:sub(col, col)
    
    local parens_to_find = 1
    while parens_to_find > 0 and col > 0 do
        -- print("checking " .. current_char .. " at col " .. col)
        if current_char == "(" then
            parens_to_find = parens_to_find - 1
        elseif current_char == ")" then
            parens_to_find = parens_to_find + 1
        end
        col = col - 1
        current_char = line:sub(col, col)
    end

    if col == 0 then
        return
    end
    
    local word_end = col

    while string.match(current_char, '%a') ~= nil and col > 0 do
        -- print("checking " .. current_char .. " at col " .. col )
        col = col - 1
        current_char = line:sub(col, col)
    end
        
    local word_start = col
    if col > 0 then
        word_start = col + 1
    end
    
    local word = line:sub(word_start, word_end)
    -- print(word)
    local function_name = nvim_cpp.functions_cache[word]
    if function_name ~= nil then
        local fbuf, fwin = vim.lsp.util.open_floating_preview(function_name, '', opts)
        -- vim.api.nvim_buf_add_highlight(fbuf, -1, "TelescopePreviewBlock", 0, 2, 4 )
        putils.highlighter(fbuf, "cpp", {})
    end

end

function nvim_cpp.exit()
    if nvim_cpp.channel_id ~= nil then
        result = vim.fn.rpcrequest(nvim_cpp.channel_id, "Exit")
        vim.fn.chanclose(nvim_cpp.channel_id)
        nvim_cpp.channel_id = nil
    end
end

return nvim_cpp
