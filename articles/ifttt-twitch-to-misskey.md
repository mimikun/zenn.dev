---
title: "IFTTTを使用してTwitch開始を他のサービスに通知する"
emoji: "🎬"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: ["IFTTT", "Misskey", "Mastodon", "Discord"]
published: false
---

## 前提条件

- `IFTTT Pro +` の契約
- Twitchのアカウント所持
- 任意のMastodonサーバのアカウント
- 任意のMisskeyインスタンスのアカウント
- 自分が管理権限を持つDiscordのサーバ

IFTTTのFilter機能を使うため、 `IFTTT Pro +` の契約が必須。

### IFTTTでApplet作成

<!--
TODO: IFTTTのスクショを載せる
-->

### Mastodonの処理部分

自分の管理している `mstdn.mimikun.jp` を使う。

#### Filter code

```typescript
// twitch
const twitchUrl = Twitch.newStreamByYou.ChannelUrl;
const twitchGameName = Twitch.newStreamByYou.Game;
const msg = `${twitchGameName} をプレイ中！ ${twitchUrl}`;

// mastodon
const MASTODON_TOKEN = '';
const mastodon_visible = 'public';
const r_body_mastodon = `access_token=${MASTODON_TOKEN}&status=${msg}&visibility=${mastodon_visible}`;
MakerWebhooks.makeWebRequest1.setBody(r_body_mastodon);
```

### Misskeyの処理部分

現状最大手の `Misskey.io` を使う。

`Misskey.io` には独自改造が多く入っているため、他のMisskeyインスタンスでは動かない可能性がある。

また、`Misskey(not Misskey.io)` はAPIドキュメントに抜け漏れが多い、あるいは存在すらしないため、仕様変更が入り動かなくなる可能性がある。

動かない場合はソースコードを当たって確認すること。

#### Filter code

```typescript
// twitch
const twitchUrl = Twitch.newStreamByYou.ChannelUrl;
const twitchGameName = Twitch.newStreamByYou.Game;
const msg = `${twitchGameName} をプレイ中！ ${twitchUrl}`;

// misskey
const MISSKEY_TOKEN = '';
const misskeyChannelId = '';
// TODO: JSON
const r_body_misskey = `i=${MISSKEY_TOKEN}&text=${msg}&channelId=${misskeyChannelId}`;
MakerWebhooks.makeWebRequest2.setBody(r_body_misskey);
```

### Discordの処理部分

自分のコミュニティチャンネルを使う。


#### Filter code

```typescript
// TODO: write
```

### まとめ

#### Filter code

```typescript
// twitch
const twitchUrl = Twitch.newStreamByYou.ChannelUrl;
const twitchGameName = Twitch.newStreamByYou.Game;
const msg = `${twitchGameName} をプレイ中！ ${twitchUrl}`;

// mastodon
const MASTODON_TOKEN = '';
const visible = 'public';
const r_body_mastodon = `access_token=${MASTODON_TOKEN}&status=${msg}&visibility=${visible}`;
MakerWebhooks.makeWebRequest1.setBody(r_body_mastodon);

// Discord
// TODO: write

// misskey
const MISSKEY_TOKEN = '';
const misskeyChannelId = '';
// TODO: JSON
const r_body_misskey = `i=${MISSKEY_TOKEN}&text=${msg}&channelId=${misskeyChannelId}`;
MakerWebhooks.makeWebRequest2.setBody(r_body_misskey);
```

### 最後に

- 義務ッチ(原神のTwitch配信でガチャ石をもらうこと)がなくなった
- PCスペックが配信に耐えられなくなってきた

のでもう配信をしなくなってしまったが、誰かの役に立てれば幸いと思ったのでこれを残す。
