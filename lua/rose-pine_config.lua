local pallete = require('rose-pine.palette')
pallete.pine = '#8981d6'

require('rose-pine').setup({
	--- @usage 'main' | 'moon'
	dark_variant = 'moon',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = true,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = 'base',
		panel = 'surface',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	highlight_groups = {
		ColorColumn = { bg = 'rose' },
        Macro = {fg = 'rose'},
        ['@constant'] = {fg = 'iris'},
        ['@constructor'] = {fg = 'rose'},
        ['@keyword'] = {fg = '#8981d6'},
        Keyword    = {fg = '#8981d6'},
        ['@repeat'] = {fg = '#8981d6'},
        ['@conditional'] = {fg = '#8981d6'},
        ['@operator'] = {fg = '#8981d6'},
        ['@keyword.operator'] = {fg = '#8981d6'},
        ['@boolean'] = {fg = '#8981d6'},
        ['@include'] = {fg = '#8981d6'},
        ['@string.escape'] = {fg = '#8981d6'},
        TelescopeMatching = {fg = 'gold'},
        TelescopeNormal = {fg = 'text'}
	}
})

-- set colorscheme after options
vim.cmd('colorscheme rose-pine')