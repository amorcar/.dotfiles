return {
	{ "tpope/vim-surround" },

	{ "tpope/vim-commentary" },
	-- git
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup()
			vim.keymap.set("n", "<leader>hb", gs.blame_line, {})
			vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame, {})
			vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, {})
			vim.keymap.set("n", "<leader>hsd", gs.preview_hunk, {})
			-- vim.keymap.set('n', '<leader>hsD', gs.diffthis, {})
			vim.keymap.set("n", "[c", gs.prev_hunk, {})
			vim.keymap.set("n", "]c", gs.next_hunk, {})
		end,
	},
	-- {
	--   "nvim-orgmode/orgmode",
	--   event = "VeryLazy",
	--   ft = { "org" },
	--   config = function()
	--     -- Setup orgmode
	--     require("orgmode").setup({
	--       org_agenda_files = "~/.orgfiles/**/*",
	--       org_default_notes_file = "~/.orgfiles/refile.org",
	--     })
	--   end,
	-- },
	-- local llm
	-- {
	--   "David-Kunz/gen.nvim",
	--   config = function()
	--     local gen = require("gen")
	--     gen.setup({
	--       model = "llama3.1:8b", -- The default model to use.
	--       quit_map = "q",     -- set keymap for close the response window
	--       retry_map = "<c-r>", -- set keymap to re-send the current prompt
	--       accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
	--       host = "localhost", -- The host running the Ollama service.
	--       port = "11434",     -- The port on which the Ollama service is listening.
	--       display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
	--       show_prompt = false, -- Shows the prompt submitted to Ollama.
	--       show_model = false, -- Displays which model you are using at the beginning of your chat session.
	--       no_auto_close = false, -- Never closes the window automatically.
	--       hidden = false,     -- Hide the generation window (if true, will implicitly set `prompt.replace = true`)
	--       init = function(options)
	--         pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
	--       end,
	--       -- Function to initialize Ollama
	--       command = function(options)
	--         local body = { model = options.model, stream = true }
	--         return "curl --silent --no-buffer -X POST http://"
	--             .. options.host
	--             .. ":"
	--             .. options.port
	--             .. "/api/chat -d $body"
	--       end,
	--       -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
	--       -- This can also be a command string.
	--       -- The executed command must return a JSON object with { response, context }
	--       -- (context property is optional).
	--       -- list_models = '<omitted lua function>', -- Retrieves a list of model names
	--       debug = false, -- Prints errors and the command which is run.
	--     })

	--     -- custom prompts
	--     require("gen").prompts["Make_Pro"] = {
	--       prompt = [[
	--       Improve the following code, without modifying its logic (outputs should be the same), refactor if needed.
	--       It its valid to improve the return datatypes if you think returning something
	--       like a dataclass would be better than some generic dictionary (for example).
	--       Make it as professional level as you can (what a senior software engineer would do).
	--       This implies not over complicating the code.
	--       Make it production ready (include doctrings, type hints, etc).
	--       Dont add too many unnecessary comments on every code line, only add them when a
	--       comment is necessary to better understand the related code expression.
	--       Use the clean code and pythonic best practices (without overcomplicating).
	--       When the code is python, follow the following rules:
	--        - if you need to use a dataframe library, that should be polars and never pandas.
	--        - always include type hints and docstrings.
	--        - use style of python > 3.11 (for example dont type hint with `List` but with `list`.
	--        - use things like context managers, decoratos, etc when necessary.
	--       Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```]],
	--       replace = true,
	--       extract = "```$filetype\n(.-)```",
	--     }
	--   end,
	-- },
}
