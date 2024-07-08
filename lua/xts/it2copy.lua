local M = {}

local it2copy = "/home/tstoeback/.iterm2/it2copy"

function M.init()
	if vim.fn.filereadable(it2copy) == 1 then
		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				print("it2copy")
				-- This is pretty bad, yanking anything with single-quotes will break.
				--  TODO: Base64 encode the payload directly.
				os.execute(string.format("echo %s | %s", vim.fn.getreg("@"), it2copy))
			end,
		})
	end
end

return M
