# AGENTS.md — MoqiIME 项目总纲

> 面向在本目录工作的 AI agent。**最新交接：`21-交接-2026-10-31.md`（下一阶段计划记档：①用户词典优先级研究谷歌/微软拼音 ②微信输入法对抗考卷解剖 ③librime 编译选项优化发挥 MSVC 能力；上一=v1.8.0 已发，纠错专项收官见 20-交接）**；
> 交接文档按日期递增（03-交接-2026-10-18.md 有目标/技术手段/环境坑的完整版），
> 最新结论以日期最大的为准；每个实验或修复完成后必须回写当日交接，
> 实验明细追加到 `moqi-ime/report/2026-10-16-baseline.md`。本文只定原则、目标和路线。

## 项目是什么

墨奇输入法（Windows TSF 中文拼音输入法），fork 自 gaboolic 的开源实现：

```
TSF 前端 moqi-im-windows (C++) → JSON/libuv → Go 后端 moqi-ime (server.exe)
→ cgo → librime (rime.dll) + plugins/librime-octagram (n-gram)
词库：moqi-ime/rime-frost 子模块（GPL-3.0，上游仓库，不直接改）
```

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
4. **杂项**：音形模式误入 bug；moqi-ime 存量失败测试（基线即挂，非阻塞）。
   语法模型（gram）：内置 7MB 小 gram 实测无提效，**已从安装包移除**；
   只保留 essay-bgw（196.8MB）——full 包内置 + 独立下载；20MB 档尚无合格候选。
   **gram 放置与验证规则（2026-10-23 用户定死，别再反复）**：
   - gram 文件放**安装目录**（`{app}\moqi-ime\input_methods\rime\data\`）或用户目录
     （`%APPDATA%\Moqi\Rime\`）都行，`grammar_model=auto`（默认）自动选两者中
     ≥64MB 的最大 `.gram`。**放安装目录就能启用，这条路是好的**（10-23 三次装包
     glog 铁证 `use grammar: zh-hans-t-essay-bgw`）。
   - 验证 gram 是否加载的唯一口径：`MoqiIM/Log/Rime.Moqi.*.INFO.*.log` 里
     `use grammar: <名字>`；候选上的 `*` 标记只是 debug 参考。
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
cd /z/dev/IME/MoqiIME/eval-workspace && ./suite-v2.sh     # 发版档全矩阵
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
