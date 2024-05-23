---
title: "Neovim + oil.nvim + Weztermで頑張って画像を表示する - WSL編"
emoji: "🖼️"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["neovim", "wezterm"]
published: false
---

[Neovim + oil.nvim + Weztermで頑張って画像を表示する](https://zenn.dev/vim_jp/articles/5b5f704de07673) からインスピレーションを受けています。

## STEP1

https://github.com/microsoft/PowerToys
最初はPowerToysのPeekをQuickLookの代わりに使おうと思ったが
Peekはコマンドラインからの実行ができない。

[Peek command line support · Issue #26712 · microsoft/PowerToys (github.com)](https://github.com/microsoft/PowerToys/issues/26712)
イシューはあるので、N年くらい待てば追加されるはず。

代わりのソフトで代用できないか調べる。
調べたところ [QL-Win/QuickLook](https://github.com/QL-Win/QuickLook) が良さそうだった。デザインも良い。

ポータブル版をダウンロードしてPATHの通った場所に置くかPATHを通す。

```shell
sudo ln -s /path/to/QuickLook.exe ~/.local/bin/winquicklook
```

動作確認でWSLから実行してみたものの一瞬だけ実行されるのみであった。すぐエラーで落ちる。
これは使えない。

## STEP2

事前準備としてWindowsのWeztermをWSLから操作できるようにしておく

```shell
sudo ln -s '/mnt/c/Program Files/WezTerm/wezterm.exe' ~/.local/bin/winwezterm
```

ここではwinweztermとした。

あとはWIP
