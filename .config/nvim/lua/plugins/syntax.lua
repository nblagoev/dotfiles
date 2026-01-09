return {
	{
		"ghostty",
		dir = vim.fs.joinpath(vim.env.GHOSTTY_RESOURCES_DIR, "..", "nvim", "site"),
		lazy = false,
		cond = vim.env.GHOSTTY_RESOURCES_DIR ~= nil,
	},
	-- {
	-- 	"codethread/qmk.nvim",
	-- 	opts = {
	-- 		name = "LAYOUT_91_ansi",
	-- 		variant = "qmk",
	-- 		layout = {
	-- 			"x x x x x x _ x x x x x x",
	-- 			"x x x x x x _ x x x x x x",
	-- 			"x x x x x x _ x x x x x x",
	-- 			"_ _ _ x x x _ x x x _ _ _",
	-- 		},
	-- 	},
	-- },
}
