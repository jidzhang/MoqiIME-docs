# AGENTS.md — MoqiIME 项目总纲

> 面向在本目录工作的 AI agent。**最新：`61-交接-2026-11-07-三天对标启动.md`（**发版推迟三天全面对标微软拼音（用户拍板，机器交 agent 三天）：当日最重发现=纠错配置被绑在 gram 检测 if 里+50MB 门槛把 std/lite/wiki 三档随包 gram 全挡门外——三档用户 gram 从未加载+纠错整块不存在（"运行了一个寂寞"）；修复=纠错配置无条件写入+门槛 50MB→0（1KB dummy 也能激活通路）；纠错韵母盲区（bug#26）窗口参数化已收编（scan_window=4，六门全绿）；Lite 编译期裁剪落地（57）；glog 默认 ERROR；移植性原则 14（零机器路径，vcvars-detect.bat）；两家用户目录已清到初始态；60-计划=三天测试矩阵（A 准确率/B 容错/C 性能+黑盒对照），Day1 词典层 bigram 挖掘（59-计划）/Day2 排序层归因/Day3 回归打包；发版门=案例集逐案例不输微软；⚠️发版包必须含门槛0（引擎哈希≠DC26A7A2）**）；上一=`57-交接-2026-11-06-Lite版编译期裁剪.md`（**Lite 版编译期裁剪落地+两查证：MOQI_LITE 双配置（daemon 剔 AI/云剪贴板/WebDAV/剪贴板监视四源，DaemonLiteStubs 空桩——配置存在也无执行路径，AI/云热键恒不触发）；菜单=用户定稿（四基础开关/输入方案/重新部署方案/输入状态固定/外观/输入设置/打开文件夹/参与讨论），lite_menu_test 契约 4/4，全量版零变化（ctest 10/10×2）；lite 包=全量 stage 换 lite daemon（29.4MB）+CI 同步；五包 06:5x 全绿核验。附：跨提交上下文重测 Δ_ctx+87.2（当前产品栈健康，探针资产归位 eval-workspace\cont-poc，J 盘=原 F 盘）；混合连打调序 bigram 白盒 A/B 开=62.5% 关=64.0%→**默认关是正确设计非缺陷，56 号"缺省断链"疑虑撤销**；--noFastPath 是热特性 A/B 必要开关；管道探针必须忠实 TSF 帧字段（嵌套 keyEvent+INIT+isKeyboardOpen）**）；上一=`56-交接-2026-11-06-雾凇兼容终验与图标根治脚本审查.md`（**当日晚间五线全收：①雾凇整包兼容真机终验两向全过（清空+复制+部署→雾凇；清空+部署→回白霜默认——Rime 生态兼容闭环，复制必须平铺、锁定文件不清无害）；②bug#25 图标在普通 Win32 进程（wezterm/TC/记事本）反复消失根治=pushLangBarUpdateForIndicator 删 AppContainer 门控（53 的"Win32 指示器必自拉"假设被证伪），自动化验证 9 推送+GetInfo 跟随；③bat/ps1 全量审查 13 项（8 修 5 删：ISCC 注册表探测、_all_in_package 引号 pwsh7 炸、Z: 死脚本×2、pgo 三件套等）；④日志整理第一批（tsf-key-guard 每行 [exe#pid] 归因、glog 基名 rime-daemon/rime-tsf 按角色、AGENTS gram 口径同步）；⑤PGO 构建链三跑终通（x86 训练宿主必须与 32 位 pgort 同目录——LoadLibrary 不搜 DLL 自身目录；--from-x86 模式）但**四场独立 A/B（含重启复测+perkey 画像重训）PGO 每键稳定慢 7~10%（110.4/110.5/108.2/106.9% 全同向，画像只影响幅度不改方向）→ 终局 plain 随 2.0.0 发版（x64 DFF5613C/x86 11FFD83E）**，PGO dll/档案/构建链保留（换编译器或改热点后再评）；五包 2.0.0 全绿（plain dll）+本机已装机；菜单文案定稿"重新部署方案/在线更新方案"**）（**推送前 /code-review max --fix 复审 53 轮未推代码（moqi-im-windows 9 提交+libIME2 2 提交）：15 项发现 12 处修复 5 条上报**——最高危=LocalBehaviorPatch grammar_penalty 残留裸 operator[]，非对象 local_behavior.json 抛 LogicError、RimeCore 无 catch，daemon 启动即崩（修=非对象走默认罚分）；nightly/release 构建步缺 -WithoutGram 先于 gram 下载必 throw（补参，两段式保持）；isAppContainerProcess static 缓存；图标推送 buttonsChanged 门控（bug#24 路径实机需回归——**56 注：已回归并再修，见 bug#25**）；CreateDirectoryW→ensureDirectoryRecursive；-WithoutGram 优先于 -GramPath；残留裸 get 迁 jsonStringOf；几何测试补断言（24/24）；上报未修=LocalRerank/ime.json 非对象抛异常（待全仓扫）、quote-pair 日志无 AppContainer 回退、isAppContainerProcess 两版分叉（**56 注：TSF 侧副本已随 bug#25 修复删除**）、取证路径手拼 USERPROFILE、**libIME2 指针 715c11c 未推=推送顺序必须先 libIME2 再 moqi-im-windows**；门=双架构零警告+几何 24/24；改动未提交等实机验证）；上一=`53-交接-2026-11-06-便笺图标指示器不拉取根治.md`（便笺"中"图标消失真根因=输入指示器对 AppContainer 进程（便笺等 UWP）的焦点线程不主动拉取语言栏项——按钮注册成功也不画，手动切一次输入法能显示=强制刷新有效；修=TokenIsAppContainer 判定+updateLanguageButtons/onActivate/onSetThreadFocus 三点推 OnUpdate(TF_LBI_ICON|TF_LBI_STATUS)（fca346f）；52 版 keep/cached-restore/selfheal 实验代码整体丢弃（备份 F:\work\IME\langbar-52-backup\），基线回 6457b3c 叠最小修复；保留 AppContainer 日志回退+打包 gram 固定（7d566d8）；用户真机确认"可以了"+四步往返截图全过；本地已提交未推送未发版；遗留=UWP CreateProcess err=15623 起 daemon 失败未修）；上一=`52-交接-2026-11-06-语言栏便笺图标与打包.md`（便笺双进程/双线程致摘项空窗+cached restore 顶掉仍在项+UWP CreateProcess err=15623 致 buttons=0；改焦点切换不摘项、仅补挂未注册、线程退出清引用、still-on-bar 跳过 restore + _all_in_package 漏 gram 固定 + 盘符可移植约定；其中代码实验已弃、gram 固定与日志回退由 53 收编入库存活）；上一=`51-交接-2026-11-06-代码评审与加固.md`（**/code-review max --fix 对未推送四提交全管线评审：10 角度并发+逐项验证+补漏，15 项发现全修——**最高危=非对象 JSON（[]/5）让 jsoncpp get/isMember 抛 LogicError、daemon 启动即崩（三处解析补 isObject 守卫，可执行实证）；desync 测试曾对真用户词典跑真引擎、11-05 23:14 实证发生过 LevelDB RepairDB（修=MOQI_USER_DATA_DIR 重定向接缝+ctest 注入临时目录+未设即拒跑，隔离已实证真词典 mtime 未动）；明文密码迁移不清 json（迁移后立即重写抹掉）；downloadClip/deleteClip 补出站总闸**；测试质量（几何零尺寸断言空转实化/cloud_config 去真机依赖=egressRootOverride 接缝/dispatch 去 4 组重复）；清理（错误文案导出常量+字节锁/路径助手合一/流水账注释删/指针提交拆分 680d6a4+b3a6079）；门=ctest 10/10（cloud 66/dispatch 29）+双架构零警告；**遗留：RimeCore/main 其它 jsoncpp 加载器同款非对象抛异常模式待全仓扫**；仍未推送未发版**）；上一=`50-交接-2026-11-05-单元测试补齐与ctest接线.md`（**单元测试 197→310 断言（49 待办的测试加厚首批落地）：cloud_config 59（DaemonCloudConfig 六入口 rootOverride 接缝+DPAPI 回环+明文密码迁移+出站总闸+零网络校验路径）/候选窗几何 21×双架构（inputRectScore+工作区夹取抽出 InputRectScore.h/CandidateClamp.h 纯函数化）/菜单分发 33（模式开关/越界号/主题段上界/竖排回横排 perRowRaw 兜底/222 冲突）；**ctest 三缺陷=moqi-daemon 缺 enable_testing（此前 add_test 全空转、"ctest 绿"实为直跑 exe）/JSONCPP_TESTS 错名（正名 JSONCPP_WITH_TESTS，曾把 jsoncpp 自带 3 测试挂进套件）/desync 测试漏设 g_daemonBackendDir 引擎必初始化失败**，修复后 ctest 10/10 绿（desync 首次真跑 1.7s 过）；x64+x86 全量零警告；四仓只本地 commit（libIME2 58c8b25/moqi-daemon ba8d9ff/moqi-im-windows a600f04+文档仓）**未推送未发版**等用户验收；观察项=testConnection 无锁读 cfg_/detached 线程退出窗口/isLocalCommandId 与 handleCommand 段内未映射号语义差**）；上一=`49-交接-2026-11-05-真机终验与全仓提交.md`（**用户真机终验双过：Word 快打 1. ✓ + 便笺/桌面切换图标 ✓（bug#20/#21/#22 全部关闭）；三步门后四仓提交=moqi-daemon `69b1868`（原生直通+DigitPassthrough 纯函数+digit 14/proto_framing 15 断言+帧协议 16MB 上限+菜单文案 golden）、libIME2 `1db8209`（AddItem 自愈+HRESULT 上抛+clearLangBarButtons 断引用环）、moqi-im-windows `3254858`（按钮注册表进程级+图标自持+心跳日志+protocol 34）、文档仓五份交接+bug 盘点（47）+全维测评（48）；40 格 suite-v3：d1 base native 94.30 逐位复现=排序零回归，baseline-v2.0.0-std 已落盘为发版门新锚；20 轮焦点切换句柄零增长；待办=推送+tag v2.0.0 CI 五档+测试加厚（活代码 25752 行 vs 测试约 4% 覆盖，下一批候选=MenuCore 命令分支/CloudConfig xorMask/buildLocalBehaviorPatch/inputRect 几何）**）；上一=`46-交接-2026-11-05-代码通读自查.md`（**用户定向"通读活代码找缺陷"：当日改动逐行自查修掉 3 个真缺陷——①tryNativeDigitPassthrough 用滞后一拍的 keyComposing_，空格刚上屏仍 true→"打完中文紧跟数字"被误判组字→数字走 IME 代插→bug#20 在中文后起列表场景复活，修=直通与旧兜底块都现查 currentState（smoke_cn_digit 6/6 过）；②语言栏按钮表挪进 TextService 后成引用环（按钮持 ComPtr<TextService>）→线程退出整图永不析构每线程漏一份，修=clearLangBarButtons 于 onDeactivate 统一清两级表；③nativeDigitPassthroughPending_ 滞留误放行加固。另 bug#21 根因修正：问题机日志实证同秒 addButton 成对出现=每 Client 一套注册表重复 AddItem、windows-mode-icon 固定 GUID 被 msctf 互相顶掉、resetTextServiceState 断线即 RemoveItem 全部按钮，真修=注册表进程级唯一+Client 不再持有/摘除按钮；全测试门绿+装机 18:42+冒烟 4/4+6/6**）；上一=`45-交接-2026-11-05-Word丢句点彻底修复.md`（**bug#20 第三次修复=真修好：本机装 Word 2016 真机复现（快打 `1. 2. 3.` 只剩 `. . `），根因=数字与句点都由 IME 经 ITfInsertAtSelection 编辑会话代插、Word 自动编号/格式转换窗口期静默丢弃这类会话（微软/谷歌数字根本不碰 IME 故免疫）；修法=daemon `tryNativeDigitPassthrough` 无组字/无修饰键/非 T9 时数字与"紧跟直通数字"的句点直接 returnValue=0 交应用原生插入，两阶段 pending 一致，T9 方案自动关闭；验收=Word 18 格全 PASS 且与微软拼音逐格一致 + 记事本冒烟 4/4**）；上一=`44-交接-2026-11-05-语言栏图标丢失根治.md`（**bug#21 中英图标反复消失根治：根因=图标原由进程级 static 缓存持有、Client::onDeactivate 调 clearIconCache→DestroyIcon，同进程仍存活的按钮拿到悬空句柄、GetIcon 的 CopyImage 返回 NULL，且 setIconFile 只在路径变化时重载→进程内不可逆、每切焦点复现（"只有一个显示/重启也没用"全对得上）；修法=图标改按钮自持 ownedIcon_ + 删缓存 + 无图标时重试加载/保留旧图标/记日志 + AddItem 返回码上抛与陈旧项自愈 + daemon 图标目录按"真有 ico"判定**）；上一=`42-交接-2026-11-05-跨提交上下文PoC.md`（**跨提交上下文 PoC 全指标过线：万象 context_reorder.lua 移植件（data-cont-poc）F Δ_ctx +79.8 / M 混拼 +85.1、两轮逐位一致；librime 原生 commit 历史通道 +7.4 已分离（contextual_suggestions 关掉归零）；守卫 d1/d5 零回归 d3 噪声带内；延迟优化后 +0.3~0.6ms 贴线待真机；三坑修复=user_table 白名单（混拼 33→94.7）/LevelDb pool/X11 键码 0xFF0D；待用户拍板进 Step5 产品化（prebuild 补丁）**）；上一=`41-交接-2026-11-05-LLM词库扩容试点.md`（**LLM 扩词库试点 NO-GO：DeepSeek 流水线优秀（thinking disabled 66 批 48s/29532 tokens/零幻觉损伤）但杠杆饱和——d3 考卷词典覆盖 1534/1611（frost+v1），缺口 77 个全是新闻专名；四臂 A/B/C/D 全部 ±0.35 噪声带；零语料 LLM 词条 w=2000 无害（可复用）；d3 剩余缺口=排序+碰撞→转跨提交上下文（37-计划）**）；上一=`40-交接-2026-11-04-万象词库对比.md`（**万象词库预研关闭：作者自有词库实况（jichu 149 万条/CC-BY-4.0/dict-nightly 持续发）+ 12 格 A/B 实测万象词库全面落败（d3 −10.5~−12.2、d1 −1.8~−3.0、d5 −1.35~−5.08，wx/es 双 gram 语境一致）；机理=他家清理掉功能词组合（moqi_bigram 只收 44.4%）+ 频次直出无人工校频；权重恒比 3.1 排除标定混杂；词库不换，单册增量合入走 prebuild**）；上一=`39-交接-2026-11-04-五包通用引擎.md`（**五包通用引擎：x86 daemon + 单份 rime.dll + x86/x64 双薄 DLL；32/64 位 Windows 同一个包；32/64 记事本实测；daemon 84MB；五包 22:23-22:33**）；上一=`38-交接-2026-11-04-单引擎架构与雾凇兼容.md`（**架构收敛：放弃 64 位进程内引擎，单 C++ daemon 承接 32/64/UWP；用户目录=%APPDATA%\Moqi\Rime；雾凇整包按官方三步实测可用（17 bin/双拼切换）；audit 28/28；A+B 瘦身每包 -4.52MB；五包 18:40-18:48**）；上一=`37-计划-跨提交上下文-2026-11-05.md`（**明日开工执行清单**：跨提交上下文 PoC——万象 context_reorder.lua 原件在 F:\work\IME\ms-anatomy\refs\，Step0 冻结确认→Step1 读透→Step2 eval 接线→Step3 测 Δ_ctx→Step4 延迟/守卫→Step5 产品化；验收 Δ_ctx>0、延迟≤0.5ms、d1/d3/d5/d7 零回归；含本轮全部资料/工具/踩坑清单）；结果=`36-报告-续打对标-2026-11-04.md`（**F/M/T 三模**：F 可达项微软 **Δ_ctx +22.9（CI 15.7~30.7）**、M 混拼 **+11.3**（对照 0）、墨奇两模均 **0**（F 可达 27/59 仍不上浮）；T 首字母邻键错型两家 0/59 可达、不可纠正；数据/脚本/60 轮结果归档 bench 仓 `cont/`（64a150c）；M 纯首字母硬靶词可达性极低（MS 0/59），需 M2 语料）；方案=`35-方案-续打对标测试方案-2026-11-04.md`（A/C/B 拆学习vs可见上文、reset 干净门、4 轮交叉、cont_pairs_v2 129 项；§十一多场景 F/M/J/T、§十二尼泊尔读音缺陷）；长期路线=`30-方案-完全离线对标微软拼音-2026-11-02.md`（阶段 1 已写"跨提交上下文第一优先级"定案）；`34-交接-2026-11-04.md`（**微软四件套解剖 v0**：动态词频 1~2 次选中翻序写 IH.dat、自造词=修正驱动非频率（UDL）、错句零学习、跨提交调频无/极弱；34 锚点数字作废）；`33-审查-Go替换对照-2026-11-04.md`（代码审查修 8 P0+一批 P1；audit 24/24 + webdav 6/6；五包 2.0.0 重打）；`31-交接-2026-11-03.md`（Go 退休收尾 + 2.0.0）；`28-交接-2026-11-02.md`（5b/5c 架构）；`29-交接-2026-11-02.md`（方向定案）；`27-交接-2026-11-02.md`（语言栏三根因+契约测试；5a Daemon 当家）。主线回归入口=准确性/纠正/基于上屏字的候选调整（用户 11-02 定向）；长句续研=`25-报告-长句前缀稳定性-2026-11-01.md`**；
> 交接文档按日期递增（03-交接-2026-10-18.md 有目标/技术手段/环境坑的完整版），
> 最新结论以日期最大的为准；每个实验或修复完成后必须回写当日交接，
> 实验明细追加到 `moqi-ime/report/2026-10-16-baseline.md`。本文只定原则、目标和路线。

