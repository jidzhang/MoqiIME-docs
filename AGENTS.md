# AGENTS.md — MoqiIME 项目总纲

> 面向在本目录工作的 AI agent。**权威入口：`03-交接-2026-10-18.md`**（目标/成绩/技术手段/
> 路线图/环境坑/素材表的完整版）+ **当日交接 `05-交接-2026-10-20.md`**（按日期递增，
> 最新结论以它为准）；每个实验或修复完成后必须回写当日交接，
> 实验明细追加到 `moqi-ime/report/2026-10-16-baseline.md`。本文只定原则、目标和路线。

## 项目是什么

墨奇输入法（Windows TSF 中文拼音输入法），fork 自 gaboolic 的开源实现：

```
TSF 前端 moqi-im-windows (C++) → JSON/libuv → Go 后端 moqi-ime (server.exe)
→ cgo → librime-gaboolic (rime.dll) + plugins/librime-octagram (n-gram)
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
当前 54.55（2026-10-18，prod 栈）。汉语拼音逻辑上可能到不了 70%，
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

## 路线（按优先级）

1. **d3 → 70% 主线**
   - 词库：补高频口语 bigram（gold 词对 24.2% 在词典中完全缺失：是的/的是/的人…，
     权重公式 min(2.2×语料频次, 30000) 已验证），走 prebuild 打包期合入。
   - gram：essay-bgw 已就位，可试自训域适配 gram（subs/news 语料）。
   - 算法：句子候选 quality 公式定档（sentence_quality_boost 扫参，门已留好）。
2. **容错层（正式待办，用户 2026-10-18 确认）**：换位类错字 top-1 仅 23%
   （无错字 89.8%）。修法=音节图换位边+门控；全局开现有纠错器实测 d5 −6.2，
   禁止整体打开。验收标准与实现细节见 03-交接文档路线图第 2 项，
   A/B 工具 `eval-workspace/probe-typo.exe` 已就绪。
3. **体验**：~~首切延迟~~（2026-10-20 已解决：librime 消除 melt_eng/radical_pinyin
   schema 循环依赖 + 启动器启动即预热后端；用户实测"几乎没有卡的感觉"）。
   剩余：Go 管线 filterKeyDown 27.6ms/键。
4. **杂项**：音形模式误入 bug；moqi-ime 存量失败测试（基线即挂，非阻塞）。

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

- 测评每格**必须全新用户目录**（用户词典跨格污染会假提升）。
- 改 librime 后：`librime-gaboolic/rebuild-librime2.bat` 重编 rime.dll，
  拷到 `moqi-ime/input_methods/rime/rime.dll` 与 `eval-workspace/rime.dll`。
- MSVC 编译必须走 .bat（Git Bash 误解析参数）；GitHub 走代理 127.0.0.1:7890。
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
git -C librime-gaboolic        -c http.proxy=http://127.0.0.1:7890 push origin master
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
