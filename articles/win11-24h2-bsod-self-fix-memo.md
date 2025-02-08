---
title: "WindowsのBSoDを自力で解決した話"
emoji: "💩"
type: "idea" # tech: 技術記事 / idea: アイデア
topics: ["windows"]
published: true
---

## TL;DR

なんか問題が起きたらとりあえずメモリダンプを解析してみると解決する

## 経緯

去年の春頃(2024年4月以降)から、ゲーム中にフリーズやプチフリーズが発生するようになった。
去年の夏頃(2024年6月以降)には、しばしばBSoDが発生するまでに悪化した。
去年の冬頃(2024年12月前後)には、ゲームを2種類連続でプレイすると確定でBSoDするようになった。

## 原因の特定, 試したこと

現象が発生する前後で実施したことはないかを考えてみた。

- NVIDIAのGPUのドライバを更新した
- Windows Insider Programに参加していた
- Windows 11 24H2にアップデートした
    - 2024年10月頃

また、どのようなゲーム及び状況で発生したか記録した。

- 原神
    - フィールド移動中
    - 七聖召喚(ゲーム内カードゲーム)中
- Overwatch
    - アンランクでゲームプレイ中
- インフィニティニキ
    - フィールド移動中
- Monster Hunter Wilds OBT-1
    - フィールド移動中
    - モンスターとの戦闘中
- Monster Hunter Wilds Benchmark
    - ベンチマーク実行中
- デスクトップ画面
    - Monster Hunter Wilds Benchmark実行後、Obsidianアプリを起動したとき

### イベントビューアーでエラーログを確認

エラーログが残っているか調べてみた。

#### エラー

```txt
Process 5900 has attempted an operation while not having exclusive control over device POWERPLAY. Process name:
```

#### 警告

```txt
アプリケーション固有 のアクセス許可の設定では、CLSID 
{6B3B8D23-FA8D-40B9-8DBD-B950333E2C52}
 および APPID 
{4839DDB7-58C2-48F5-8283-E1D1807D0D7D}
 の COM サーバー アプリケーションに対するローカルアクティブ化のアクセス許可を、アプリケーション コンテナー 利用不可 SID (利用不可) で実行中のアドレス LocalHost (LRPC 使用) のユーザー NT AUTHORITY\LOCAL SERVICE SID (S-1-5-19) に与えることはできません。このセキュリティ アクセス許可は、コンポーネント サービス管理ツールを使って変更できます。
```

と、それらしきエラーログは見つからなかった。

なんとか画面が点灯し続けるタイプのBSoD発生時にエラーコードを記録し
そのエラーコードで調べてみた。

`DPC_WATCHDOG_VIOLATION` というエラーコードだった。

## 解決方法

まずはメモリ診断ツールでメモリの問題がないか調べてみることにした。

結果は以下の通りだった。

```txt
Windows メモリ診断によりコンピューターのメモリがテストされましたが、エラーは検出されませんでした
```

次に
https://learn.microsoft.com/en-us/troubleshoot/windows-client/performance/generate-a-kernel-or-complete-crash-dump
を参考に、メモリダンプを取得、および解析してみることにした。

自分の場合、メモリダンプは以下の場所に保存されるはずだが、存在しなかった。

```txt
C:\Windows\MEMORY.DMP
```

それについてネットで調べたところ以下の記事を見つけた。

https://infra-memo.blog/windows/complete-memory-dump-setting/

メモリダンプに失敗するとイベントビューアーに以下のエラーログが残るとのことだった。

```txt
クラッシュ ダンプのページング ファイルの構成に失敗しました。ブート パーティションに ページング ファイルがあり、ページング ファイルの大きさがすべての物理メモリを含むのに十分であることを確認 してください。
```

自分も同じようにエラーが出ていた。

設定を変更しなければならないが、SSDの容量が心もとないので
この際 `C:\Windows\Minidump` のダンプでも大丈夫だろうと自己判断し、解析した。

解析にはWinDbgが必要だったのでインストールした。

結果は以下の通りだった。

