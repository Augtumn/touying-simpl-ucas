// ============================================================================
// 颜色主题集合 / Color Themes Collection
// ============================================================================
// 预定义的颜色主题，可直接导入使用
// ============================================================================

#import "theme.typ": default-color-palette

// ============================================================================
// 内置主题 / Built-in Themes
// ============================================================================

/// 默认蓝色主题（中国科学院风格）
#let theme-ucas = (
  primary: rgb("#174994"),
  primary-light: rgb("#1f5db9"),
  primary-dark: rgb("#0d2d5c"),
  secondary: rgb("#1f5db9"),
  tertiary: rgb("#1b67da"),
  accent: rgb("#174994"),
  highlight: rgb("#174994"),
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  background: white,
  background-alt: rgb("#f5f5f5"),
)

/// 典雅绿色主题
#let theme-elegant-green = (
  primary: rgb("#2d6a4f"),
  primary-light: rgb("#40916c"),
  primary-dark: rgb("#1b4332"),
  secondary: rgb("#52b788"),
  tertiary: rgb("#74c69d"),
  accent: rgb("#2d6a4f"),
  highlight: rgb("#40916c"),
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  background: white,
  background-alt: rgb("#f1faee"),
)

/// 现代紫色主题
#let theme-modern-purple = (
  primary: rgb("#6a4c93"),
  primary-light: rgb("#8661c1"),
  primary-dark: rgb("#4a3266"),
  secondary: rgb("#9d84b7"),
  tertiary: rgb("#b8a9c9"),
  accent: rgb("#6a4c93"),
  highlight: rgb("#8661c1"),
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  background: white,
  background-alt: rgb("#f8f5ff"),
)

/// 活力橙色主题
#let theme-vibrant-orange = (
  primary: rgb("#d9534f"),
  primary-light: rgb("#e76f51"),
  primary-dark: rgb("#b23a36"),
  secondary: rgb("#f4a261"),
  tertiary: rgb("#e9c46a"),
  accent: rgb("#d9534f"),
  highlight: rgb("#e76f51"),
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  background: white,
  background-alt: rgb("#fef5f1"),
)

/// 深沉灰蓝主题
#let theme-deep-slate = (
  primary: rgb("#264653"),
  primary-light: rgb("#2a9d8f"),
  primary-dark: rgb("#1a2f38"),
  secondary: rgb("#287271"),
  tertiary: rgb("#4a7c7f"),
  accent: rgb("#2a9d8f"),
  highlight: rgb("#2a9d8f"),
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  background: white,
  background-alt: rgb("#f0f4f5"),
)

/// 清新天蓝主题
#let theme-sky-blue = (
  primary: rgb("#0077b6"),
  primary-light: rgb("#00b4d8"),
  primary-dark: rgb("#03045e"),
  secondary: rgb("#0096c7"),
  tertiary: rgb("#48cae4"),
  accent: rgb("#0077b6"),
  highlight: rgb("#00b4d8"),
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  background: white,
  background-alt: rgb("#f0f9ff"),
)

/// 专业红色主题
#let theme-professional-red = (
  primary: rgb("#9d0208"),
  primary-light: rgb("#d00000"),
  primary-dark: rgb("#6a040f"),
  secondary: rgb("#dc2f02"),
  tertiary: rgb("#e85d04"),
  accent: rgb("#9d0208"),
  highlight: rgb("#d00000"),
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  background: white,
  background-alt: rgb("#fff5f5"),
)

// ============================================================================
// 辅助函数 / Helper Functions
// ============================================================================

/// 创建自定义颜色主题
/// 
/// 参数 / Parameters:
/// - `primary`: 主色调
/// - `secondary`: 次要颜色（可选，默认为主色调的浅色版本）
/// - `tertiary`: 第三颜色（可选，默认为次要颜色的浅色版本）
/// - `text`: 文字颜色（可选，默认为深灰色）
/// - `background`: 背景颜色（可选，默认为白色）
/// 
/// 返回 / Returns:
/// - 完整的颜色主题对象
#let create-custom-theme(
  primary,
  secondary: auto,
  tertiary: auto,
  text: black.transparentize(20%),
  background: white,
) = {
  let sec = if secondary == auto {
    primary.lighten(20%)
  } else {
    secondary
  }
  
  let ter = if tertiary == auto {
    sec.lighten(20%)
  } else {
    tertiary
  }
  
  (
    primary: primary,
    primary-light: primary.lighten(15%),
    primary-dark: primary.darken(20%),
    secondary: sec,
    tertiary: ter,
    accent: primary,
    highlight: primary.lighten(10%),
    text: text,
    text-light: text.lighten(20%),
    text-inverse: white,
    background: background,
    background-alt: background.darken(3%),
  )
}

// ============================================================================
// 使用示例 / Usage Examples
// ============================================================================

/* 
在 lecture_1_slides.typ 中使用预定义主题：

#import "color-themes.typ": theme-elegant-green

#show: university-theme.with(
  colors: theme-elegant-green,
  config-info(...),
)

---

创建自定义主题：

#import "color-themes.typ": create-custom-theme

#let my-theme = create-custom-theme(
  primary: rgb("#8b0000"),
  secondary: rgb("#cd5c5c"),
)

#show: university-theme.with(
  colors: my-theme,
  config-info(...),
)
*/
