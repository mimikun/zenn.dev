---
title: "Hydra.nvimでシンプルなメニューを作る"
emoji: "🐍"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: ["neovim"]
published: true
---

## Hydra.nvimとは

[nvimtools/hydra.nvim](https://github.com/nvimtools/hydra.nvim)

[Emacsの同名パッケージ](https://github.com/abo-abo/hydra) を参考にした、Neovim用のHydraです。

:::message alert
[anuvyklack/hydra.nvim](https://github.com/anuvyklack/hydra.nvim) がオリジナルのリポジトリですが、もうメンテされていません。(最終更新2年前...)
:::

## Hydra.nvim 導入前後 Before-After

ダッシュボードの表示を改善しました。

![before](/images/create-simple-menu-with-hydra-nvim/before.png)
*Before - 結構ギチギチ*

![after](/images/create-simple-menu-with-hydra-nvim/after.png)
*After - スッキリ！*

![updatemenu](/images/create-simple-menu-with-hydra-nvim/hydramenu.png)
*実際のメニュー画面*

## 使い方

かなり大変です。設定することが前提なので、設定をしないと何もできません。

設定方法は大体READMEに書いてあるのでそちらを参考にしてください...と書こうとしましたが

そもそもが複雑でわかりにくいので実例を書きながら解説していきます。

これより先はプラグインマネージャに `lazy.nvim` を使用している前提で説明していきます。

プラグインをインストールします。

適当なファイルに以下のコードを追加してください。

```lua
return {
    "nvimtools/hydra.nvim",
    opts = {},
}
```

## Hydraを生やす

このような形式のテーブルを作成してhydraのコンストラクタを呼び出す必要があります。

```lua
local hint = [[ ... ]]
-- Hydraが呼び出されたときに出てくる複数行にわたるヒント文字列
-- 詳しくはREADME: https://github.com/nvimtools/hydra.nvim#hint

local Hydra = require("hydra")
Hydra({
    name = "Hydra's name", -- hydraの名前
    mode = "n", -- モード, この場合はNORMALモード
    body = "<leader>o", -- hydraを呼び出すキー

    hint = hint,
    config = {
        -- ここにconfigを書く
        -- 詳しくはREADME: https://github.com/nvimtools/hydra.nvim#config
    },
    heads = {
        -- ここにそれぞれの頭を書く
        -- 詳しくはREADME: https://github.com/nvimtools/hydra.nvim#heads
    },
})
```

:::message
Hydraとはギリシア神話の怪物のことです。蛇の姿をしていて、頭がたくさん生えています。
ようするにヤマタノオロチです。
本プラグインとはあまり関係ないのでここから先は暇なときにWikipediaで確認してください。
:::

## `update-menu` Hydraを生やす

ここからは実際にHydraを生やしていきます。

適当なファイルに以下のコードを追加してください。

インストール定義を書いたファイルとは別なファイルに書くと便利です。そこはお好みで。

```lua
local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local hint = [[
 ^  󰒲  ^ Update _l_azy       ^
 ^  󰭠  ^ Update _m_ason      ^
 ^  󰐅  ^ Update _t_reesitter ^
]]

local update_menu = Hydra({
    name = "Update Menu",
    hint = hint,
    config = {
        invoke_on_body = true,
        hint = {
            offset = -1,
            float_opts = {
                border = "rounded",
            },
        },
    },
    mode = "n",
    body = "u",
    heads = {
        {
            "l",
            function()
                require("lazy").sync()
            end,
            { exit = true, desc = "Update Plugins" },
        },
        {
            "m",
            cmd("MasonUpdateAll"),
            { exit = true, desc = "Update Mason tools" },
        },
        {
            "t",
            cmd("TSUpdate"),
            { exit = true, desc = "Update Treesitter" },
        },
        {
            "<Esc>",
            nil,
            { exit = true, desc = false },
        },
    },
})

return update_menu
```

この例の場合、ノーマルモードで `u` を押すと次のような動きができるメニューが出てきます。

- `l` を押すと `:Lazy sync` が実行される
- `m` を押すと `:MasonUpdateAll` が実行される
- `t` を押すと `:TSUpdate` が実行される
- `Esc` を押すとメニューが閉じる(これは非表示)

![updatemenu](/images/create-simple-menu-with-hydra-nvim/hydramenu.png)

以上です。生産性改善の助けになれば幸いです。

他の例については私の [dotfiles](https://github.com/mimikun/dotfiles) を参考にしてください。