## 项目是什么

墨奇输入法（Windows TSF 中文拼音输入法），fork 自 gaboolic 的开源实现：

```
TSF 前端 moqi-im-windows (C++) ──x64──> 进程内引擎 librime (rime.dll)
                                └─x86──> MoqiDaemon.exe --serve（管道 RPC，C++）
                                         └→ rime.dll + plugins/librime-octagram
数据：moqi-ime/input_methods/rime（rime-frost 子模块，GPL-3.0，不直接改）
```

（2026-11-03 起 Go 后端 MoqiIME.exe 已退休：运行链与安装包都不再带它；
`moqi-ime` 仓库只剩词库/数据构建工具（rime-prebuild）与历史代码。）

四个产品/工具 git 仓库，origin=jidzhang（我们的 fork），upstream=原作者。
例外（2026-10-20）：libIME2 原来 origin 直指 gaboolic（无写权限），已 fork 出
jidzhang/libIME2 作 origin，原地址保留为 upstream（用于跟上游同步）。
许可证归属见各仓库 NOTICE.md。

**根目录本身是一个私有文档仓**（`jidzhang/MoqiIME-docs`）：交接文档 `0X-*.md` +
`AGENTS.md` + `bug-list.txt` 等。四个子仓库与 `eval-workspace/`（约 17GB 素材）都在
`.gitignore` 里排除。**改完交接文档/本文件要提交推送**，否则只存在本地。

