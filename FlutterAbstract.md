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

### 基础

Material 风格的应用, 
Material 是一种移动端和网页端通用的视觉设计语言
Flutter 提供了丰富的 Material 风格的 widgets.

Dart :

1. 使用了 (=>) 符号，这是 Dart 中单行函数或方法的简写 
2. 一个 widget 的主要工作是提供一个 build() 方法来描述如何根据其他较低级别的 widgets 来显示自己
3. final 修饰的属性表示不能改变
4. Stateless widgets 是不可变的，这意味着它们的属性不能改变, 所有的值都是 final
5. 在 Dart 语言中使用下划线前缀标识符，会 强制其变成私有
6. dart 中 return 语句后一定要以 ';'结尾
7. 取变量 result 的值: Text('$result')

### 关键字
8. @required, final, await, async, this, factory, extends, dynamic


Dart 语法糖:
1. ```Scaffold.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('$result')));```


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
6. 对于长寿命对象, 一定要在 initState() 和 dispose() 管理生命周期.

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
 7. 使用 `SnackBar`(实现操作后的用户提醒功能): 在 Scafford 中显示.
 8. 屏幕旋转更新界面: 使用 `OrientationBuilder` 来更改列数. 可以使用 `MediaQuery.of(context).orientation` 来单独获取屏幕方向.
 9. 表单验证:
 	- 使用全局的 GlobalKey 来访问一个表单. 使用 GlobalKey.currentState() 方法去访问 FormState, 而 FormState 是在创建表单 Form 时 Flutter 自动生成的.
 	- FormState 类包含了 	__validate()__ 方法. 当 __validate()__ 方法被调用时, 会遍历云心表单中所有文本框的 __validator()__ 函数. 如果全部通过, validate() 就返回 true. 如果有哪个文本框验证不通过, 就会在那个文本框区域显示错误提示, 同时 validate() 返回 false.
 10. 如何取表单中的值:创建 `TextEditingController`, 并加到对应的 TextField 上. 
 11. 如何聚焦文本框: 创建 **FocusNode** -> 传递给 TextField -> `onPressed: () => FocusScope.of(context).requestFocus(myFocusNode)` 触发成为焦点(第一响应者)
 12. 如何响应文本框内容的更改, 比如每次在文本框的文本内容变化时都调用回调函数:
 		1. 给 TextField 绑定 `onChanged` 回调. 该方法不适合 `TextFormField` 组件.
		2. 使用 **TextEditingController** 绑定为文本框的 controller 属性. 使用 `addListener()` 方法来监听 TextEditingController 的 text 变化.
 13. 使用 __Dismissible__ 包裹需要清除的列表单元, 实现滑动清除功能;
 14. 使用 __GestureDetetor__ 来捕获和处理点击动作;
 15. 使用 `Image.network` 直接加载网络图片. 直接支持加载 gif. 使用 __cached_network_image__ 包来实现缓存网络图片, 占位符, 和加载后图片的淡入.
 16. ListView:
 	 1. 短列表可以直接使用构造方法一次性创建;
 	 2. 长列表必须使用 `ListView.builder` 把数据渲染成组件, 只在从屏幕外滑到屏幕显示时才会创建;
 	 3. 添加随列表滚动的 app bar: 使用 __CustomScrollView__, 并在 CustomScrollView 中添加 SliverAppBar 来添加浮动的 app bar, 使用 sliverList 来添加一个列表
 	 4. 在列表中实现不同的单元类型: 先实现拥有不用单元类型的数据源; 在把数据源转换成不同 Widgets
 17. Navigation:
 	 1. 传递数据到新页面: 在新页面的声明需要传递的数据源变量, 跳转时赋值即可;
 	 2. 导航到新页面和返回: Navigator.push() or Navigator.pop()
 	 3. 导航到对应名称的 Routes: 在 MaterialApp 的构造函数中初始化 `initialRoute`(从哪个路由启动页面)和 `routes`(路由列表). 然后使用 __Navigator.pushNamed(context, 'routeName')__ 去到对应路由, 使用 Navigator.pop() 返回
 	 4. 给特定的路由传递参数: 
 	 	- 1. 在 **Navigator.pushNamed()方法中的 arguments 属性**里提供需要传递的参数, 在特定路由构造函数里接受参数;
 	 	- 2. 从组件提取参数: 在路由表中增加对应组件 -> 使用 **Navigator.pushNamed(arguments)** 导航到组件, argument 是携带参数 -> 在特定路由使用 **ModalRoute.of(context).settings.arguments** 提取传递对应参数 arguments.
 	 	- 3. 还可以使用 **onGenerateRoute()** 提取参数, 然后把参数传递给组件.
 	 5. 页面切换时组件的转场动画: 使用 **Hero**组件. Hero 在不同 route 之间的 tag 保持一致.
 
### flutter 常见命令

flutter pub get: 更新导入的新库
flutter packages get: 下载下来的三方库放在 flutter 包的目录下, 而不一定是在项目目录下面.
 
### 小知识点 

终端下进入 Application 后, 没有一个应用的原因:

~/Application 是共有的, 展开来是 /Users/用户名/Applications

finder 里面的 /Applications 是私有的

所以我们从 `cd Applications` 进去是私有路径, 这时候看不到任何一个应用; 正确的做法是执行 `cd ~/Application`.


linux 命令:

pwd: 输出当前目录的路径
