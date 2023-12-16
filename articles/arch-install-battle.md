---
title: "ArchInstallBattle(2023/12 最新)"
emoji: "🐧"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["Arch"]
published: true
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

#### Archinstall language

日本語が選べるようになっているがこれは罠で、日本語を選ぶと文字化けしてしまう。
大人しく英語を選ぶ。

#### Mirrors

`Mirror region` は `Japan` に設定する。

#### Locales

`Keyboard layout`: `jp106`
`Locale language`: `ja_JP.UTF-8`
`Locale encoding`: `UTF-8`

とする。

#### Disk configuration

- Use a best-effort default partition layout
- Manual Partitioning
- Pre-mounted configuration

一番上の `Use a best-effort default partition layout` を選ぶ。

![diskconfig](/images/arch-install-battle/diskconfig.jpeg)

`512GB` と書いてあるディスクを選び、Enterを押す。

そうするとファイルシステムの選択画面に進む。

- btrfs
- ext4
- xfs
- f2fs

ここは無難にext4にしました。

次の選択ではデフォルトのYESを押します。

結果はこのようになりました。コマンドをいちいち入力しなくてもいいのは神です。GOD

![diskconfigresult](/images/arch-install-battle/diskconfigresult.jpeg)

#### Disk encryption

ここは興味がないのでノータッチです。
~~PC盗まれた時点で終わりですから・・・~~

#### Bootloader

デフォルトの `systemd-boot` にします。

#### Unified kernel images

デフォルトの `False` にします。
~~よくわかってないのもある~~

#### Swap

デフォルトの `True` にします。
RAM 16GBと最低限度の人権しかないので。

#### Hostname

`azusa` にしました。

(ᓀ‸ᓂ) < vanitas vanitatum, et omnia vanitas.

#### Root password

パスワードマネージャーで良い感じに生成します。

#### User account

パスワードはパスワードマネージャーで良い感じに生成します。

#### Profile

デスクトップ環境を決めるところらしいです。
`Type` は `Desktop` としました。
デスクトップ環境は `i3-wm` にしました。
グラフィックドライバは `All open-source` にしました。
Greeterはデフォルトの `lightdm-gtk-greeter` にしました。

#### Audio

自分は耳が聞こえないので設定しなくてもいいと思いましたが、一応設定します。

`Pipewire` にしました。

#### Kernels

`linux` にしました。

#### Additional packages

追加でインストールするパッケージを指定します。

`neovim` と `vivaldi` を指定しました。ほかは後で入れればいいので。

#### Network configuration

`Copy ISO network configuration to installation` を選びました。

#### Timezone

`Japan` を指定。

#### Automatic time sync(NTP)

デフォルトで `True` なのでそのままにする。

#### Optional repositories

`multilib` を有効にする。

### インストール実行

いよいよインストールを実行します。

`Install` をクリックして、設定が書かれたJSONが出てきたら `Enter` でインストールが開始される。
時間がかかるので💩をしに行ったり、dotfiles盆栽やOverwatchでもして待つ。

インストールが終わったら、No を選択して`reboot` を打つ。

### ログインとネットワーク疎通確認

初回ログイン及びgoogleへのpingができたらArchInstallBattleは終わり。

続いてi3-wmの設定、日本語フォント、日本語入力の設定を行うが、疲れたので別記事にする。

