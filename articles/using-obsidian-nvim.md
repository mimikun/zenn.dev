---
title: "obsidian.nvim: NeovimでObsidianを使うための最高のプラグイン"
emoji: "📝"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["Obsidian", "Neovim"]
published: true
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

後述しますが、検索処理では `ripgrep`, `telescope.nvim`, `fzf.vim`, `fzf-lua` といい感じのファジーファインダーは一通り使えるのでいい感じに検索できます。

### Obsidianアプリ自体を開く

`:ObsidianOpen` でObsidianアプリ自体を開けます。

### 本日のデイリーノートを開く

`:ObsidianToday` で本日のデイリーノートを開けます。

![opendaily](https://private-user-images.githubusercontent.com/13450321/290212744-ba46085f-7f55-4ce5-ae9c-829f4a5bb2ba.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDI0NzYwNzIsIm5iZiI6MTcwMjQ3NTc3MiwicGF0aCI6Ii8xMzQ1MDMyMS8yOTAyMTI3NDQtYmE0NjA4NWYtN2Y1NS00Y2U1LWFlOWMtODI5ZjRhNWJiMmJhLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMTMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjEzVDEzNTYxMlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTE2ZmRkZGI5ZjQ4MzQzMDk5YzFiMGQ5MzAzMDZmZGJhZDMwZDFjY2FjMzBmODE5Y2IzZjEyOGNkZjE4Y2JjZGQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.0rl7wEn6-DHVeWv0QlXpoY9R4Fa6uvzhhUnYP_Iit14)

### 昨日のデイリーノートを開く

`:ObsidianYesterday` で昨日のデイリーノートを開けます。

### 翌日のデイリーノートを開く

`:ObsidianTomorrow` で翌日のデイリーノートを開けます。

### ノートを素早く切り替える
`:ObsidianQuickSwitch` で素早くノートを切り替えられます。

![quickswitch](https://private-user-images.githubusercontent.com/13450321/290212442-8592674b-168e-40ef-a78a-bd9ec21b184d.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDI0NzYwMTQsIm5iZiI6MTcwMjQ3NTcxNCwicGF0aCI6Ii8xMzQ1MDMyMS8yOTAyMTI0NDItODU5MjY3NGItMTY4ZS00MGVmLWE3OGEtYmQ5ZWMyMWIxODRkLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMTMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjEzVDEzNTUxNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWZlOWY1ODc5NmZhYTRlMWJkMDk1NTRjMGIxMGFiNjExMTk2NjA4YzkyMjY2YmY4ZWMzMjJkZGFmYTkwM2RkNTEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.7TBwW3ffD1LKM6vhcBlzK2xpsIjm8G_cM6BHRP5pDFg)

### カーソルの下にあるノートのリンクをたどる

`:ObsidianFollowLink` で別タブにてそのノートが開かれます。

![followlink](https://private-user-images.githubusercontent.com/13450321/290213508-7391e972-39d6-4f0f-a687-d60f3e923406.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDI0NzYyMzQsIm5iZiI6MTcwMjQ3NTkzNCwicGF0aCI6Ii8xMzQ1MDMyMS8yOTAyMTM1MDgtNzM5MWU5NzItMzlkNi00ZjBmLWE2ODctZDYwZjNlOTIzNDA2LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMTMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjEzVDEzNTg1NFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWFjOTlmOGIxNmE1YjA4ZDE1Nzg5Y2FkNTZkNWEwMzgyM2ZhYTg0MjIwZjkwNGNlMGI3MzA1NzhiZTkxMTg2ODImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.Rb0WcV56sd5c_BYCEGRKHhvVdkykg2FsqPrMC1eQh1Q)

### バックリンクを取得する

`:ObsidianBacklinks` でバックリンクを取得できます。

![backlink](https://private-user-images.githubusercontent.com/13450321/290210084-8a3c2972-292b-428f-9c8a-80e97d4cf621.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDI0NzU1MjgsIm5iZiI6MTcwMjQ3NTIyOCwicGF0aCI6Ii8xMzQ1MDMyMS8yOTAyMTAwODQtOGEzYzI5NzItMjkyYi00MjhmLTljOGEtODBlOTdkNGNmNjIxLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMTMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjEzVDEzNDcwOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTdhMjE1M2M1ZmU0MDlkNzcwY2E3ZDFlZjQ4OWQwY2ZhNDQwMWRkMWJlNGViZGY0ZjMwYTE4MTM0ZTcxMzk3MjkmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.xzeYhbWCu4DvGkEKY17kqvtXMG1EvctvZC5JOhFwlbQ)

### テンプレートを挿入する

`:ObsidianTemplate [NAME]` でテンプレートを挿入できます。

![template](https://private-user-images.githubusercontent.com/13450321/290211239-c115d77b-2369-4c6c-8851-049ea5fc0da1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDI0NzU3NjgsIm5iZiI6MTcwMjQ3NTQ2OCwicGF0aCI6Ii8xMzQ1MDMyMS8yOTAyMTEyMzktYzExNWQ3N2ItMjM2OS00YzZjLTg4NTEtMDQ5ZWE1ZmMwZGExLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMTMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjEzVDEzNTEwOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWI5Njk1MzQ2MGY4OWE1YjBjNTNiNTM3NThkOGE5ZTA3ZTViNTAzZjM2MGQ5MWQ5YjgyMzYyODNmZWQzMjNhZGEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.IRv1BQKGus9LaTApYd85YZAE4AgYFBZLihXzCHxXLxI)

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

自分は保管庫は1つしか持っていないのでどんな感じか不明です。


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

今後は個人的に愛用している神プラグインであるところの[Siluhouette](https://github.com/tadashi-aikawa/silhouette)をLua移植してより便利にしていけたらなと思っています。

