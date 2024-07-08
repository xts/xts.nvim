local health = vim.health or require("health")

local M = {}

local it2copy = "/home/tstoeback/.iterm2/it2copy"

M.copy = function(s)
	local cmd = string.format("echo '%s' | %s", s, it2copy)
	os.execute(cmd)
end

M.init = function()
	if vim.fn.filereadable(it2copy) == 1 then
		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				-- This is pretty bad, yanking anything with single-quotes will break.
				--  TODO: Base64 encode the payload directly.
				M.copy(vim.fn.getreg("@"))
			end,
		})
	end
end

M.check = function()
	if vim.fn.filereadable(it2copy) == 1 then
		health.ok("it2copy exists: " .. it2copy)
	else
		health.warn("it2copy not found")
	end
end

return M
