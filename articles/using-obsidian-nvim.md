---
title: "obsidian.nvim: NeovimでObsidianを使うための最高のプラグイン"
emoji: "🎉"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["Obsidian", "Neovim"]
published: false
published_at: 2023-12-16 00:00
---

この記事は [Obsidian Advent Calendar 2023](https://adventar.org/calendars/8783) の 16日目 の記事です。

## はじめに

### だれ？

https://mstdn.mimikun.jp/@mimikun

6年ほど自鯖でFediverseをやっている一般人です。

Obsidian歴は1年半と少し。

## obsidian.nvim とは

[epwalsh](https://github.com/epwalsh) さん作のNeovim プラグイン。
あくまで補助的に使うことを目的に作られているそう。

Obsidianにはvimモードがありますが、自分の思想的にvimモードで使うのは受け入れがたいので
このプラグインを使ってノートを書くことがまれによくあります。
また、特定の環境ではなぜか再起動や電源投入後の初回起動がうまくいかないので、ターミナルから使えるようにしたいケースが(自分の中で)あります。

## obsidian.nvim のインストール方法

[公式ドキュメント](https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#install-and-configure) に書いてあるので見たほうが早いですが、一応自分の設定を書いておきます。

自分の設定は以下の通り。
長くなるので直リンク貼ります。

https://github.com/mimikun/dotfiles/blob/master/dot_config/nvim/lua/plugins/obsidian-nvim.lua

## obsidian.nvim の使い方

コアプラグインで使える機能は一通り使えるようになっています。

### Obsidianアプリ自体を開く

`:ObsidianOpen` でObsidianアプリ自体を開けます。

### 本日のデイリーノートを開く

`:ObsidianToday` で本日のデイリーノートを開けます。

### 昨日のデイリーノートを開く

`:ObsidianYesterday` で昨日のデイリーノートを開けます。

### 翌日のデイリーノートを開く

`:ObsidianTomorrow` で翌日のデイリーノートを開けます。

### ノートを素早く切り替える
`:ObsidianQuickSwitch` で素早くノートを切り替えられます。

`ripgrep`, `telescope.nvim`, `fzf.vim`, `fzf-lua` といい感じのファジーファインダーは一通り使えるので
いい感じに検索できます。

- `:ObsidianFollowLink` to follow a note reference under the cursor.

- `:ObsidianBacklinks` for getting a location list of references to the current
    buffer.

- `:ObsidianTemplate [NAME]` to insert a template from the templates folder,
    selecting from a list using telescope.nvim
    <https://github.com/nvim-telescope/telescope.nvim>, fzf.vim
    <https://github.com/junegunn/fzf.vim>, or fzf-lua
    <https://github.com/ibhagwan/fzf-lua>. See |obsidian-"using-templates"| for
    more information.

- `:ObsidianSearch [QUERY]` to search for notes in your vault using ripgrep
    <https://github.com/BurntSushi/ripgrep> with telescope.nvim
    <https://github.com/nvim-telescope/telescope.nvim>, fzf.vim
    <https://github.com/junegunn/fzf.vim>, or fzf-lua
    <https://github.com/ibhagwan/fzf-lua>. This command has one optional argument:
    a search query to start with.

- `:ObsidianLink [QUERY]` to link an inline visual selection of text to a note.
    This command has one optional argument: a query that will be used to resolve
    the note by ID, path, or alias. If not given, the selected text will be used as
    the query.

- `:ObsidianLinkNew [TITLE]` to create a new note and link it to an inline visual
    selection of text. This command has one optional argument: the title of the new
    note. If not given, the selected text will be used as the title.

### ワークスペース(保管庫)を切り替えたいとき

`:ObsidianWorkspace [NAME]` でワークスペースを切り替えできます。

- `:ObsidianPasteImg [IMGNAME]` to paste an image from the clipboard into the
    note at the cursor position by saving it to the vault and adding a markdown
    image link. You can configure the default folder to save images to with the
    `attachments.img_folder` option.

- `:ObsidianRename [NEWNAME] [--dry-run]` to rename the note of the current
    buffer or reference under the cursor, updating all backlinks across the vault.
    Since this command is still relatively new and could potentially write a lot of
    changes to your vault, I highly recommend committing the current state of your
    vault (if you’re using version control) before running it, or doing a dry-run
    first by appending "–dry-run" to the command, e.g. `:ObsidianRename new-id
    --dry-run`.


## おわりに

Neovim上ですべてを行いたいという人向けではありますが、なかなか良い選択肢ではないかと思います。

Obsidianで扱うファイルはただのmarkdownファイルとその他色々なので、もしObsidian Appが提供されなくなったとしても、このように第三者のソフトウェアやプラグインで容易に再現できる点が最高です。

今後はSiluhouetteをLua移植してより便利にしていけたらなと思っています。

