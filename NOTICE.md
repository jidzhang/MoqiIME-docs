# 项目来源与许可说明

本项目（MoqiIME 墨奇输入法）基于以下上游开源项目构建。所有上游代码、
词库数据与语言模型的著作权归各自作者所有，本项目保留其原始许可与版权声明。

## 上游项目

| 组件 | 上游仓库 | 许可 | 说明 |
|---|---|---|---|
| 后端服务 | [gaboolic/moqi-ime](https://github.com/gaboolic/moqi-ime) | MIT | Go 后端：拼音解析、候选、词库、AI、同步 |
| TSF 前端 | [gaboolic/moqi-im-windows](https://github.com/gaboolic/moqi-im-windows) | MIT | 候选窗、语言栏、按键转发、安装器 |
| 引擎 | [gaboolic/librime](https://github.com/gaboolic/librime)（源自 [rime/librime](https://github.com/rime/librime)） | BSD-3-Clause | Rime 引擎，多整句候选改版 |
| 语法模型插件 | [lotem/librime-octagram](https://github.com/lotem/librime-octagram) | BSD-3-Clause | n-gram 语法模型 |
| 默认词库 | [gaboolic/rime-frost](https://github.com/gaboolic/rime-frost) | GPL-3.0 | 白霜拼音词库（派生自 rime-ice） |
| TSF 基础库 | libIME2 | LGPL-2.1 | 静态链接 |
| 事件循环 / JSON | libuv (MIT) / jsoncpp (MIT) | MIT | 静态链接 |
| 日志 / 序列化 | spdlog v1.2.1 (MIT) / protobuf 33.5 + abseil (BSD / Apache-2.0) | MIT / BSD / Apache-2.0 | FetchContent 拉取 |

## 数据与模型

- `data/cn_dicts/*` 来自白霜拼音词库，遵循 **GPL-3.0**。
- 语言模型 `zh-hans-t-essay-bgw.gram` 来自
  [lotem/rime-octagram-data](https://github.com/lotem/rime-octagram-data)，
  许可为 **LGPL-3.0**（2026-10-25 核实：仓库 LICENSE 与 GitHub 许可字段一致）。
  LGPL 对合并发行的核心要求（用户可替换 LGPL 组件）由产品天然满足：
  安装器 auto 扫描 .gram、用户可随意替换/增删模型文件。原样分发时保留
  本条归属与许可证声明即合规。**不作为本项目自有资产**。
- 其他 `.gram` 文件（如 `wanxiang-lts-zh-hans.gram`）为用户自装，不随本
  项目分发，遵循各自上游的原始许可。

## 本项目的修改

本仓库对上游的改动以独立提交保存在各 fork 中（`origin`），
上游保持为 `upstream` 远端，便于定期合并与向上游提交补丁。

```
moqi-ime            origin: github.com/jidzhang/moqi-ime          upstream: github.com/gaboolic/moqi-ime
moqi-im-windows     origin: github.com/jidzhang/moqi-im-windows   upstream: github.com/gaboolic/moqi-im-windows
librime-gaboolic    origin: github.com/jidzhang/librime           upstream: github.com/gaboolic/librime
librime-octagram    origin: github.com/jidzhang/librime-octagram  upstream: github.com/lotem/librime-octagram
```

## 再分发要求

- **白霜词库（GPL-3.0）**：安装包内含其数据，因此**整包须按 GPL-3.0 开源并可再分发**，
  须随附源码。
- **libIME2（LGPL-2.1，静态链接）**：须提供重新链接能力（LGPL 源码 offer +
  本项目的目标文件/链接脚本），或改为动态链接。
- 其余（MIT / BSD-3-Clause / Apache-2.0）在保留版权与许可声明的前提下可自由使用。
- MSVC 编译器本体、VC Redist / Universal CRT、Windows SDK 为专有例外，不在源码构建范围内。
