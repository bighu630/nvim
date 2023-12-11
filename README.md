# nvim

使用 lazy 管理插件的 nvim 编辑环境

## 使用效果

|                                                                                                                                         |                                                                                                                               |
| --------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| ![首页](https://i.imgur.com/pnHSTS4.png "起始页")<center style="font-size:14px;color:#C0C0C0;text-decoration:underline">起始页</center> | ![lazy](https://i.imgur.com/CCknKtM.png) <center style="font-size:14px;color:#C0C0C0;text-decoration:underline">lazy</center> |
| ![mason](https://i.imgur.com/1pjAmcl.png "mason")<center style="font-size:14px;color:#C0C0C0;text-decoration:underline">mason</center>  | ![dap](https://i.imgur.com/yiol6Od.png) <center style="font-size:14px;color:#C0C0C0;text-decoration:underline">dap</center>   |

## 配置结构

```sh
.
├── lua                   # 主目录
│   ├── core              # Lazy加载文件
│   ├── dap               # dap相关配置文件
│   ├── formatters        # 格式化相关配置
│   ├── keymap            # 快捷键相关配置
│   ├── lang              # 语言支持相关配置
│   ├── lsp               # lsp语法补全配置
│   ├── plugs             # 插件列表
│   ├── tools             # 其他攻击配置
│   └── ui                # ui插件相关配置
└── my-snippets
    └── snippets
```

### 软件依赖

由于这一套配置我已经用好久了，有些依赖我可能不记得我装过，所以这里会最大限度的列举可能的依赖
不过可以放心,没有依赖只会导致极少部分功能无法使用, nvim 的插件一般不需要外部依赖

```bash
- git
- fzf
- fd
- jq
- stylua
- shfmt
- nodejs
- python
- pip
- tmux 可以有
```

> 这些在archlinux上都可以直接装

## 配置说明

### 快捷键

- 文件相关

| 模式 | key        | 功能              |
| ---- | ---------- | ----------------- |
| n    | ;          | leader,vim 控制键 |
| n    | E          | 前一buffer        |
| n    | R          | 后一buffer        |
| n    | B          | 切换到指定buffer  |
| n    | x          | 保存并退出buffer  |
| n    | Q          | 退出buffer        |
| n    | ff         | 打开/关闭文件树   |
| n    | \<leager>u | 打开/关闭undotree |
| n    | \<Ctrl-s>  | 保存              |

- 窗口相关

| 模式 | key            | 功能                 |
| ---- | -------------- | -------------------- |
| n    | \<leager>left  | 横向窗口减小         |
| n    | \<leager>right | 横向窗口增大         |
| n    | \<Ctrl-w> =    | 窗口大小复原         |
| n    | \<Ctrl-h>      | 切换到左边窗口或tmux |
| n    | \<Ctrl-l>      | 切换到右边窗口或tmux |
| n    | \<Ctrl-j>      | 切换到下边窗口或tmux |
| n    | \<Ctrl-k>      | 切换到上边窗口或tmux |

- 操作代码/代码块

| 模式 | key       | 功能               |
| ---- | --------- | ------------------ |
| n/v  | Y/y       | 复制               |
| n/v  | P/p       | 粘贴               |
| n/v  | D/d       | 删除               |
| n    | n         | 下一处查找         |
| n    | N         | 上一处查找         |
| n    | J         | 当前行合并到上一行 |
| n    | j         | 长按j快速下移      |
| n    | k         | 长按k快速上移      |
| v    | <         | 代码块左移         |
| v    | >         | 代码块右移         |
| n    | \<tab>    | 打开/关闭代码折叠  |
| i    | \<Ctrl-h> | 光标左移           |
| i    | \<Ctrl-l> | 光标右移           |

- telescope 快捷键

| 模式 | key         | 功能             |
| ---- | ----------- | ---------------- |
| n    | \<space>r   | 历史打开文件     |
| n    | \<space>F   | 查找项目下的文件 |
| n    | \<space>hk  | 查看快捷键列表   |
| n    | \<space>w   | 查看关键字       |
| n    | \<space>fg  | 查看git file     |
| n    | \<leager>sc | 切换主题         |
| n    | \<space>p   | 打开项目         |

> 在打开项目的界面按 \<esc> 后,按 c 保存项目(自动识别项目根目录)

- lsp语法相关

| 模式 | key         | 功能                       |
| ---- | ----------- | -------------------------- |
| n    | \<leader>lr | 重启lsp                    |
| n/v  | \<leader>rp | sniprun/快速运行           |
| n    | gt          | 打开/关闭错误列表          |
| n    | K           | 查看变量说明               |
| n    | gp          | 使用浮动窗口显示变量声明   |
| n    | gd          | 跳转到变量声明             |
| n    | gh          | 查看所有的声明与引用       |
| n    | -           | 跳转到当前文件的上一个错误 |
| n    | =           | 跳转到当前文件的下一个错误 |

- dap快捷键

| 模式 | key          | 功能            |
| ---- | ------------ | --------------- |
| n    | \<F2>        | 打断点/删除断点 |
| n    | \<leader>db  | 打断点/删除断点 |
| n    | \<leader>drl | 运行到当前行    |
| n    | \<F5>        | 开始debug       |
| n    | \<F4>        | 退出            |
| n    | 4            | 退出            |
| n    | 5            | 继续运行        |
| n    | 6            | 步过            |
| n    | 7            | 步入            |
| n    | 8            | 步出            |
| n    | J            | 查看变量        |

> 数字快捷键只在debug模式有用

- 其他常用快捷键

| 模式 | key        | 功能             |
| ---- | ---------- | ---------------- |
| n/v  | L          | 翻译(使用google) |
| n    | \<Ctrl-\\> | 开启关闭浮动终端 |
| n    | \<F11>     | MarkdownPreview  |

以上是一些常用的快捷键，一般这些就够用了，还有一些快捷键几乎一周只会用一两次，我就不一一列举了

### 一些使用技巧（使用说明）

#### **安装lsp**

> 在命令行模式中打开 Mason

> 使用 `/` 搜索语言

> 用n 上下切换

> i 安装

> ? 查看帮助

#### **语法高亮**

> 使用 TSInstall 安装

> 注意 代码折叠依赖依法高亮支持，如果这个语言没有安装语法高亮，将无法使用代码折叠

#### **debug**

dap可以和vscode 的 debug互通，如果在当前项目下存在 .vscode/launch.json

dap启动时会自动读取launch.json中的配置

不过在此之前需要在dap中配置dap的adapter

例如go的adapter , 具体可以看nvim-dap的github页面

```lua
dap.adapters.go = {
	type = "server",
	port = "38698",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:38698" },
	},
}
```

在 nvimdap.lua 中有一些默认的dap配置，如果没有launch.json可以用这些默认配置，（也可以自己写默认配置）

eg：

```lua
dap.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "go",
        name = "Debug (Arguments)",
        request = "launch",
        program = "${file}",
        args = get_arguments,
    },
}
```

!!! 对于使用.vscode/launch.json，需要修改一下launch.json这个文件。vscode的这个文件好像不是标准的json文件

```json
{
  // 改动1
  "version": "0.2.0",
  "configurations": [
    {
      "type": "go",
      "name": "Debug local",
      "request": "launch",
      // 改动2
      "program": "${workspaceFolder}",
      "args": [] // 改动3
    }
  ]
}
```

改动1： 默认vscode的这里有一段注释 建议把注释删掉

改动2： 这里有个 mode：auto，dap-nvim中没有auto这个模式，可以之间删除,也可以改成（debug,test...）

改动3： 去掉这里的`,` 如果有的话

修改后

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "go",
      "name": "launch",
      "request": "launch",
      "program": "${workspaceFolder}",
      "args": []
    }
  ]
}
```

## end

如果有什么改进的建议，欢迎提issues，up会抽时间处理
