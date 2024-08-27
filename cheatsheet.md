---
title: Cheatsheet
subtitle: latex cheatsheet
date: 2024年8月27日
---

## 多作者

```yaml
author: 
  - 作者1\inst{1}
  - 作者2\inst{2}
institute: 
  - \inst{1} 清华大学 计算机科学与技术系
  - \inst{2} PKU
```

## 图片调整{.allowframebreaks}

- 使用 `\includegraphics` 限制图片居中并适应高度

```latex
\begin{figure}
    \centering
    \includegraphics[height=0.5\textheight, keepaspectratio]{Screenshot-2024-07-17-at-19.53.04@2x.png}
    \caption{在这里添加你的标题}
\end{figure}
```

效果：

\begin{figure}
    \centering
    \includegraphics[height=0.3\textheight, keepaspectratio]{Screenshot-2024-07-17-at-19.53.04@2x.png}
    \caption{在这里添加你的标题}
\end{figure}

### markdown 限制图片百分比

`![本人画了二十分钟的图无法保存！痛失可编辑图像一份。](/Users/thanksallthefish/Library/Mobile Documents/iCloud~md~obsidian/Documents/Summer's blog/source/asset/posts/Screenshot-2024-07-17-at-21.16.17@2x.png){width=50%}`


## framebreaks

### 第一种写法

直接在 markdown 文件中 `## 标准化 {.allowframebreaks}`

