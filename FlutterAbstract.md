### 安装知识
flutter config --no-analytics: 取消发送日志报告给 google

Flutter 初始化指南:

1. 安装包放在 FlutterLibrary 文件下 (FlutterLibrary 是本人自定义的文件夹), 后面大多数操作都需要在这个文件夹下面执行

2. cd 到 Private, 然后执行 
`export PATH="$PATH:`pwd`/flutter/bin"`

3. 执行 flutter doctor

注意: 安装 andriod sdk 的方法: 直接下载 Android Studio, 然后打开该应用, 应用会自动安装 SDK, 记下 SDK 的位置 (比如我安装的位置是 `/Users/derekyuyi/Library/Android/sdk`) 

按提示下载对应的提示项目, 比如要下载 Android Studio, 下载 tool 等

用 flutter 进行开发, 有两个组成: editor 和 Flutter SDK. 使用 Dart 语言

对于不是 dart 格式的代码, 可以: 选中代码 -> 右击 -> `Reformat Code with dartfmt`

在 Flutter 中, 几乎所有的东西都是组件(widgets), 包括 alignment, padding, layout. 一个组件的主要工作是提供一个 `build()` 方法, 用来描述怎样显示由其他小组件显示的组件.

Home brew 的常用命令:

brew search 软件名   
brew install 软件名  
卸载: brew remove 软件名 

`flutter run`: 在 flutter项目 的根目录下运行

### 知识点

Material 风格的应用, 
Material 是一种移动端和网页端通用的视觉设计语言
Flutter 提供了丰富的 Material 风格的 widgets.

Dart :

1. 使用了 (=>) 符号，这是 Dart 中单行函数或方法的简写 
2. 一个 widget 的主要工作是提供一个 build() 方法来描述如何根据其他较低级别的 widgets 来显示自己
3. final 修饰的属性表示不能改变
4. Stateless widgets 是不可变的，这意味着它们的属性不能改变, 所有的值都是 final
5. 在 Dart 语言中使用下划线前缀标识符，会 强制其变成私有

### 知识点

- ViewControllers VS Widgets. Flutter 中的屏幕是 Widgets 表示的, 因为 ”万物皆 widget“. 使用 Navigator 在不同的 Route 之间切换, 而不同的 route 则代表了不同的屏幕或页面, 或是不同的状态, 也可能是渲染相同的数据.


**如果实现一个有状态的 Widget**: 

1. Stateless Widget 是不可变的. Stateful widgets 持有的状态可能在 widget 生命周期中发生变化, 实现一个 Stateful widget 至少需要两个类:

- Stateful Widget 类
- State 类, Stateful widget 类本身是不变的, 但是 State 类在 widget 生命周期中始终存在

2. 如何动态更新 ListView?
	
	使用 `ListView.Builder` 来构建列表, 当你的数据量很大, 且需要构建动态列表时, 这个方法会好用. 
	
3. 如何添加一个点击监听? 有两种方法来添加事件监听者:
	- 如果 widget 本身支持事件监测, 则直接传递处理函数给它. 例如, RaisedButton 拥有一个 onPressed 参数.
	- 如果 widget 本身不支持检测, 那么把它封装到一个 GestureDetector 中, 并给它的 onTap 参数传递一个函数
4. 使用 GestureDetector 来监听更多的手势: 单击事件, 双击事件, 长按事件, 垂直拖动事件, 水平拖动事件
5. 表单提交操作需要通过特定的 widget 来实现. 类似于 iOS 中 TextField 和 TextView.

### flutter 的常用网站

- [__flutter三方的搜索网站: pub.dev__](https://pub.flutter-io.cn/flutter/packages?page=1)

### 练习教程

## Cookbook
 0.	仿真动画(一个拖动动画): `AnimationController`, `GestureDetector`
 1. Container 里的动画渐变效果   
 	container 类提供一系列实用方法, 能够便捷地创建出一个具有指定宽度、高度、背景颜色、外边距和边框等属性的 widget. 简单的动画通常会在一段时间内改变这些属性. 例如你可能想将灰色背景逐渐变为绿色背景来告诉用户.
 	为了制作这样的简单动画效果, Flutter 提供了 AnimatedContainer widget. 在使用新属性进行重建时, 将会自动在旧值和新值之间生成动画. 被称为`隐式动画`.
 2. Widget 的淡入淡出效果: 使用 `AnimatedOpacity`. 
 3.	 页面切换间的路由转场动画: 使用 `PageRouteBuilder` 提供动画, 使用 	`Tween` 和 `Curve` 对象来自定义转场动画
 4. 使用 Themes 统一颜色和字体风格
 		- 定义全局的 theme: 会影响整个 app 的颜色和字体样式;
 		- 定义一个独立的 Theme: 定义一个独立的 `ThemeData` 或者从父级 Theme 扩展(`copyWith:`方法)
 		- `Theme.of(context)` 会查询 widget 树, 并返回其中最近的 Theme. 所以如有自定义的 Theme, 会优先返回. 如果找不到, 它会返回 theme.
 5. 使用 `Tabs`: `DefaultTabController`
 6. 使用 `Drawer`(抽屉): 需要在 Scafford 下使用 Drawer. Material Design 设计准则里, 主要提供了两种导航方式: Tab 和 Drawer.
 	- 创建一个 Scafford 
 	- 添加一个 drawer
 	- 向 drawer 中添加内容
 	- 通过编程关闭 drawer: 当用户打开 Drawer 时, Flutter 会将 drawer widget 覆盖在当前的导航堆栈上. 因此要关闭, 通过 Navigator.pop(context) 来实现.

### 小知识点 

终端下进入 Application 后, 没有一个应用的原因:

~/Application 是共有的, 展开来是 /Users/用户名/Applications

finder 里面的 /Applications 是私有的

所以我们从 `cd Applications` 进去是私有路径, 这时候看不到任何一个应用; 正确的做法是执行 `cd ~/Application`.


linux 命令:

pwd: 输出当前目录的路径

