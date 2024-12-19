---
title: "How to use ollama for windows(beta) from WSL"
emoji: "🤖"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: ["ollama","llm"]
published: false
---

低スペック縛りでLLMを使えるのか？という実験。
具体的にはGitHub Copilotと同等のやり取りができるか。

## 結論

無理。大人しく高スペックのマシンを用意しよう。
あるいはGitHub CopilotやChatGPTが使えるよう根回ししよう。
~~最終手段: 転~~

## 検証環境
- ホスト
	- OS: Windows 10 Pro
    - CPU: Intel Core i5-9400F
    - RAM: 8.00 GB
    - DISK: 1TB HDD
    - GPU: GTX 1050
- WSL
	- OS: Ubuntu 22.04
    - RAM: 3.00GB
    - SWAP: 8.00GB

## LLMのダウンロード
検証環境にもあるとおり悲しいほどの低スペック。
WSLも3GBではまともなLLMを使えない。
だが、WSLからWindowsのollamaを呼べばそれなりのLLMを使えるのではないかと思った。
それでも8GBしかないが・・・

https://github.com/ollama/ollama?tab=readme-ov-file#model-library には
> You should have at least 8 GB of RAM available to run the 7B models, 16 GB to run the 13B models, and 32 GB to run the 33B models.

と書いてある。Bってなんのこっちゃ？バイト？ビリオン？
8GB RAMだと7Bでもギリギリだが、これは7B未満なら多分可能、ということである。

流石に7B未満でGitHub Copilotと同等の体験を得ることは難しいだろうが、やってみないとわからない。

- [gemma](https://ollama.com/library/gemma)
	- param
		- 2B
		- 7B
	- LICENSE
		- 一般的なやつではなさそう
- [mistral](https://ollama.com/library/mistral)
	- param
		- 7B
	- LICENSE
		- Apache
- [codellama](https://ollama.com/library/codellama)
	- param
		- 7B
	- LICENSE
		- 一般的なやつではなさそう
- [llama3.2](https://ollama.com/library/llama3.2)
	- param
		- 1B
		- 3B
	- LICENSE
		- 一般的なやつではなさそう

ここらへんが気になるので一通り動かしてみる。

```powershell
ollama pull llama3.2:3b
ollama pull llama3.2:1b
ollama pull codellama:7b
ollama pull mistral:7b
ollama pull gemma:2b
ollama pull gemma:7b
```

pueueを使う場合

```powershell
pueue add -- "ollama pull llama3.2:3b"
pueue add -- "ollama pull llama3.2:1b"
pueue add -- "ollama pull codellama:7b"
pueue add -- "ollama pull mistral:7b"
pueue add -- "ollama pull gemma:2b"
pueue add -- "ollama pull gemma:7b"
```

## LLMとのやり取り

APIを叩くことで可能。

ここでは `llama3.2:3b` を使う。

```powershell
ollama run llama3.2:3b

(Invoke-WebRequest -method POST -Body '{"model":"llama3.2:3b", "prompt":"Why is the sky blue?", "stream": false}' -uri http://localhost:11434/api/generate ).Content | ConvertFrom-json
```

ただ都度都度APIを叩くのも面倒だし、使ってる感じがしないので、Neovimプラグインを使う。

[codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) を使う。

自分の設定は以下参照。

https://github.com/mimikun/dotfiles/blob/master/dot_config/nvim/lua/plugins/codecompanion-nvim.lua
https://github.com/mimikun/dotfiles/blob/master/dot_config/nvim/lua/plugins/configs/codecompanion-nvim/cmds.lua
https://github.com/mimikun/dotfiles/blob/master/dot_config/nvim/lua/plugins/configs/codecompanion-nvim/dependencies.lua
https://github.com/mimikun/dotfiles/blob/master/dot_config/nvim/lua/plugins/configs/codecompanion-nvim/keys.lua
https://github.com/mimikun/dotfiles/blob/master/dot_config/nvim/lua/plugins/configs/codecompanion-nvim/opts.lua

重要なのはこの部分。

https://github.com/mimikun/dotfiles/blob/a114d278337da7ff95675f11f3a471b66d60658f/dot_config/nvim/lua/plugins/configs/codecompanion-nvim/opts.lua#L10-L24

この設定をしてNeovimで `:CodeCompanionChat` と打つ。

