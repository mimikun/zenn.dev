---
title: "Starshipで見た目にこだわったターミナルを作る"
emoji: "🚀"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: ["starship", "shell"]
published: false
---

[公式ドキュメント](https://github.com/starship/starship/blob/master/docs/ja-JP/guide/README.md)を見て作業。

## 環境

- OS: `Ubuntu(WSL2)`
- ターミナル: `Hyper`
- シェル: `fish`

まず[Nerd Font](https://www.nerdfonts.com/) が必要なのでインストールする。
ダウンロードページからドキュメントでおすすめされている通り`Fira Code Nerd Font`をインストールする。

次に`starship`のバイナリをUbuntuにインストールする。

私は`cargo install starship`でインストールした。

次に`echo "starship init fish | source" >> ~/.config/fish/config.fish`を実行する。

そして、Windows側の`%appdata%\.hyper.js`の`fontFamily`に`FiraCode Nerd Font`を追記する。

最後にWindows側のVSCodeの設定ファイルに以下を追記。

`"terminal.integrated.fontFamily": "FiraCode Nerd Font"`

以上。