## 目标

**真实打字场景 top-1 准确率达到 70%。**
"真实打字场景" = d3 混合连打（前词全拼 + 后词首字母，一次空格上屏）。
当前 67.90（2026-10-26，prod 栈 ime，白盒读音口径修复+组句配置纠偏后；历史基线
见 `eval-workspace/baseline-v1.6.0.txt`）。汉语拼音逻辑上可能到不了 70%，
**穷尽手段后可停**，不硬凑数字。

## 总体原则（硬约束，违反即返工）

1. **优先级：算法第一 > 词库 > gram**。据测评结果可调，但改算法前必须慎重：
   先显微镜复现（少量输入看候选），再 2000 词对 A/B，守卫维度（d1/d3/d5）零回归才采纳。
   慎重 ≠ 保守：算法质量是核心价值，好算法要经得住各种场景考验——
   遇到新场景（错字/混合/极端输入）先建测评维度，再动算法。
2. **简拼不死磕**：d6 整句简拼按"可用即搁置"；简拼优化不得拖累全拼输入。
3. **一切以测量为准**：修 bug 先写复现，加功能先定成功标准，改完必须验证。
   主观判断（"这个词应该排第一"）不算证据；**没实测的部分必须在文档里标明"推断"，
   不得与实测混写**。
4. **不逐词打补丁**：用户反馈个例（如 diam→地安门）时，先分析算法决策机制，
   找一般化修法，而不是调两个词的优先级。
