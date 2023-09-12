local config = {}
function config.lang_java()
    local conf = {
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            "/home/bighu/.local/share/nvim/lsp_servers/jdt-ls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
            "-configuration",
            "/home/bighu/.local/share/nvim/lsp_servers/jdt-ls/config_linux",
            "-data",
            "/home/bighu/.local/share/nvim/lsp_servers/jdt-ls/workspace/folder",
        },
        settings = {
            java = {},
        },
        init_options = {
            bundles = {},
        },
    }
    require("jdtls").start_or_attach(conf)
end

return config
