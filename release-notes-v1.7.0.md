# 墨奇输入法 v1.7.0

---

## 下载哪个？

| 安装包 | 大小 | 适合谁 |
|---|---|---|
| **moqi-im-windows-setup-1.7.0.exe** | 85MB | **大多数用户装这个**。开箱即用，自带基础增强数据 |
| moqi-im-windows-setup-full-1.7.0.exe | 240MB | 长句/整句输入多的用户（写作、聊天长文）。体积大、整句更聪明 |
| moqi-im-windows-setup-lite-1.7.0.exe | 38MB | 追求极简、磁盘紧张的用户。无任何增强数据，功能完整但无整句增强 |
| moqi-im-windows-setup-essay-1.7.0.exe | 240MB | 与 full 同级（不同增强数据风格），二选一即可 |
| moqi-im-windows-setup-wiki-1.7.0.exe | 102MB | 偏好书面语/百科词汇风格的用户 |
| moqi-im-windows-setup-wanxiang-1.7.0.exe | 401MB | 喜欢万象词库风格的用户（本地尝鲜档，官方下载页不放） |
| zh-hans-t-essay-bgw.gram | 197MB | 已装标准档/lite 想后补整句增强的用户：下载后放进安装目录的 `moqi-ime\input_methods\rime\data\` 即可 |

**一句话建议**：不确定就装第一个（85MB 标准档）；常打长句选 full。已装旧版直接覆盖安装即可，输入数据不会丢。

## 本次更新亮点

1. **纠错能力大幅增强**：打错键（srf→输入法）、多打一个键（niihao→你好）、
   少打一个字母（wde→我的）都能在第一页找到正确词；同一个错法第二次打，
   直接排第一（越用越顺手）。
2. **换位容错**：gongzuo 打成 gognzuo 也能出"工作"。
3. **修复 Shift+` 输出 ~**。
4. **整句增强数据三档化**：标准档也自带轻量增强（此前只有 full 档有）。
5. 依赖全面升级（jsoncpp/protobuf/spdlog/boost），底层与 rime 官方主线对齐。

## 说明

- 纯简拼（如 srf）的候选顺序按词频排列，属正常现象。
- AI 功能默认关闭，需自行配置方可开启。
