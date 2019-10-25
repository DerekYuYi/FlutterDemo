
### 基础

Material 风格的应用, 
Material 是一种移动端和网页端通用的视觉设计语言
Flutter 提供了丰富的 Material 风格的 widgets.

Dart :

1. 使用了 (=>) 符号，这是 Dart 中单行函数或方法的简写: `=> expression` 是 `{ return expression; }`
2. 一个 widget 的主要工作是提供一个 build() 方法来描述如何根据其他较低级别的 widgets 来显示自己
3. final 修饰的属性表示不能改变
4. Stateless widgets 是不可变的，这意味着它们的属性不能改变, 所有的值都是 final
5. 在 Dart 语言中使用下划线前缀标识符，会 强制其变成私有
6. dart 中 return 语句后一定要以 ';'结尾
7. 取变量 result 的值: Text('$result')
8. const 修饰局部常量
9. static: 关键字来实现类变量和类方法
10. abstract 修饰某个类: 定义一个抽象类, 该类不能被实例化. 抽象类在定义接口的时候非常有用, 跟 Swift 中的 Protocol 非常相同. 都承担定义一组功能的责任. 在抽象类中定义一组抽象方法. 一个类可以 implements 来实现多接口: **class C implements A, B {}, A 和 B 都是抽象类**
11. mixin 功能: 因为没有多继承, 如果要综合多个类属性和方法可以 implements 多个接口, 如果不都是抽象类, 则可以通过 mixin 混入多个类的属性和方法.
12. **..**: 级联表达式, 调用方法. 返回值为 void 的函数不可使用

```
class A {
  void fnA() {
    print('fnA');
  }
}

abstract class B {
  void fnB() {
    print('fnB');
  }
}

class C extends Object with A, B {
  void fnA() {
    print('C_fnA');
  }
}

C c = new C();
  c.fnA();
  c.fnB();
  c.run();

```

11. `..`调用是什么意思: 
12. `double get name`: 实现 name 属性的 get 方法.   
13. 声明初始化函数时将其标记为 @required。 这是当构造函数中的属性没有默认值且不能为 null 时的最佳做法，切记这一标记。
      请注意，可在构造函数之后添加了 asserts 语句，用来检查传递过来的值不会为 null

### 关键字
1. @required: 是当构造函数中的属性没有默认值且不能为 null 时的最佳做法. 可在构造函数之后添加 asserts 语句, 用来检查传递过来的值不会为 null.
2. final: 修饰的属性表示不能改变
3. async: 表示函数是异步的, 定义的函数会返回一个  Future 对象, 可以使用 then 方法添加回调函数, 继续链式调用.
4. await: 后面跟着是一个 Future, 表示等待该异步任务完成, 异步任务完成后才会往下走; await 必须出现在 async 函数内部.
5. Future: 与 JavaScript 中的 Promise 相似. 表示一个异步操作的最终完成及其结果值的表示. 简单的来说, 异步成功了, 就执行成功的操作, 异步失败了就捕获错误. 一个 Future 只会对应一个结果.
4. this, factory, extends, dynamic
4. get && set: 属性的 getter 方法, 属性的 setter 方法, 例如: ``` bool get _frontLayerVisible { return true }```


Dart 语法糖:
1. ```Scaffold.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('$result')));```


### 知识点

- ViewControllers VS Widgets. Flutter 中的屏幕是 Widgets 表示的, 因为 ”万物皆 widget“. 使用 Navigator 在不同的 Route 之间切换, 而不同的 route 则代表了不同的屏幕或页面, 或是不同的状态, 也可能是渲染相同的数据.


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

 18. Camera 和 Video Play
 	1. 使用 **camera**插件实现相机模块拍摄图片和视频: 主要类有 `CameraController`, 读取照片和拍照
 	2. 使用 **video_player** 插件播放存储在本地文件系统中和视频和网络视频: 主要有 `VideoPlayerController`

 19. 测试: Widget 测试, Unit 测试, Integration 集成测试: 库有 **test** 和 **flutter_test**.