5. **数据与素材一律放项目内**（eval-workspace/），禁用 %TEMP%（会被清理工具删除）。
6. **上游文件不直接改**：rime-frost 子模块的产品级数据改动走
   `moqi-ime/cmd/rime-prebuild` 打包期补丁（幂等，有先例：简拼补丁、Shift_R 对齐）。
7. **快速测试修正阶段不频繁提交推送**：攒一批按主题分 commit，不带多余署名。
   **提交时机 = 用户实机验证通过之后**；提交前把三个仓库 + 子模块的 `status` 全查一遍，
   确认没把 `eval-workspace` 的调试产物/临时脚本带进去。
8. **有歧义列出选项让用户选**，不要静默选一个；有更简单的方案主动提。
9. **每个实验/修复完成即回写文档**（03-交接 + report 运行日志），这是交接给
   全天候 agent 的前提——文档滞后等于工作丢失。
10. **子模块先看分支再改**：`libIME2` 等子模块可能停在 detached HEAD，在那里 commit
   会游离于 master 之外（外层只记 SHA，从 `git status` 看不出）。改之前跑
   `git branch --show-current`，输出为空就先 `checkout master`；发现游离提交用
   `merge --ff-only` 接回分支，不要 `reset`。
11. **输入延迟先分环境还是代码**：先看生产慢日志（`RIME slow`，阈值 30ms）和同时段
    系统资源，再决定是否动引擎。判据：① 修饰键（Ctrl/Shift/Alt/Backspace）也慢
    → 调度/缺页/锁等待，不是算法；② 慢键与客户端 init/close 聚集 → 客户端 churn；
    ③ 慢键与 CPU/内存低谷重合 → 资源争抢。本机只有 4 vCPU/8GB，ZCode 这类 Electron
    程序一开就是 45 进程/7GB，先排查它，别急着改 librime。
