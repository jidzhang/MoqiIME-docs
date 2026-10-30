# 墨奇输入法 v1.7.0

---

## 下载哪个？

| 安装包 | 大小 | 适合谁 |
|---|---|---|
| **moqi-im-windows-setup-1.7.0.exe** | 85MB | **大多数用户装这个**。开箱即用，自带基础增强数据 |
| moqi-im-windows-setup-wiki-1.7.0.exe | 102MB | 长句、整句较多但不想装大包的用户：比标准档整句更准，体积只多一点 |
| moqi-im-windows-setup-lite-1.7.0.exe | 38MB | 追求极简、磁盘紧张的用户。功能完整，无长句增强 |
| moqi-im-windows-setup-essay-1.7.0.exe | 240MB | 经常写长文、连着成句打字的用户：整句自动成词更准，少了反复选字的打断 |
| moqi-im-windows-setup-wanxiang-1.7.0.exe | 401MB | **整句最强档**：长文写作、口述式连续输入这类场景整句准确率最高，代价是体积大 |

**一句话建议**：不确定就装第一个（85MB 标准档）；经常写长文选 essay，追求整句最优选 wanxiang。已装旧版直接覆盖安装即可，个人积累的词库不会丢。

## 本次更新亮点

1. **纠错能力大幅增强**：打错键（srf→输入法）、多打一个键（niihao→你好）、少打一个字母（wde→我的）都能在第一页找到正确词；同一个错法第二次打，直接排第一（越用越顺手）。
2. **换位容错**：gongzuo 打成 gognzuo 也能出"工作"。
3. **长句增强数据三档化**：标准档和 lite 档都能享受长句增强，按机器与习惯自由选择体积。
4. 依赖全面升级（jsoncpp/protobuf/spdlog/boost），底层与 rime 官方主线对齐。

## 说明

- 纯简拼（如 srf）的候选顺序按词频排列，属正常现象。
- AI 功能默认关闭，需自行配置方可开启。
- 长句增强模型来源：essay 档来自 [lotem/rime-octagram-data](https://github.com/lotem/rime-octagram-data)；wanxiang 档为[万象语法模型](https://github.com/amzxyz/rime-wanxiang-data)。感谢作者。