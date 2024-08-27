---
title: Test Slides
subtitle: Using Pandoc to Write Beamer
date: 2024年8月27日
---

内含 Stata 基础功能、变量定义及内置命令、Dofiles，数据管理以及图表制作的相关技巧。本篇不涉及具体的数据回归与分析，更多的是一些规范工作流的命令。或许有一些指导意义，但更多的是健忘人士手册。


## Let's get started!

### 设置工作目录

我承认最开始的时候我也是打开命令窗口直接开始 `import excel`，直到我开始自己处理更大的数据和文件，才意识到设置工作目录并好好命名项目下的文件有多重要。朋友们，不要再设置中文的工作目录了，你永远不知道因为中文工作目录名称导致的报错会在哪一天以何种方式照进现实。


![
/Users/thanksallthefish/Library/Mobile Documents/iCloud~md~obsidian/Documents/Summer's blog/source/asset/posts/Screenshot-2024-07-17-at-21.16.17@2x.png](本人画了二十分钟的图无法保存！痛失可编辑图像一份。 )

### 安装外部命令

当然这一步在遇到时再安装也是可以的，我真的只是为了让这篇文章看起来更像一个正确的实验设计才把他放在这里。

```stata
ssc install winsor2
```

## 数据预处理

### 数据导入


```stata
import excel "data.xls", sheet("Sheet1") firstrow clear
```

- `data.xls` 当前目录下原始 excel 文件
- `sheet("Sheet1")`使用 Sheet1 页的数据
- `firstrow` 以第一行作为变量名

### 数据转换

`reshape` 命令绝对是我的噩梦。但事实是熟练之后在很多时候确实会 come in handy。可惜的是我在一段时间没有用之后又不会了，这边建议日常 refer to `help reshape`  ~~for less brain damage~~

### 合并数据

我一般用来把控制变量合并到核心变量的数据文件里去。~~其实用 excel 也是可以的啊？~~

```stata
merge 1:1 stkcd year using ControlVarsDetail, keep(3)
```

* `1:1` 1对1关联，`1:m` 1对多关联，`m:1` 多对1关联
* `id year`：根据 id 和 year 这两个变量确定唯一值进行关联
* `using`：使用要关联的数据集
* `keep`：保留的意思，两份数据怎么进行关联，1：只保留主表没有关联上的数据，2：只保留副表没有关联上的数据，3：只保留主表和副表关联上的数据
* 例如 `keep(1 3)` 表示保留主表没有关联上的数据和主表和副表关联上的数据
* 如遇到报错说主表或者关联表不是唯一值，则需要进行去除重复操作，`duplicates drop id year, force`


### 数据缩尾

对异常数据进行截尾，一般保留 1-99 百分位的数据

```
winsor2 Y,cuts(1 99) trim replace
```

该操作不可撤销（比如说我要是截尾了一次发现 1-99 不合适，想重新保留 5-95 百分位的数据该怎么办呢？呃，~~我一般都是把 excel 里的原始数据再复制过来一遍~~）

一个比较容易混淆的概念是标准化：
- 缩放到 $[0, 1]$:

$$
   X_{\text{norm}} = \frac{X - \min(X)}{\max(X) - \min(X)}
$$

- 缩放到 $[-1, 1]$ 范围
$$
   X_{\text{scaled}} = 2 \times \frac{X - \min(X)}{\max(X) - \min(X)} - 1
$$

假设你有一个变量 `X`，Stata 具体步骤如下：

1. **计算最小值和最大值**:
   ```stata
   summarize X
   ```

2. **标准化到[0, 1]范围**:
   ```stata
   generate X_norm = (X - r(min)) / (r(max) - r(min))
   ```

3. **缩放到[-1, 1]范围**:
   ```stata
   generate X_scaled = 2 * (X - r(min)) / (r(max) - r(min)) - 1
   ```

### 删除缺失值

最后一步是删除缺失值，保存数据，比较简单代码就不放了。

## Some tips that may be useful
### 历史记录

与 MATLAB 和其他终端不同，Stata 使用 `PageUp` 和 `PageDown` 键来浏览历史命令记录。学会这个之后 Summer 再也不用在历史窗口复制粘贴代码，~~人类文明的一大步。~~

在 Macbook 笔记本上可以通过以下组合快捷键操作。呃，为什么就不能设置个上下方向键呢。

在 Macbook 笔记本上可以通过以下组合快捷键操作。呃，为什么就不能设置个上下方向键呢。

```
Windows:PgUp == Mac: fn/option(alt) + 上箭头
Windows:PgDn == Mac: fn/option(alt) + 下箭头

Windows:Home == Mac: fn + 左箭头
Windows:End == Mac: fn + 右箭头
```