### Codelabs - 布局教程

mainAxisSize: .max, .min
  1. Column 和 Row 用来垂直和水平方向排列组合; 它们里面的组件被称为 children, Row 和 Column 被成为 parent, Row 是水平布局，Column 是垂直布局。（by the way, 跟 SwiftUI 里面的 HStack 和 VStack 一样）
  2. Row 和 Column 首先布局的是一个固定的大小, 固定大小是不灵活的, 它们无法在布局的时候重新调整大小
  3. 使用 Flexible Widget 来布局不固定大小
  4. Expanded Widget: 可以包一个组件， 并且约定组件填满控件
  5. SizedBox widget: 当包装一个组件，组件的宽高取决于设置的宽高; 当没有包装组件时, 则创建一个空的 space
  6. Spacer Widget: 在不同组件之间创建空白。与 SizedBox 的不同
  7. Stack: 不是线性(水平或者垂直)的. 而是按照绘制顺序将 Widget 堆叠在一起. 
  8. Container: 创建一个可见的矩形元素. Container 可以使用 BoxDecoration 来进行装饰. 如背景, 边框, 或阴影等. Container 可以设置外边距、内边距和尺寸的约束等等

### Codelabs - FriendlychatApp 小应用

1. 针对 iOS 和 Android 自定义(cupertino 和 meterial)
2. 通过聊天记录动态构建列表 ListView.builder
3. 使用 Flexible 布局动态列表
4. 使用 Flexible, Column, Row, Container 组合布局
5. 添加动画(SizeTransion, CurvedAnimation)

### Codelabs - CupertinoStoreApp (多 tab 应用)

0. 概要:
   - 目的: 创建 iOS 风格的 Flutter App;
   - 实现如何创建多个 tab 并在他们之间切换;
   - 使用 provider package 来实现多个界面之间的 state 管理: 使用 **Consumer<AppStateModel>( builder: (context, model, child) { })** , 拿到全局model: **final model = Provider.of<AppStateModel>(context);**

1. Styles.dart: 类似 CSS 中在一个文件中组合多样式, 实现 app 的多样式定义, static const 来定义全局静态常量;
2. app_state_model.dart: 创建 AppStateModel 来管理全局数据状态, 扩展  **ChangeNotifier**, 并在数据发生增删改查的情况下 **notifyListeners()** 去通知变化.
	
	```
	class AppStateModel extends foundation.ChangeNotifier {}
	```

3. 使用的 Cupertino Widgets 包括: CupertinoApp, CupertinoTabScaffold, CupertinoTabBar, CupertinoTabView, CupertinoTextField, CupertinoButton, CupertinoPageScaffold, CupertinoSliverNavigationBar, CupertinoDatePicker

4. 使用其他 widgets: SliverSafeArea, SliverList, SliverChildBuilderDelegate, ClipRRect(给组件加圆角)
5. 常用布局: Container, SizedBox(固定宽高, 间隙，空位符), Column, Row, Padding, BoxDecoration(修饰search bar等), Expanded(使子Column, Row, Flex 自动填充),

###  Google firebase 
 
 - Flutter 和 Firebase 携手助你以极快的时间来构建移动应用。 Flutter 是 Google 推出的便携 UI  工具包，帮助你在原生平台开发精美应用。而 Firebase 进一步让移动端具有访问后端服务的能力，包括鉴权，存储，数据库以及无服务器托管的服务。

###  MDC (Material Design)教程

