require("gitlinker").setup {
    callbacks = {
        ["git.qwant.ninja"] = require("gitlinker.hosts").get_gitlab_type_url,
    }
}
