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
つい最近6周年を迎えたので祝ってください。

Obsidian歴は1年半と少し。

## obsidian.nvim とは

[epwalsh](https://github.com/epwalsh) さん作のNeovim プラグイン。
あくまで補助的に使うことを目的に作られているそう。

Obsidianにはvimモードがありますが、自分の思想的にvimモードで使うのは受け入れがたいので
このプラグインを使ってノートを書くことがまれによくあります。
また、特定の環境ではなぜか再起動や電源投入後の初回起動がうまくいかないので、ターミナルから使えるようにしたいケースがあります。

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

### 新規ノートを作成する

`:ObsidianNew` で新規ノートを作成できます。

名前を指定しないとZettelkasten形式に基づいたファイル名になります。

READMEにもありますがデフォルトはこれです。

```Lua
-- Optional, customize how names/IDs for new notes are created.
note_id_func = function(title)
  -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
  -- In this case a note with the title 'My new note' will be given an ID that looks
  -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
  local suffix = ""
  if title ~= nil then
    -- If title is given, transform it into valid file name.
    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  else
    -- If title is nil, just add 4 random uppercase letters to the suffix.
    for _ = 1, 4 do
      suffix = suffix .. string.char(math.random(65, 90))
    end
  end
  return tostring(os.time()) .. "-" .. suffix
end,
```

### 本日のデイリーノートを開く

`:ObsidianToday` で本日のデイリーノートを開けます。

### 昨日のデイリーノートを開く

`:ObsidianYesterday` で昨日のデイリーノートを開けます。

### 翌日のデイリーノートを開く

`:ObsidianTomorrow` で翌日のデイリーノートを開けます。

### ノートを素早く切り替える
`:ObsidianQuickSwitch` で素早くノートを切り替えられます。

![quickswitch]()

### カーソルの下にあるノートのリンクをたどる

`:ObsidianFollowLink` で別タブにてそのノートが開かれます。

![followlink]()

### バックリンクを取得する

`:ObsidianBacklinks` でバックリンクを取得できます。

![backlink]()

### テンプレートを挿入する

`:ObsidianTemplate [NAME]` でテンプレートを挿入できます。

![template](/images/using-obsidian-nvim/obsidiantemplate.jpg)

### ノートを検索する

`:ObsidianSearch [QUERY]` で全文検索ができます。

![oobsidiansearch](/images/using-obsidian-nvim/obsidiansearch.jpg)

### ワークスペース(保管庫)を切り替えたいとき

`:ObsidianWorkspace [NAME]` でワークスペースを切り替えできます。

### クリップボードにある画像を貼り付けたいとき

`:ObsidianPasteImg [IMGNAME]` でクリップボードにある画像を保管庫のアタッチメントフォルダに入れて、markdown形式のリンクを挿入してくれます。

## おわりに

Neovim上ですべてを行いたいという人向けではありますが、なかなか良い選択肢ではないかと思います。

Obsidianで扱うファイルはただのmarkdownファイルとその他色々なので、もしObsidian Appが提供されなくなったとしても、このように第三者のソフトウェアやプラグインで容易に再現できる点が最高です。

今後は個人的に愛用している神プラグインであるところの[Siluhouette](https://github.com/tadashi-aikawa/silhouette)をLua移植してより便利にしていけたらなと思っています。