1. 新熟悉 Widgets: ButtonBar(将按钮水平放置), Card, GridView, Stack, Tween (创建补间动画), 
2. Cross axis 在 Flutter 中意思是不可滚动的轴。 滚动的方向称为主轴。
3. Flutter 中，AppBar 中, 标题尾部添加按钮， 它们被称为 actions. 类似于 iOS 中的 right bar button items. 标题首部i添加按钮，被称为 leading.
4. 设置样式: 如果设置全局主题样式?
5. 一个简单的登录注册页面使用 ListView 来布局类似 Scrollview 或者 tableview 的效果: 页面可以滑动.
6. elevation: 标高值，类似于  Z 轴方向上的值
7. 所有的内容和组件背后都有 backdrop，它包括了后层（back layer）（用来显示 actions 和 filters）以及前层（front layer）（用来显示内容）。你可以使用 backdrop 来显示交互信息和操作，比如导航栏和内容过滤器
8. `semanticLabel` 用于语义提示, 可用于表明对应 widget 行为目的. 比如登录的按钮, 可设置为 ```semanticLabel: 'login',```
9. 按钮的 `onPressed` 属性值设置为 null, 表示该按钮会禁用, 传递空的代码块, 按钮可用

### FLutter 中的布局

1. 标准 widgets 和 Meterial 库中的 widgets. 任何 app 都可以使用 widget 库，但是 Meterial 库中的组件只能在 Meterial app 中使用。
2. 标准 widgets: Container, GridView, ListView, Stack
    - Container: 向 widget 增加 padding、margin、borders、background color 或其他的装饰
    - GridView: 将 widgets 展示为一个可滚动的网格（collectionView）
    - ListView: 将 widgets 展示为一个可滚动的列表
    - Stack: 将 widgets 覆盖在另一个的上面，叠加子控件作用
3. Meterial widgets: Card, ListTile
    - Card: 将相关信息整理到一个有圆角和阴影的盒子中， 通常与 ListTile 一起使用， 比如显示三个 ListTile 的卡片
    - ListTile: 将最多三行的文本、可选的导语以及后面的图标组织在一行中 （类型 UITableViewCell 的 default style 样式）


### Flutter 状态更新详解