12. **界面细节优先简单可维护**：能用普通 GDI 一次画完的，不引入分层窗口/自绘引擎/
    额外依赖；用户对观感的要求是"干净、不刺眼"，不是像素级特效。候选窗口四角统一
    按直角处理（2026-10-21 定案）。
13. **提交三步门（2026-10-24 用户定，每次 commit 前依次过，全绿才提交）**：
    ① **保守 code-review**：逐行看 diff。重点=行为变化面、资源配对（句柄/GDI/
    COM 引用/锁/文件）、并发与重入、编码转义、边界条件；无关改动拆出去单独提交；
    有疑点就降级为"待查"而不是放行。
    ② **simplify**：自查一遍能否更简单——删冗余分支、合并重复逻辑、注释只留
    约束性说明（为什么这么做），删掉讲"我改了什么"的注释。
    ③ **核心逻辑门**（按改动面选最小够用的，不是每次全跑）：
    - Go 后端：`go build` + `go test ./...`（对照存量失败清单，无新增失败即可）；
    - TSF DLL / libIME2：x64 与 x86 全量编译零错误、零新增警告；
    - 触碰输入/组字/候选路径：显微镜 dump 抽查（常用输入与改前逐位一致）
      + suite 守卫格（d1/d3，阈值按测评纪律）；
    - 资源/生命周期类：对应压测工具出数（如 eval-workspace/mem-audit/stress2）；
    - 评测纯工具改动：跑一次已知答案的用例即可。
    review 与门的结论随实验一起回写当日交接。此门与"用户实机验证通过才提交"
    （快速测试修正阶段纪律）叠加生效：先过门，再等验证，最后提交。
    **发版门＝十分钟轻门（2026-10-24 用户定，全矩阵太重轻易不敢跑）**：
    ① 守卫三格 d1/d3/d5 只跑 prod 臂（约 5 分钟）；② bench 白盒
    zhihu120+words234 单臂 gram-on（约 3 分钟）；③ 静默装+首键冒烟（约 2 分钟）。
    对比对象＝上一发版存的基线快照（发版时把轻门输出存 `baseline-vX.Y.Z`，
    下次 diff，退步即挡）。40 格全矩阵降级为"重大改动/出现疑点/大版本"才跑。
