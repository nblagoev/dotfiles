vim.filetype.add {
    extension = {
        cheat = 'navi',
    },
    filename = {
        ['.eslintrc.json'] = 'jsonc',
    },
    pattern = {
        ['tsconfig*.json'] = 'jsonc',
        ['.*/%.vscode/.*%.json'] = 'jsonc',
    },
}