以下来自 [flutter官方网站开发文档详解](https://flutter.cn/docs/development/ui/widgets-intro):

ShoppingList 类继承自 StatefulWidget, 这意味着这个 widget 存储着可变状态. 当 shoppingList 首次插入到 widget 树中, 框架调用 `createState()` 来创建 `_ShoppingListState`的新实例. 以与树中的该位置相关联. 当该 widget 的父 widget 重建时, 父 widget 首先
会创建一个 ShoppingList 的实例, 但是框架会复用之前创建的 `_ShoppingListState`, 而不会重新调用 createState.

为了访问当前 ShoppingList 的属性, _ShoppingListState 可以使用它的 widget 属性. 当父组件重建一个新的 ShoppingList 时, `_ShoppingListState` 会使用新的 widget 值来创建. 如果希望在 widget 属性更改时收到通知, 则可以重写 `didUpdateWidget()` 函数,
该函数将 oldWidget 作为参数传递, 以便将 oldWidget 与当前 widget 比较.

当处理点击回调时, `_ShoppingListState` 通过增加或删除 _shoppingCart 中的产品来改变其内部状态. 为了通知框架它改变了它的内部状态, 需要调用 setState(). 调用 setState() 会将该 widget 标记为 **dirty**, 并且计划在下次应用需要更新屏幕时重新构建它. 如果在修改 widget 内部状态时忘记使用 setState, 框架将不知道这个 widget 是 "dirty", 并且可能不会调用 widget 的 build() 方法, 这意味着用户界面可能不会更新以展示新的状态. 通过以这种方式管理状态，你不需要编写用于创建和更新子 widget 的单独代码。相反，你只需实现 build 函数，它可以处理这两种情况

**widget 的生命周期**

在 StatefulWidget 上调用 createState() 之后, 框架将新的状态对象插入到树中, 然后在状态对象上调用 initState(). State 的子类可以重写 initState 来完成只需要发生一次的工作. 例如, 配置动画, 订阅平台服务.

当不再需要状态对象时, 框架会调用状态对象的 dispose() 方法. 可以重写 dispose 方法来清理状态. 例如取消计时器, 移除动画, 取消订阅平台服务

**为你的 Flutter 添加交互体验**

- 一个 widget 的状态保存在一个 State 对象中. 它和 widget 显式分离. Widget 的状态是一些可以更改的值. 如一个滑动条的当前值, 或者一个复选框是否被选中. 当 widget 发生改变时, State 对象调用 setState(), 告诉框架去重绘 widget.
- 创建一个有状态 widget 的三要素:
	1. 创建两个类: 一个 StatefulWidget 的子类和 State 的子类;
	2. State 类包含该 widget 的可变状态并定义该 widget 的 build() 方法;
	3. 当 widget 状态改变时, State 对象调用 setState(), 告诉框架去重绘 widget.

- **状态管理**: 
	1. widget 管理自己的状态
	2. 父 widget 管理此 widget 的状态
	3. 混搭管理

- 如何决定使用哪种管理方法?遵循一下原则:
	1. 如果状态是用户数据, 如复选框的选中状态、滑块的位置, 则该状态最好由父 widget 管理;
	2. 如果讨论的状态是有关界面外观效果的, 例如动画, 那么状态最好由 widget 本身来管理;
	3. 如果不是很清楚, 首选是在父 widget 中管理状态.

**用户界面 - 资源和图片** (详见 开发文档 -> 用户界面 -> 资源和图片)

**动画效果**
  
- flutter 提供多渡动画, 比如 FadeTransition, SizeTransition 和 SlideTransition, 这些简单的动画可以通过设置起点和终点触发.
- __Animation__: Flutter 动画库中的核心类, 插入用于指导动画的值. 该对象知道动画目前的状态(是否开始, 暂停, 前进或则收后退), 但是对屏幕上的内容一无所知. 常见是 `Animation<double>`, 还可以插入 `Animation<Color>` 和 `Animation<Size>`. Animation 对象具有状态, 它的当前值在 `.value` 中始终可用.
- __AnimationController__: 管理 Animation. 特殊 Animation 对象. 每当硬件准备新帧时, 他都会生成一个值. 初始化时 vsync 的存在防止后台动画消耗不必要的资源. 默认情况下时 0.0 - 1.0. 如果需要不同的范围和不同的数据类型, 使用 Tween.
- **CurvedAnimation**: 非线性曲线
- **Tween**为动画对象插入一个范围值, 例如, Tween 可以定义插入值由红到蓝, 或从 0 到 255. 继承自 Animatable<T>. ColorTween 指定两种颜色之间的级数. Tween 不存储任何状态. 而是提供 evaluate 方法, 将映射函数应用于动画当前值. 
- **动画通知**: 使用 Listeners 和 StatusListeners 监视动画状态变化. 当动画值改变时调用 Listener. Listener 最常用的操作是调用 setState() 进行重建. 当一个动画开始，结束，前进或后退时，会调用 StatusListener，用 AnimationStatus 来定义
- 使用 AnimatedWidget 代替 addListener() 和 setState() 创建动画 widget. AnimatedWidget 不需要保持 State 对象来 hold 动画.
- AnimatedBuilder 描述动画, 这个动画作为 build 方法一部分.如果你只是单纯需要用可重复使用的动画定义一个 widget, 使用 AnimatedWidget. AnimatedBuilder 自动监听动画对象提示，并在必要时在 widget 树中标出，所以这时不需要调用 addListener().

**主过渡动画**

 - hero 是指不同屏幕之间飞行的 widgets. hero animation: 把一个 widget 从一个屏幕飞到另一个屏幕的动画 （在 iOS 这被成为转场动画？？）
 - 使 hero 从一个屏幕飞行到另一个屏幕。
 - Hero widget 实现的动画风格被普遍称为：shared element transitions or shared element animations. 共享元素转换和共享元素动画。
 - hero animation 基本构成
 	1. 在不同 route 之间有两个 hero widgets, 他们的 tag 相同;
 	2. Navigator 管理 routes stack.
 	3. 从 route stack 中 Pushing 或者 Poping 触发动画.
 	4. 当 hero 从一个 route 飞到另一个 route 时, flutter framework 计算 rectangle tween, 其定义 hero 的边界. 在飞行期间, hero 被移动到 应用覆盖层, 所以它出现在两个 routes 的顶层.
 - **Hero的工作原理**: 
 	1. Before transition: source hero 在 source tree widget 中. 此时目标 route 不存在, overlay 是空的;
 	2. Pushing 触发动画. 在动画时间 t = 0.0 时, flutter 做两个事:
 		1. 计算目标 hero 的离屏路径. Flutter 现在知道 hero 在哪里结束. 
 		2. 把目标 hero 放在 overlay 中,和 source route 中的位置和大小一样. 添加一个 hero 到 overlay 并且改变 Z 轴属性使他出现在所有 routes 的最上面;
 		3. 把 source hero 移除屏幕.
 	3. After transition. 飞行动画结束. 
 		1. flutter 把 hero 从 overlay 移动到 目标 route. overlay 层此时是空的.
 		2. 目标 hero 出现在目标 route 的最终位置上;
 		3. source hero 在 source route 上重新保存.
		
-  数据调用和后端
 
 状态: 当任何时候你需要重建你的用户界面时所需要的数据
 短时状态: 局部状态. 一个独立 widget 中的状态;
 应用状态: 全局状态. 也称为共享状态. 
 
 
#### 使用 provider 类和 provider package 管理状态

  - provider package 中提供三个概念:
  	- ChangeNotifier: flutter sdk 中的类. 它用于向监听器发送通知. 换言之，如果被定义为 ChangeNotifier，你可以订阅它的状态变化。（这和大家所熟悉的观察者模式相类似). ChangeNotifier 是一种能够封装应用程序状态的方法.
  	- ChangeNotifierProvider: ChangeNotifierProvider widget 可以向其子孙节点暴露一个 ChangeNotifier 实例.
  	- Consumer: Consumer widget 唯一必须的参数就是 builder。当 ChangeNotifier 发生变化的时候会调用 builder 这个函数。（换言之，当你在模型中调用 notifyListeners() 时，所有和 Consumer 相关的 builder 方法都会被调用。）