14. **脚本与工具零机器路径（2026-11-07 用户定，可参与性前提）**：活脚本/
    工具/文档不得出现机器专属绝对路径——VS 定位走 `librime\vcvars-detect.bat`
    （vswhere 探测任意版本），第三方工具（protoc 等）走环境变量+用户缓存+
    FetchContent 兜底，eval 工具由 exe 所在位置或 `$BASH_SOURCE`/`__file__`
    推导根目录（google-input-tools 等素材仓=项目根的兄弟仓）。例外：安装
    目录约定（`C:\Program Files (x86)\MoqiIM`）与 vendored 第三方依赖树不
    改；历史交接文档不回写。遗留：eval/cmd/probe-{autopen,autopen2,
    calibrate,jianpin} 四个十月的调试遗物仍含 Z: 死路径（待拍板删除）。

## 路线（按优先级）

1. **d3 → 70% 主线**
   - 词库：补高频口语 bigram（gold 词对 24.2% 在词典中完全缺失：是的/的是/的人…，
     权重公式 min(2.2×语料频次, 30000) 已验证），走 prebuild 打包期合入。
   - gram：essay-bgw 已就位，可试自训域适配 gram（subs/news 语料）。
   - 算法：句子候选 quality 公式定档（sentence_quality_boost 扫参，门已留好；
     10-26 实证罚分 -4/-12 在 d5 上无差异，d3 边际效应待干净口径复扫）。
2. **容错层（正式待办，用户 2026-10-18 确认）**：换位类错字 top-1 仅 23%
   （无错字 89.8%）。换位纠错边已实现并进产品（librime
   `translator/enable_transpose`，credibility −8 收编 T 23.4→51.6，prod yaml 已开）；
   漏字边与门控方案实测否决，不再跟进。A/B 工具 `eval-workspace/probe-typo.exe`。
