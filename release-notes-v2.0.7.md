# 墨奇输入法 v2.0.7

这一版大幅补齐了专有名词——公司名、地名、火车站、机场都能直接打出来了。

| 安装包 | 说明 |
|---|---|
| moqi-im-windows-setup-2.0.7.exe | 标准版，推荐大多数用户 |
| moqi-im-windows-setup-lite-2.0.7.exe | 精简版，体积最小 |
| moqi-im-windows-setup-essay-2.0.7.exe | 长句增强版，内置语法模型 |
| moqi-im-windows-setup-wiki-2.0.7.exe | 百科语料版 |
| moqi-im-windows-setup-wanxiang-2.0.7.exe | 万象词库版，词量最大 |

## 这一版的变化

**公司名能打出来了**：中望、浩辰、博超、纬衡、理正、同望、隆基、通威、晶科这些知名企业名，以前打不出来，现在直接出词。这一批补了 57 个常见企业软件品牌。

**地名补齐了**：全国省、市、区县名逐一核对，补上 173 个缺失的行政区划名称。更关键的是修好了已有的地名——以前成都、漯河这类地级市因为权重太低，打 chengdu 出来的是「程度」、打 luohe 出来的是「络合」，现在地级市都能正常排到首位。

**火车站和机场**：全国 4582 个铁路车站补齐了 2107 个（含「XX站」写法），国内机场城市也补齐了。打「长治东」「漯河」这类站名现在都准。

**个人词库入库**：把长期积累的 14 万条词汇清洗后并入词库，覆盖专业术语、古籍、机构名等。这批词权重压得很低，只保证能打出来，不会影响日常输入的候选顺序。

**读音修正**：地名多音字逐条核对过——长治读 chang 不读 zhang、龙圩读 xu 不读 wei、漯河读 luo 不读 ta，这类错误修了 40 处。

## 准确性

标准考卷与上一版持平：

- 两词全拼 94.20%
- 混合连打 67.20%

## 升级说明

- 覆盖安装即可，不需要先卸载。
- 装完建议重启电脑，让输入法组件全部换成新版。
- 自定义词库和设置都会保留。
- 首次切换输入法时词库需要加载一次，可能略有停顿（新增词条较多）。

## 致谢

输入法引擎来自 [RIME](https://github.com/rime/librime) 项目，词库来自 [rime-frost](https://github.com/gaboolic/rime-frost)，行政区划数据来自 [Administrative-divisions-of-China](https://github.com/modood/Administrative-divisions-of-China)，铁路车站数据来自 [China-Railway-Station-Database](https://github.com/undef-i/China-Railway-Station-Database)，均为开源项目。
