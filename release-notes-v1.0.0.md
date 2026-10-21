墨奇输入法 Windows 版 v1.0.0 —— 基于 [gaboolic/moqi-im-windows](https://github.com/gaboolic/moqi-im-windows) 深度优化分支的首个正式版。

感谢原作者 [@gaboolic](https://github.com/gaboolic)：moqi-ime 引擎、白霜拼音与墨奇输入法均出自其手，本项目的所有优化都建立在其成果之上。

## 下载哪个？

| 文件 | 内容 | 适合谁 |
|---|---|---|
| `moqi-im-windows-setup-lite.exe`（约 35MB） | 不含预编译词库 | 想要最小安装包；首次部署现场编译词库（实测约 20 秒） |
| `moqi-im-windows-setup.exe`（约 73MB） | 含预编译词库 | **绝大多数用户，装完即用** |
| `moqi-im-windows-setup-full.exe`（约 228MB） | 预编译词库 + 大语法模型 | 想要更好的长句/上下文效果 |
| `zh-hans-t-essay-bgw.gram`（196.8MB） | 大语法模型独立文件 | 已装 lite/标准包，想后补语法模型 |

三个安装包均同时包含 32 位与 64 位 TSF DLL，无需按系统架构选择。`SHA256SUMS.txt` 为全部资产的校验和。

## 安装说明

1. 下载上方任一 `setup.exe`，双击运行（需要管理员权限）。
2. 安装器会自动停止墨奇相关进程后覆盖安装；**若提示 TSF DLL 被系统占用，请按提示重启 Windows 完成注册**。
3. **覆盖安装会清空安装目录下的后端目录**（`moqi-ime\`）——之前放在**安装目录**的大语法模型会被删掉，升级前请备份，或改用下方"用户目录"方式放置（用户目录不受覆盖安装影响）。
4. 安装完成会自动启动墨奇；在系统输入法列表中选择"墨奇输入法"即可使用。

## 大语法模型自行部署（lite / 标准包用户）

1. 下载 `zh-hans-t-essay-bgw.gram`。
2. **推荐：复制到用户目录**（无需管理员权限，升级重装不丢）：

   ```
   %APPDATA%\Moqi\Rime\
   ```

   资源管理器地址栏粘贴 `%APPDATA%\Moqi\Rime` 回车即可打开。也可以放安装目录 `C:\Program Files (x86)\MoqiIM\moqi-ime\input_methods\rime\data\`（需管理员权限，且覆盖安装时会被删）。
3. 托盘图标右键 → **刷新配置(&R)**，部署完成后即生效。
4. 默认 `grammar_model=auto`，自动选用上述目录里 ≥64MB 的最大 `.gram`，无需改任何配置；想固定或关闭模型，编辑 `%APPDATA%\Moqi\local_behavior.json` 的 `"grammar_model"` 字段，详见仓库 [installer/PACKAGES.md](https://github.com/jidzhang/moqi-im-windows/blob/main/installer/PACKAGES.md)。

## 本次更新亮点（相对上游）

- **性能**：按键延迟从 ≈11.4ms/键 降到 ≈0.73ms/键（DLL 事件驱动读）；首次输入卡顿消除（schema 循环依赖修复 + 引擎预热）
- **准确率**：换位容错层（换位类错字 top-1 23.4% → 51.6%，守卫维度零回归）；essay-bgw 大语法模型接入与全套调优（整句 +1.5、混合连打组句 +2.4）
- **输入体验**：数字/小数点直通（`4.`、`4.5` 直接上屏，组字中数字仍选候选）；候选窗微软式锚定、直角、首候选高亮四边贴边；修复记事本等宿主组字虚线被候选窗遮挡的问题
- **工程**：三档安装包 + GitHub Actions 全自动发版；安装包不再内置实测无提效的 7MB 小 gram

完整优化清单见 [README](https://github.com/jidzhang/moqi-im-windows#本分支的深度优化)。

## 已知事项

- 全新安装后，大语法模型需在托盘点一次「刷新配置(&R)」才会启用（下一版本将自动化）
- 数字直通目前覆盖白霜拼音系方案；注音/笔画等方案暂不支持
- 从旧版本覆盖安装后，"卸载程序"列表里的显示名要等本次安装写入后才更新为"墨奇输入法"（不带"版本"字样）

---

如果这个项目帮到了你，欢迎[赞助支持](https://afdian.com/a/dc99tech)（爱发电）。