3. **体验**：~~首切延迟~~（2026-10-20 已解决：librime 消除 melt_eng/radical_pinyin
   schema 循环依赖 + 启动器启动即预热后端；用户实测"几乎没有卡的感觉"）。
   ~~`filterKeyDown 27.6ms/键` 口径~~ → 2026-10-21 定案：旧探针提交空格时没走
   `filterKeyDown`，旧数全部作废；实测后端 **0.40ms/键**，主因是 DLL 每 RPC 的
   2ms 轮询（每键 4 次 RPC ≈ **11.4ms**）。DLL 已改 overlapped 事件读
   （≈ **0.73ms/键**），**2026-10-21 09:41 实机装包验证通过并已提交**；证据见
   `05-交接-2026-10-20.md` 第八节、`moqi-ime/report/2026-10-16-baseline.md` 十二~十五节。
   候选体验（2026-10-21）：默认总候选 **7**、每行 **9** 不变（`defaultStyle().CandidateCount`、
   `candidateCount()` 兜底）；候选窗口四角改 **直角**（去掉 `CreateRoundRectRgn`/`FrameRgn`，
   整块 `FillRect` + `FrameRect`），**不做分层窗口抗锯齿圆角**——用户明确"简单好维护就行"。
   首候选高亮四边贴边（2026-10-21 定案）：行首贴左边、右侧停在 1/2 候选间距中点、
   首行/末行贴上下边、单列也贴；候选默认 7、每行 9。
   **数字/小数点直通**（2026-10-21）：无组字时数字键直接上屏，紧跟数字的 `.` 上半角点
   （对齐微软拼音，用户实报"按了 4. 光标停在 . 上面"）；组字中数字仍选候选；
   T9 数字九宫格除外（数字是输入）。实现见
   `moqi-ime/input_methods/rime/patches/moqi_plain_number.lua`（打包期补丁，
   不直接改 rime-frost 子模块）。
   **以词定字 `[` `]` 保留**（2026-11-05 用户确认）：组字中 `[` 取当前候选
   首字、`]` 取末字（候选为单字时直接上屏）——替代用户"打词再删"的工作流，
   有真实价值（fama+`[`→砝）；因此组字中 `[` `]` **不是**顶屏标点，想打全角
   【】先空格提交再打（非组字时 `[`→【 走 punctuator 正常路径）。翻页键现状
   = `-`/`=`/PgUp/PgDn（, . [ ] 翻页绑定在 default.yaml 全为注释态），
   用户"只留 -=/PgUp/PgDn 翻页"的诉求即现状，无需改动。