```txt
11: kd> !analyze -v
*******************************************************************************
*                                                                             *
*                        Bugcheck Analysis                                    *
*                                                                             *
*******************************************************************************

DPC_WATCHDOG_VIOLATION (133)
The DPC watchdog detected a prolonged run time at an IRQL of DISPATCH_LEVEL
or above.
Arguments:
Arg1: 0000000000000000, A single DPC or ISR exceeded its time allotment. The offending
	component can usually be identified with a stack trace.
Arg2: 0000000000000500, The DPC time count (in ticks).
Arg3: 0000000000000500, The DPC time allotment (in ticks).
Arg4: fffff803e1dc33a0, cast to nt!DPC_WATCHDOG_GLOBAL_TRIAGE_BLOCK, which contains
	additional information regarding this single DPC timeout

Debugging Details:
------------------

*************************************************************************
***                                                                   ***
***                                                                   ***
***    Either you specified an unqualified symbol, or your debugger   ***
***    doesn't have full symbol information.  Unqualified symbol      ***
***    resolution is turned off by default. Please either specify a   ***
***    fully qualified symbol module!symbolname, or enable resolution ***
***    of unqualified symbols by typing ".symopt- 100". Note that     ***
***    enabling unqualified symbol resolution with network symbol     ***
***    server shares in the symbol path may cause the debugger to     ***
***    appear to hang for long periods of time when an incorrect      ***
***    symbol name is typed or the network symbol server is down.     ***
***                                                                   ***
***    For some commands to work properly, your symbol path           ***
***    must point to .pdb files that have full type information.      ***
***                                                                   ***
***    Certain .pdb files (such as the public OS symbols) do not      ***
***    contain the required information.  Contact the group that      ***
***    provided you with these symbols if you need this command to    ***
***    work.                                                          ***
***                                                                   ***
***    Type referenced: TickPeriods                                   ***
***                                                                   ***
*************************************************************************

KEY_VALUES_STRING: 1

    Key  : Analysis.CPU.mSec
    Value: 1640

    Key  : Analysis.Elapsed.mSec
    Value: 1722

    Key  : Analysis.IO.Other.Mb
    Value: 3

    Key  : Analysis.IO.Read.Mb
    Value: 1

    Key  : Analysis.IO.Write.Mb
    Value: 28

    Key  : Analysis.Init.CPU.mSec
    Value: 14531

    Key  : Analysis.Init.Elapsed.mSec
    Value: 429109

    Key  : Analysis.Memory.CommitPeak.Mb
    Value: 95

    Key  : Analysis.Version.DbgEng
    Value: 10.0.27725.1000

    Key  : Analysis.Version.Description
    Value: 10.2408.27.01 amd64fre

    Key  : Analysis.Version.Ext
    Value: 1.2408.27.1

    Key  : Bugcheck.Code.LegacyAPI
    Value: 0x133

    Key  : Bugcheck.Code.TargetModel
    Value: 0x133

    Key  : Dump.Attributes.AsUlong
    Value: 21808

    Key  : Dump.Attributes.DiagDataWrittenToHeader
    Value: 1

    Key  : Dump.Attributes.ErrorCode
    Value: 0

    Key  : Dump.Attributes.KernelGeneratedTriageDump
    Value: 1

    Key  : Dump.Attributes.LastLine
    Value: Dump completed successfully.

    Key  : Dump.Attributes.ProgressPercentage
    Value: 0

    Key  : Failure.Bucket
    Value: 0x133_DPC_gwdrv!unknown_function

    Key  : Failure.Hash
    Value: {229a5753-87e5-3d87-e2b9-50836a10c652}

    Key  : Hypervisor.Enlightenments.ValueHex
    Value: 7497cf94

    Key  : Hypervisor.Flags.AnyHypervisorPresent
    Value: 1

    Key  : Hypervisor.Flags.ApicEnlightened
    Value: 1

    Key  : Hypervisor.Flags.ApicVirtualizationAvailable
    Value: 0

    Key  : Hypervisor.Flags.AsyncMemoryHint
    Value: 0

    Key  : Hypervisor.Flags.CoreSchedulerRequested
    Value: 0

    Key  : Hypervisor.Flags.CpuManager
    Value: 1

    Key  : Hypervisor.Flags.DeprecateAutoEoi
    Value: 0

    Key  : Hypervisor.Flags.DynamicCpuDisabled
    Value: 1

    Key  : Hypervisor.Flags.Epf
    Value: 0

    Key  : Hypervisor.Flags.ExtendedProcessorMasks
    Value: 1

    Key  : Hypervisor.Flags.HardwareMbecAvailable
    Value: 1

    Key  : Hypervisor.Flags.MaxBankNumber
    Value: 0

    Key  : Hypervisor.Flags.MemoryZeroingControl
    Value: 0

    Key  : Hypervisor.Flags.NoExtendedRangeFlush
    Value: 0

    Key  : Hypervisor.Flags.NoNonArchCoreSharing
    Value: 1

    Key  : Hypervisor.Flags.Phase0InitDone
    Value: 1

    Key  : Hypervisor.Flags.PowerSchedulerQos
    Value: 0

    Key  : Hypervisor.Flags.RootScheduler
    Value: 0

    Key  : Hypervisor.Flags.SynicAvailable
    Value: 1

    Key  : Hypervisor.Flags.UseQpcBias
    Value: 0

    Key  : Hypervisor.Flags.Value
    Value: 38408431

    Key  : Hypervisor.Flags.ValueHex
    Value: 24a10ef

    Key  : Hypervisor.Flags.VpAssistPage
    Value: 1

    Key  : Hypervisor.Flags.VsmAvailable
    Value: 1

    Key  : Hypervisor.RootFlags.AccessStats
    Value: 1

    Key  : Hypervisor.RootFlags.CrashdumpEnlightened
    Value: 1

    Key  : Hypervisor.RootFlags.CreateVirtualProcessor
    Value: 1

    Key  : Hypervisor.RootFlags.DisableHyperthreading
    Value: 0

    Key  : Hypervisor.RootFlags.HostTimelineSync
    Value: 1

    Key  : Hypervisor.RootFlags.HypervisorDebuggingEnabled
    Value: 0

    Key  : Hypervisor.RootFlags.IsHyperV
    Value: 1

    Key  : Hypervisor.RootFlags.LivedumpEnlightened
    Value: 1

    Key  : Hypervisor.RootFlags.MapDeviceInterrupt
    Value: 1

    Key  : Hypervisor.RootFlags.MceEnlightened
    Value: 1

    Key  : Hypervisor.RootFlags.Nested
    Value: 0

    Key  : Hypervisor.RootFlags.StartLogicalProcessor
    Value: 1

    Key  : Hypervisor.RootFlags.Value
    Value: 1015

    Key  : Hypervisor.RootFlags.ValueHex
    Value: 3f7

    Key  : Stack.Pointer
    Value: ISR


BUGCHECK_CODE:  133

BUGCHECK_P1: 0

BUGCHECK_P2: 500

BUGCHECK_P3: 500

BUGCHECK_P4: fffff803e1dc33a0

FILE_IN_CAB:  020625-17000-01.dmp

DUMP_FILE_ATTRIBUTES: 0x21808
  Kernel Generated Triage Dump

FAULTING_THREAD:  ffffba0841f69080

DPC_TIMEOUT_TYPE:  SINGLE_DPC_TIMEOUT_EXCEEDED

BLACKBOXBSD: 1 (!blackboxbsd)


BLACKBOXNTFS: 1 (!blackboxntfs)


BLACKBOXPNP: 1 (!blackboxpnp)


BLACKBOXWINLOGON: 1

CUSTOMER_CRASH_COUNT:  1

PROCESS_NAME:  MonsterHunterW

STACK_TEXT:  
ffffd181`1f1d7cd8 fffff803`e1175139     : 00000000`00000133 00000000`00000000 00000000`00000500 00000000`00000500 : nt!KeBugCheckEx
ffffd181`1f1d7ce0 fffff803`e1167b71     : fffff803`e1dc33a0 00000000`00000000 00000000`00000002 00000000`0000de5b : nt!KeAccumulateTicks+0x589
ffffd181`1f1d7d50 fffff803`e106ebfb     : 00000002`1225a250 00000000`00000000 ffffba08`0000000b ffffba08`2f74c160 : nt!KiUpdateRunTime+0xc9
ffffd181`1f1d7dd0 fffff803`e10702ad     : ffffba08`2f74c160 00000000`00000000 ffffba08`2f74c210 fffff803`e1d8dcf8 : nt!KeClockInterruptNotify+0x96b
ffffd181`1f1d7f50 fffff803`e147affe     : ffffba07`a210c402 ffffba08`2f74c160 fffff58d`50bfe4a0 00000002`1228b5c1 : nt!KiCallInterruptServiceRoutine+0x2ed
ffffd181`1f1d7fb0 fffff803`e147b80c     : 00000030`00000246 00000040`e125dda5 00000000`00000000 fffffbff`ffffffff : nt!KiInterruptSubDispatchNoLockNoEtw+0x4e
fffff58d`50bfe4a0 fffff803`e1084262     : fffff803`e10845b0 fffff58d`50bfe858 00000000`0007410c ffffba07`a210c400 : nt!KiInterruptDispatchNoLockNoEtw+0x3c
fffff58d`50bfe638 fffff803`e10845b0     : fffff58d`50bfe858 00000000`0007410c ffffba07`a210c400 fffff58d`50bfe710 : nt!RtlpCSparseBitmapUnlock+0x2e
fffff58d`50bfe640 fffff803`e1085f82     : fffff58d`50bfe710 ffffba08`62000000 ffffba08`00000001 fffff803`e107f326 : nt!RtlSparseArrayElementAllocate+0x74
fffff58d`50bfe690 fffff803`e123fe9d     : ffffba08`62000000 fffff803`e1c68338 fffff58d`50bfe730 00000001`00000000 : nt!RtlpHpVaMgrRangeCreate+0x46
fffff58d`50bfe6e0 fffff803`e123fd79     : 00000001`00200000 ffffba08`62000000 00000001`00100000 00000000`00000002 : nt!RtlpHpVaMgrAlloc+0xd1
fffff58d`50bfe760 fffff803`e123fcc1     : 00000001`00100000 fffff58d`50bfe820 fffff58d`50bfe868 00000001`00000000 : nt!RtlpHpVaMgrCtxAlloc+0x49
fffff58d`50bfe7a0 fffff803`e13c7879     : ffffba08`2f200000 00000000`00000082 00000000`00000000 00000001`00000000 : nt!RtlpHpAllocVA+0x12d
fffff58d`50bfe830 fffff803`e149e468     : 00000000`00000000 00000001`00000000 00000000`00000082 00000001`00000000 : nt!RtlpHpLargeAlloc+0x131
fffff58d`50bfe910 fffff803`e100872c     : ffffba08`2f200000 00000000`00000000 fffff803`e1c15380 00000000`00000082 : nt!RtlpHpAllocateHeap+0x4944a8
fffff58d`50bfe990 fffff803`e1008492     : 00000000`00000000 ffffba08`3b202090 ffffffff`44435747 00000000`00000000 : nt!ExAllocateHeapPool+0x22c
fffff58d`50bfeac0 fffff803`e1935189     : 00000000`00000082 ffffba08`3b202090 00000000`00000000 0001fe00`1e000000 : nt!ExpAllocatePoolWithTagFromNode+0x52
fffff58d`50bfeb00 fffff803`e19350b7     : ffffffff`fffffffe 00000000`00000000 00000000`00000010 00000000`00000246 : nt!ExAllocatePool2+0x99
fffff58d`50bfebb0 fffff803`7572424e     : ffffba08`3b22c7f0 00000000`00000000 00000000`fffffff5 ffffba08`3b22c7f0 : nt!ExAllocatePoolWithTag+0xa7
fffff58d`50bfebf0 ffffba08`3b22c7f0     : 00000000`00000000 00000000`fffffff5 ffffba08`3b22c7f0 00000000`00000000 : gwdrv+0x424e
fffff58d`50bfebf8 00000000`00000000     : 00000000`fffffff5 ffffba08`3b22c7f0 00000000`00000000 fffff803`757225b7 : 0xffffba08`3b22c7f0


