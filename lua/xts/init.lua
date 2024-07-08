local M = {}

M.copy = function(s)
	require("xts/it2copy").copy(s)
end

M.copy_github_url = function()
	local url = require("xts/github").find_github_url()
	M.copy(url)
end

return M
