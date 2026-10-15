local M = {}

--- Open Oil explorer with a vertical preview window
function M.open_with_preview()
    local oil = require 'oil'
    oil.open(nil, { preview = { vertical = true, split = 'belowright' } }, function()
        -- open & resize preview automatically
        oil.open_preview({}, function() vim.cmd('vertical resize 30') end)
    end)
end

return M