SYMBOL_NAME:  gwdrv+424e

MODULE_NAME: gwdrv

IMAGE_NAME:  gwdrv.sys

STACK_COMMAND:  .process /r /p 0xffffba084d0cc080; .thread 0xffffba0841f69080 ; kb

BUCKET_ID_FUNC_OFFSET:  424e

FAILURE_BUCKET_ID:  0x133_DPC_gwdrv!unknown_function

OSPLATFORM_TYPE:  x64

OSNAME:  Windows 10

FAILURE_ID_HASH:  {229a5753-87e5-3d87-e2b9-50836a10c652}

Followup:     MachineOwner
---------
```

## 結果

`gwdrv.sys` が原因であることがわかった。

この単語で検索してみると

- GYGABYTE製のドライバ
- Glasswireという無料ソフト

が原因である可能性があるという情報が見つかった。

BTOで買ったパソコンなので、GYGABYTE製を使用しているかどうかは不明。
ただ、Glasswireはインストールしているので、これが原因である可能性が高い。

Glasswireをアンインストールして、再度ゲームをプレイしてみることにした。

そうしたら、BSoDは発生しなくなった。
連続で違うゲームをプレイしてもBSoDは発生しなかった。

## まとめ

根本的な解決方法、原因は不明なままだが
2025年2月8日 21:00～23:00, 24:00～01:00 と続けてゲームをプレイして確認したところ
BSoDは起きていないので解決したことにする。

## 学び

- Windows はむずかしい

