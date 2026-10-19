-- Go 专属：仅做 format，不做任何 import / 引用包解析
-- （vim-go 已暂时停用，见 lua/plugs/init.lua；这里用 gofmt 二进制补上保存格式化）
local bufnr = vim.api.nvim_get_current_buf()

-- 用 gofmt 二进制格式化当前 buffer：只解析语法，不加载包，毫秒级
local function gofmt_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local res = vim
		.system({ "gofmt" }, { stdin = table.concat(lines, "\n") .. "\n", text = true })
		:wait()
	if res.code ~= 0 then
		vim.notify("gofmt: " .. vim.trim(res.stderr or "failed"), vim.log.levels.ERROR)
		return
	end

	local new = vim.split(res.stdout, "\n", { plain = true })
	if new[#new] == "" then
		table.remove(new)
	end
	if vim.deep_equal(new, lines) then
		return
	end

	local view = vim.fn.winsaveview()
	pcall(vim.cmd, "silent! undojoin") -- 并入上一次改动，避免产生额外 undo 步骤
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new)
	vim.fn.winrestview(view)
end

-- 保存自动格式化（只 gofmt）。不想要就 :lua vim.g.go_autoformat = 0
if vim.g.go_autoformat ~= 0 then
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = gofmt_buf,
	})
end

-- 手动格式化
vim.keymap.set("n", "<leader>gf", gofmt_buf, { buffer = bufnr, silent = true, desc = "Go: Format (gofmt)" })

-- 手动整理 / 补齐 import：走已经在跑的 gopls，会加载包，所以只在手动时触发
vim.keymap.set("n", "<leader>gi", function()
	vim.lsp.buf.code_action({
		context = { only = { "source.organizeImports" }, diagnostics = {} },
		apply = true,
	})
end, { buffer = bufnr, silent = true, desc = "Go: Organize Imports (gopls)" })
