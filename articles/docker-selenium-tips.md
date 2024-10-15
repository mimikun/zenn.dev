---
title: "低スペック環境でSeleniumのDockerイメージを使うときのTIPS"
emoji: "🐋"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: []
published: false
---

ほぼ自分用

## 環境

### shm-sizeは2GBないとクラッシュする

前提: 恐ろしいほど低スペックな環境

当初、`docker-compose.yml` 内では `shm-size=1g` としていた。
恐ろしいほど低スペックなので、 `docker-selenium` だけにリソースを回すことはできず、苦肉の策だった。

しかし、この設定だとしょっちゅうクラッシュしてしまっていた。
ドキュメントを見たところ以下のように記載があった。

[Troubleshooting > --shm-size="2g"]

> Why is --shm-size 2g necessary?
> This is a known workaround to avoid the browser crashing inside a docker container, here are the documented issues for Chrome and Firefox. The shm size of 2gb is arbitrary but known to work well, your specific use case might need a different value, it is recommended to tune this value according to your needs.

ChromeとFirefoxは要求スペックが厳しいのかRAMを食うので、2GB以上に設定してやらないといけないということだった。

[Troubleshooting > --shm-size="2g"]:https://github.com/SeleniumHQ/docker-selenium?tab=readme-ov-file#--shm-size2g
