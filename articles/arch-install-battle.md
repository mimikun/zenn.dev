---
title: "ArchInstallBattle(2023/12)"
emoji: "🐧"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["Arch"]
published: false
---

ThinkPad E14 Gen5(Intel) にArch Linuxをインストールしていく。

このサイトを参考に作業した。感謝。
[archinstallを利用したArch Linuxの導入手順 | 点と接線。](https://riq0h.jp/2022/05/18/094517/)

### セキュアブート無効化まで

まず、ThinkPad(以下マシンと呼称)の電源を入れる。
それから、F1キーを壊す勢いで連打する。
指先を痙攣させ、超高速連打する。

自分の場合、なぜか壊す勢いで連打しないといけない。

![biosmenu](/images/arch-install-battle/biosmenu.jpeg)

BIOSメニューに入れたら、セキュアブートを無効にする。

![securebootdisable](/images/arch-install-battle/securebootdisable.jpeg)

### ArchをUSBメモリから起動

セキュアブートを無効にできたら、F10キーを押し、続いてEnterを押す。

それから、ブートメニューに入る。
そのために、F12キーを壊す勢いで連打する。
指先を痙攣させ、超高速連打する。

~~自分のものなら壊しても修理依頼するだけでいいので気楽。~~

ブートメニューが出てきたら、ここは人によるが、`USB HDD: なんとかかんとか` をクリックする。

黒い画面でログがずらずら流れて、最終的にはArchの画面が立ち上がる。

![archgamen](/images/arch-install-battle/archgamen.jpeg)

### 無線LAN接続

最初にiwctlで無線アクセスポイントの設定をする。

```shell
$ iwctl
[iwd]# wsc list # たいていwlan0
[iwd]# station wlan0 get-networks
[iwd]# station wlan0 connect <AP名> # Tab補完が効くので活用するといい
Passphrase: ****
[iwd]# station wlan0 show
[iwd]# quit
# pingして疎通確認
$ ping -c 4 google.com
```

### archinstallでArchInstallBattle開始

![archinstallss](/images/arch-install-battle/archinstallss.jpeg)

#### 