4. **杂项**：音形模式误入 bug；moqi-ime 存量失败测试（基线即挂，非阻塞）。
   语法模型（gram）：内置 7MB 小 gram 实测无提效，**已从安装包移除**；
   只保留 essay-bgw（196.8MB）——full 包内置 + 独立下载；20MB 档尚无合格候选。
   **gram 放置与验证规则（2026-10-23 用户定死，别再反复）**：
   - gram 文件放**安装目录**（`{app}\moqi-ime\input_methods\rime\data\`）或用户目录
     （`%APPDATA%\Moqi\Rime\`）都行，`grammar_model=auto`（默认）自动选两者中
     ≥64MB 的最大 `.gram`。**放安装目录就能启用，这条路是好的**（10-23 三次装包
     glog 铁证 `use grammar: zh-hans-t-essay-bgw`）。
   - 验证 gram 是否加载的唯一口径：`MoqiIM/Log/rime-daemon.*.INFO.*.log` 里
     `use grammar: <名字>`；候选上的 `*` 标记只是 debug 参考。
     （2026-11-06 起 glog 基名按进程角色区分：daemon 引擎 = rime-daemon，
     TSF 进程内引擎 = rime-tsf；旧名 Rime.Moqi/Rime.MoqiIM 的文件
     三天后被 glog 自动清理。）
   - **覆盖安装会清空 `{app}\moqi-ime`，放安装目录的 gram 会丢——装新包后
     要重装 full 包或把 gram 拷回**；用户目录的 gram 不受影响。
   - **abbrev_sentences 已移除（2026-10-23 方案 A，用户拍板）**：混合输入组句
     把真人混合首选率打到 29.7%（去掉 64.8%，gram 本体保留只差 0.9）；
     代价 d3 65.9→59.4。full=gram 开+组句关；标准/lite 无 gram 不变。
     如需为长句人群恢复须改 `local_behavior.go`（无配置开关）。
   - 实验工具里控制 gram 开关必须走 `local_behavior.json`
     （`{"grammar_model":"off"}`，放 APPDATA 重定向后的 `Moqi\` 目录），
     **不要手写 `rime_frost.custom.yaml`**——没有 managed 标记的该文件会被
     产品正确地拒绝覆盖，开关被架空、实验两组跑成一样的（10-23 踩坑）。
5. **五笔拼音混输（待办，暂缓；用户 2026-10-23 明确"现在先不做"）**：
   现状 = 方案切换（托盘「输入方案」）+ 五笔方案内 `z` 临时拼音，
   不是同组字混输；拼音方案不认五笔码。开工需新增混输 schema
   （五笔+拼音双翻译器 + 消歧策略）并先建测评维度。
   细节见 `14-交接-2026-10-23.md` 第四节待办第 4 条。

## 日常操作速查

```powershell
# 一键出安装包（Go 后端 + TSF 前端 + 词库预编译 + Inno）
moqi-im-windows\scripts\_all_in_package.ps1
# 产物 moqi-im-windows\installer\dist\moqi-im-windows-setup.exe
```

```bash
# 测评（迭代档约 5 分钟；口径详见 eval-workspace/SUITE.md）
cd <项目根>/eval-workspace && ./suite-v2.sh            # 发版档全矩阵(脚本已相对化)
./run-cell.sh <维度> <off|on> <native|ime> <full|jianpin>  # 单格
./dump-all.exe <pinyin>...    # 显微镜：候选全页
./probe-typo.exe 2000 2000    # 容错维度
```

- 测评每格**必须全新用户目录**（用户词典跨格污染会假提升）；后台跑格的
  停止必须杀**进程树**（bash 循环 + exe），TaskStop 外层壳杀不死内层循环，
  且 rime.dll 非并发安全——并发跑格会互相污染出假数据（10-26 实证）。
- **白盒考卷读音口径（2026-10-26 定稿）**：eval 转音 = phrase-pinyin-data 词表
  正向最长匹配 + 单字回退 + 6 条纠错词典（`eval/sentences_windows.go`，
  与黑盒 pypinyin 口径 100% 对齐）。--pinyin 同目录有 phrase-pinyin-data.txt
  即自动加载，跑格脚本无需传参。
- **产品配置变更必须同步白盒 prod yaml**（10-26 事故）：abbrev_sentences 产品
  10-23 已移除但 suite 脚本残留"开"，dll 换代后该键首次生效，d3 假摔 8 点。
  基线快照 `eval-workspace/baseline-v1.6.0.txt` 为下次发版门 diff 锚。
- 改 librime 后：`librime/rebuild-librime2.bat` 重编 rime.dll，
  拷到 `moqi-ime/input_methods/rime/rime.dll` 与 `eval-workspace/rime.dll`。
- MSVC 编译必须走 .bat（Git Bash 误解析参数）；GitHub 走代理 127.0.0.1:7890。
- **测试临时产物（探针 exe/提权脚本/中转文件/临时 bat）放 `F:\work\`，不放
  Z:\、C:\Users、D:\**（2026-10-23 定 D:\，2026-10-31 用户改定 F:\work\：D 盘是
  VMware 所在硬盘、空间小）：Z:\ 是 VMware 共享盘——**提权后的进程看不到它**
  （提权脚本引用 Z:\ 路径会静默失败，实测），且 IO 慢。提权操作的源文件
  先拷到 F:\work\ 再 RunAs。持久性测评素材仍归 eval-workspace。
  （F:\work\IME\ 下已有 ai-key-mask 工具目录与参考资料，同类临时物按主题建子目录。）
- **jsoncpp 配置文件取值纪律（2026-11-06 定）**：读用户可手改的 JSON
  （cloud_clipboard/appearance/local_behavior/scheme_set/ai_config/
  network_egress/MoqiLauncher 等）一律走 RimeCore.h 的
  `jsonBoolOf/jsonStringOf/jsonIntOf/jsonMemberOf`——裸 get/operator[]
  在非对象容器上抛 LogicError，裸 asBool/asInt 对错型值也抛
  （实证矩阵见 51-交接§八）；协议侧已有 catch 装甲不在此列。
- 更多环境坑（热用户目录、DLOG、heredoc 转义、共享盘 filemode）见
  03-交接文档第七节，动环境前先读。

### git 提交与推送（2026-10-20 定稿）

```bash
git -C moqi-im-windows status --short          # 三个仓库 + 子模块都要看
git -C moqi-im-windows/libIME2 status -sb      # 必须显示 master，不能是 detached
git -C moqi-ime status --short

git -C moqi-im-windows         -c http.proxy=http://127.0.0.1:7890 push origin main
git -C moqi-im-windows/libIME2 -c http.proxy=http://127.0.0.1:7890 push origin master
git -C moqi-ime                -c http.proxy=http://127.0.0.1:7890 push origin main
git -C librime        -c http.proxy=http://127.0.0.1:7890 push origin master
# 交接文档仓（就在项目根目录）：
git -c http.proxy=http://127.0.0.1:7890 push origin main
```

- 三个仓库的跟踪分支都是 `origin/*`（自己的 fork），所以裸 `git push` 也安全；
  但推送**必须带代理**，否则连不上 GitHub。
- 跟上游同步要显式：`git fetch upstream && git merge upstream/main`——
  裸 `git pull` 拉的是自己的 fork，不会自动跟随上游。
- 子模块地址若改动（例如换成 fork），要**单独 commit 外层 `.gitmodules`**，
  否则别人 clone 后 `submodule update` 取不到记录的那个 SHA。
- **谁改谁负责**：`git log origin/<分支>..HEAD` 有输出 = 有未推提交，那这个仓
  必须在自己账号下；纯第三方依赖（libuv / jsoncpp / Inno 译文 / librime deps /
  rime-frost）保持指原作者，不要无脑 fork（fork 了就得背同步成本）。
  发布出二进制（如 rime.dll）时，**构建它的源码必须先推到可访问的远端**。
