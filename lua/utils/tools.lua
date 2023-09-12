local M = {}

-- 获取当前文件的根目录
function M.get_project_git_path()
    -- 获取当前文件路径
    local current_file = vim.fn.expand("%:p")

    -- 逐级向上查找项目 Git 位置
    local directory = vim.fn.fnamemodify(current_file, ":h")
    while directory ~= "" do
        -- 检查当前目录是否包含 .git 目录
        local git_directory = directory .. "/.git"
        if vim.fn.isdirectory(git_directory) == 1 then
            vim.cmd("cd " .. git_directory)
            return git_directory
        end

        -- 向上一级目录继续查找
        directory = vim.fn.fnamemodify(directory, ":h")
    end

    -- 如果未找到项目 Git 位置，返回空字符串
    return ""
end

return M
