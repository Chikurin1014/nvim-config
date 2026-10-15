---@param lhs string
---@param module 'select' | 'move'
---@param method string
---@param query string | string[]
---@param group string
---@param desc string
---@return LazyKeysSpec
local function textobject_key(lhs, module, method, query, group, desc)
    return {
        lhs,
        function()
            require('nvim-treesitter-textobjects.' .. module)[method](query, group)
        end,
        mode = module == 'select' and { 'x', 'o' } or { 'n', 'x', 'o' },
        desc = desc,
    }
end

local keys = {}
for _, key in ipairs {
    { 'am', 'select', 'select_textobject',   '@function.outer',              'textobjects', 'function' },
    { 'im', 'select', 'select_textobject',   '@function.inner',              'textobjects', 'inner function' },
    { 'ac', 'select', 'select_textobject',   '@class.outer',                 'textobjects', 'class' },
    { 'ic', 'select', 'select_textobject',   '@class.inner',                 'textobjects', 'inner class' },
    -- You can also use captures from other query groups like `locals.scm`
    { 'as', 'select', 'select_textobject',   '@local.scope',                 'locals',      'scope' },

    { ']m', 'move',   'goto_next_start',     '@function.outer',              'textobjects', 'next function' },
    { '][', 'move',   'goto_next_start',     '@class.outer',                 'textobjects', 'next class' },
    -- You can also pass a list to group multiple queries.
    { ']o', 'move',   'goto_next_start',     { '@loop.inner', '@loop.outer' }, 'textobjects', 'next loop' },
    -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
    { ']s', 'move',   'goto_next_start',     '@local.scope',                 'locals',      'next scope' },
    { ']z', 'move',   'goto_next_start',     '@fold',                        'folds',       'next fold' },

    { ']M', 'move',   'goto_next_end',       '@function.outer',              'textobjects', 'next function end' },
    { ']]', 'move',   'goto_next_end',       '@class.outer',                 'textobjects', 'next class end' },

    { '[m', 'move',   'goto_previous_start', '@function.outer',              'textobjects', 'previous function' },
    { '[[', 'move',   'goto_previous_start', '@class.outer',                 'textobjects', 'previous class' },

    { '[M', 'move',   'goto_previous_end',   '@function.outer',              'textobjects', 'previous function end' },
    { '[]', 'move',   'goto_previous_end',   '@class.outer',                 'textobjects', 'previous class end' },
} do
    table.insert(keys, textobject_key(unpack(key)))
end

return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        lazy = true,
        keys = keys,
        opts = {
            move = {
                set_jumps = true,
            },
        },
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
    }
}