#### Json 和序列化数据

#### 应用的无障碍和国际化


### 平台集成
	
 - 撰写双端平台代码(插件编写实现) battery 例子.

### Packages(纯 Dart 和原生插件)

 - 使用 Packages
 - Package 的开发和使用
 
### flutter 常见命令

flutter 的命令执行都需要在 flutter sdk 安装包的目录上执行. 比如 flutter sdk 安装在 Document -> flutterLibrary 下,
则应该在该目录下配置 `export PATH="$PATH:`pwd`/flutter/bin"`, 

flutter pub get: 更新导入的新库
flutter packages get: 下载下来的三方库放在 flutter 包的目录下, 而不一定是在项目目录下面.


### 安装知识
flutter config --no-analytics: 取消发送日志报告给 google

Flutter 初始化指南:

1. 安装包放在 FlutterLibrary 文件下 (FlutterLibrary 是本人自定义的文件夹), 后面大多数操作都需要在这个文件夹下面执行

2. cd 到 Private, 然后执行 
`export PATH="$PATH:`pwd`/flutter/bin"` (每次执行 flutter 命令时都需要每次执行)

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


### 小知识点 

终端下进入 Application 后, 没有一个应用的原因:

~/Application 是共有的, 展开来是 /Users/用户名/Applications

finder 里面的 /Applications 是私有的

所以我们从 `cd Applications` 进去是私有路径, 这时候看不到任何一个应用; 正确的做法是执行 `cd ~/Application`.


linux 命令:

pwd: 输出当前目录的路径

### 常用的快捷键

+ commnand + 1: 切换左侧侧边栏
+ 打开悬停注释： Preference -> Editor -> General -> `show quick documentation on mouse move Delay (ms): 500`

	  
