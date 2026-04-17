# Touying University Theme For UCAS

基于 [Touying](https://github.com/touying-typ/touying) 的 Typst 幻灯片主题，面向中文学术汇报场景。本文档已按当前仓库源码重新梳理，并与以下文件逐项对齐：

- `theme.typ`
- `color-themes.typ`
- `custom-outline.typ`

## 项目定位

这个模板的目标是：

- 给出开箱即用的中文学术演示视觉规范（页眉、页脚、章节页、目录页）
- 保持强可定制性（颜色、字体、布局、页眉页脚策略）
- 提供“上下文感知”目录能力（当前章节高亮、父子级联）

该模板自本科毕业论文写作期间开始打磨，目前可满足绝大多数需求

代码大量参考自以下项目：

- [tt-lectures](https://github.com/zeroeightysix/tt-lectures)
- [touying-buaa](https://github.com/Coekjan/touying-buaa)
- [typst-talk](https://github.com/OrangeX4/typst-talk)

## 仓库结构

```text
.
├── main.typ              # 示例演示文稿（业务内容示例）
├── theme.typ             # 主题核心（布局、样式、幻灯片函数、主题入口）
├── color-themes.typ      # 预设配色与自定义主题生成器
├── custom-outline.typ    # 上下文感知目录模块
├── cite.bib              # 示例参考文献
├── geoarchaeology.csl    # 示例参考文献样式
└── assets/               # Logo、图片等素材
```

## 快速开始

### 软件环境

- 建议使用 [VSCode](https://code.visualstudio.com/) + [Tinymist](https://github.com/Myriad-Dreamin/tinymist)
- 务必安装字体
  - Times New Roman
  - [Source Han Serif SC](https://source.typekit.com/source-han-serif/cn/)
  - [Source Han Sans](https://github.com/adobe-fonts/source-han-sans)
  - 字体定义参见 `theme.typ`中的 default-fonts函数

### 最小可运行示例

```typst
#import "@preview/touying:0.6.3": *
#import "theme.typ": *
#import "color-themes.typ": theme-ucas

#show: university-theme.with(
  colors: theme-ucas,
  config-info(
    title: [演示标题],
    author: [作者姓名],
    institution: [机构名称],
    date: datetime.today(),
    logo: image("assets/vi/UCAS/中国科学院院徽.png"),
    logo1: image("assets/vi/UCAS/中国科学院院徽.png"),
  ),
)

#title-slide()

= 第一章

#slide[
  这是第一张内容页。
]
```

### 编译

```bash
typst compile main.typ
```

首次使用 Typst 包（`@preview/...`）时需要联网拉取依赖。

## 主题入口：`university-theme`

`theme.typ` 的核心入口为：

```typst
#show: university-theme.with(...)
```

### 参数总览（按当前实现）

| 参数               | 默认值                       | 实际作用                                                          |
| ------------------ | ---------------------------- | ----------------------------------------------------------------- |
| `aspect-ratio`   | `"16-9"`                   | 仅允许 `"16-9"` / `"4-3"`，不合法会 `assert`                |
| `progress-bar`   | `true`                     | 控制内容页页眉进度条显示                                          |
| `header`         | 当前二级标题                 | 页眉左侧内容函数                                                  |
| `header-right`   | 一级标题 +`logo1`          | 页眉右侧内容函数                                                  |
| `footer-columns` | `(25%, 1fr, 25%)`          | 页脚三列宽度                                                      |
| `footer-a`       | `self.info.author`         | 页脚左侧                                                          |
| `footer-b`       | `short-title` 或 `title` | 页脚中间                                                          |
| `footer-c`       | 日期 + 页码                  | 页脚右侧                                                          |
| `colors`         | `default-colors`           | 注入 Touying 的 `primary/secondary/tertiary/neutral-*`          |
| `fonts`          | `default-fonts`            | 字体配置对象（当前实现中未直接用于 `set text`，但可供样式复用） |
| `text-styles`    | `default-text-styles`      | 文本样式集合，控制正文/标题/图注/目录等                           |
| `layout-config`  | `default-layout-config`    | 边距、标题编号、目录间距、Logo 高度等                             |
| `color-palette`  | `default-color-palette`    | **当前实现中仅声明参数，未参与后续计算**                    |

### 渲染流程

`university-theme` 内部做了 4 件关键事情：

1. 配置页面：纸张比例、页边距、页眉页脚位置。
2. 注册函数：`slide-fn: slide`、`new-section-slide-fn: new-section-slide`。
3. 初始化样式：设置标题/图注/编号、正文主色。
4. 保存状态：把页眉页脚函数和文本样式写入 `config-store`，供 `slide()` 读取。

## `config-info` 字段说明

`config-info(...)` 是 Touying 提供的信息存储入口，本主题会读取以下字段：

| 字段            | 使用位置                                | 说明                      |
| --------------- | --------------------------------------- | ------------------------- |
| `title`       | 标题页、页脚中列回退值                  | 主标题                    |
| `subtitle`    | 标题页                                  | 副标题                    |
| `author`      | 页脚左列、标题页（当无 `authors` 时） | 建议始终设置              |
| `authors`     | 标题页                                  | 若存在则优先于 `author` |
| `institution` | 标题页                                  | 机构信息                  |
| `date`        | 标题页、页脚右列                        | 支持文本或日期            |
| `logo`        | 标题页                                  | 封面 Logo                 |
| `logo1`       | 页眉右侧                                | 页眉 Logo                 |
| `short-title` | 页脚中列                                | 不设时回退 `title`      |

注意：`footer-a` 默认只读 `author`，不会自动读 `authors`。

## 幻灯片函数参考（`theme.typ`）

### `slide(...)`：标准内容页

常用参数：

- `config`: Touying 页面配置字典
- `repeat`: 子页数量（`#only/#uncover` 回调写法时建议显式给出）
- `setting`: 局部 `set/show` 注入
- `composer`: 布局器（函数或列配置）
- `composer-r`: 当 `composer` 为数组时的行配置
- `size`: 缩放正文文字（标题大小保持基准）

特性：

- 智能页眉：
  - 当前页存在二级标题时：左侧显示二级标题，右侧显示一级标题 + `logo1`
  - 仅一级标题时：左侧回退到一级标题，右侧仅显示 `logo1`
- `composer` 若为数组，会自动转为 `grid.with(columns: ..., rows: composer-r)`

### `title-slide(...)`：标题页

- 自动读取 `config-info`
- 自动冻结页码计数（`freeze-slide-counter: true`）
- `authors` 与 `author` 的兼容逻辑：有 `authors` 用 `authors`，否则用 `author`

### `new-section-slide(...)`：章节页

- 默认由 Touying 在一级标题处自动调用
- 内部使用 `custom-outline(...)`
- 默认策略：
  - 当前章节显示到二级
  - 其他章节仅显示一级

### `focus-slide(...)`：聚焦页

- 全屏强调页面
- 冻结页码计数
- 可用 `background-color` 或 `background-img`
- 两者都不传时回退主色背景

### `empty-slide(...)`：空白页

- 无页眉页脚的自由页面
- 冻结页码计数
- 同样支持背景色/背景图

### `outline-slide(...)`：目录页

- 由 `empty-slide` 包装实现
- 左侧标题 + 右侧 `outline(...)`
- 可配置 `title/logo/depth/columns/text-styles/layout-config`

### `matrix-slide(...)`：矩阵页

- 使用 `components.checkerboard` 生成棋盘布局
- 冻结页码计数
- `columns/rows` 支持整数、数组或 `none`

### `img(...)`：图片便捷函数

签名：

```typst
#img(place: center + horizon, path, width: auto, height: auto, caption: none, numbering: none)
```

## 颜色主题（`color-themes.typ`）

### 内置主题

- `theme-ucas`
- `theme-elegant-green`
- `theme-modern-purple`
- `theme-vibrant-orange`
- `theme-deep-slate`
- `theme-sky-blue`
- `theme-professional-red`

实际上，`assets/vi` 下有三套图标，分别对应：

- `IVPP`-`中国科学院古脊椎动物与古人类研究所`
- `PKU`-`北京大学`
- `UCAS`-`中国科学院大学`

使用方式：

```typst
#import "color-themes.typ": theme-elegant-green

#show: university-theme.with(
  colors: theme-elegant-green,
  config-info(...),
)
```

### 自定义主题

```typst
#import "color-themes.typ": create-custom-theme

#let my-theme = create-custom-theme(
  primary: rgb("#8b0000"),
  secondary: rgb("#cd5c5c"),
)

#show: university-theme.with(
  colors: my-theme,
  config-info(...),
)
```

## 上下文目录（`custom-outline.typ`）

模块导出：

- `current-heading(level: auto, outlined: true)`
- `headings-context(target: heading.where(outlined: true))`
- `custom-outline(filter, transform, target, ..args)`

`custom-outline` 的 `hd` 上下文字段包含：

- `here-path` / `here-level`
- `level` / `path`
- `relation`：`same` / `parent` / `child` / `sibling` / `unrelated`
- `loc` / `heading`

示例：只高亮当前章节与子章节。

```typst
#import "custom-outline.typ": custom-outline

#custom-outline(
  filter: hd => hd.relation != none and (hd.relation.same or hd.relation.child),
  transform: (hd, it) => {
    if hd.relation.same {
      text(weight: "bold", size: 1.2em, it)
    } else {
      it
    }
  },
  depth: 2,
)
```

## 与 `main.typ` 的对应关系

`main.typ` 是完整示例，演示了：

- 通过 `presentation-info` 集中管理演示信息
- `#show: university-theme.with(config-info(..presentation-info))`
- 自定义 `highlight` 文本函数
- 基于 `empty-slide + custom-outline` 构建目录页
- `#show quote` 与 `#show math.equation` 的局部排版定制

此外，示例中还额外引入了 `mitex`、`tablem`、`fletcher` 等包用于内容演示，这些不是主题核心所必需。

## 已知行为与注意事项

1. `aspect-ratio` 只能是 `"16-9"` 或 `"4-3"`。
2. `color-palette` 参数目前未接入计算链路，直接传入不会改变主题色。
3. 仅设置 `authors` 不设置 `author` 时，页脚左列可能为空（取决于你是否覆盖 `footer-a`）。
4. `focus-slide`、`empty-slide`、`matrix-slide`、`title-slide` 默认冻结页码计数。
5. `outline-slide` 使用的是 Typst 原生 `outline()`，若需上下文感知行为请用 `custom-outline()`。

## 常见定制配方

### 关闭进度条

```typst
#show: university-theme.with(
  progress-bar: false,
  config-info(...),
)
```

### 自定义页眉页脚

```typst
#show: university-theme.with(
  header: self => [自定义左侧],
  header-right: self => [自定义右侧],
  footer-columns: (1fr, 2fr, 1fr),
  footer-a: self => [左],
  footer-b: self => [中],
  footer-c: self => [右],
  config-info(...),
)
```

### 覆盖章节页函数

```typst
#show: university-theme.with(
  config-common(
    new-section-slide-fn: new-section-slide.with(numbered: false),
  ),
  config-info(...),
)
```

---

如果你计划二次开发，建议按顺序阅读：

1. `theme.typ`（主题入口与页面函数）
2. `custom-outline.typ`（上下文目录机制）
3. `color-themes.typ`（主题色组织方式）

## 开发计划

- 依照实际使用体验改进，尚无明确开发计划
- 如有新的需求，请提出issue
- 本项目应当会长期维护
