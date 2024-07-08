local M = {}

local find_remote_url = function(name)
	local handle = io.popen("git remote get-url " .. name .. " 2>/dev/null")
	if handle == nil then
		return nil
	end

	local url = handle:read("*l")
	handle:close()
	return url and string.gsub(url, "ssh://", "https://")
end

M.find_github_url = function()
	local base_url = find_remote_url("upstream") or find_remote_url("origin")
	local file = vim.fn.expand("%:.")
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local url = base_url .. "/blob/main/" .. file .. "#L" .. line
	return url
end

return M
