import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:starter_iosguides/Networking/networking_handleJsonInBackMode.dart' as net_backMode;
import 'package:starter_iosguides/Codelabs/layout.dart' as layout;

/// 给 iOS 开发者的 Flutter 指南 （https://flutter-io.cn/docs/get-started/flutter-for/ios-devs）
/*
 *  1、 如何更新 widget? 使用 statelessWidget 和 statefulWidget. 两者的区别是， statefulWidget 中有一个 State 对象，它用来存储一些状态的信息，并在
 *      整个生命周期内保持不变。
 *  2、 如何对 widget 布局？ 使用 padding 来约束
 *  3、 不可以通过 addSubView 或者 removeFromSuperview 方法来动态的添加或者移除视图，因为 widget 是不可变的，没有直接提供同 addSubview
 *      相同的方法。但是可以通过向父视图传递一个返回值是 widget 的方法，并通过一个 boolean flag 来控制子视图的存在.
 *  4、 如何实现动画？将 widget 封装到 animated widget 中来实现带动画效果
 *  5、 如何构建在两个页面之间切换？Navigator 和 Route. Route 是应用中屏幕或者页面的抽象概念， Navigator 是管理多个 Route 的 widget.
 *
 */

void main() => runApp(layout.MyApp());

//void main() => runApp(multipleItems.MyApp(items: List<multipleItems.ListItem>.generate(1000, (i) => i % 6 == 0 ? multipleItems.HeadingItem("Heading $i") : multipleItems.MessageItem("Sender $i", "Message body $i"),
//)));

/// 通过 Route 和 Navigator 在两个页面之间跳转
/*
void main() {
  runApp(CupertinoApp(
    home: MyFadeTest(title: 'Fade demo'),
    routes: <String, WidgetBuilder> {
      '/a' : (BuildContext context) => MyPage(title: 'page A'),
      '/b' : (BuildContext context) => MyPage(title: 'page B'),
      '/c' : (BuildContext context) => MyPage(title: 'page C'),
    },
  ));
}

Navigator.of(context).pushNamed('/b');

// 获取入栈之后的路由的结果

// 打开定位页面
Map coordinates = await Navigator.of(context).pushNamed('/location');

Navigator.of(cotnext).pop({"lat": 43.821757, "long": -79.226392});

*/

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fade Demo",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyFadeTest(title: 'Fade demo'),

    );
  }
}

/// 构建自定义 widget: 需要组合一些小的 widget 而不是对它们进行扩展。

class CustomButton extends StatelessWidget {
  final String label;

  CustomButton(this.label);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: () {}, child: Text(label));
  }
}


/// 如何渲染到屏幕上

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {

    var paint = Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i+1], paint);
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}

class Signature extends StatefulWidget {
  SignatureState createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox referenceBox = context.findRenderObject();
          Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: CustomPaint(painter: SignaturePainter(_points), size: Size.infinite),
    );
  }
}

/// MyFadeTest

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: FadeTransition(
              opacity: curve,
            child: FlutterLogo(
              size: 100.0,
            )
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Fade',
          child: Icon(Icons.brush),
          onPressed: () {
            controller.forward();
          },
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}


///  SampleAppPage: 切换 widget; 通过 widget 适配
class SampleAppPage extends StatefulWidget {

  SampleAppPage( {Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

// 使用专门用于 SampleAppPage 的 State 泛型类.
class _SampleAppPageState extends State<SampleAppPage> {

  String textToShow = "I Like Flutter";

  // Default value for toggle
  bool toggle = true;

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  void _updateText() {
    setState(() {
      // update the text
      textToShow = "Flutter is Awesome!";
    });
  }

  // widget 不能变，通过状态的改变，在多个 widgets 中切换相应的 widget.
  _getToggleChild() {
    if (toggle) {
      return Text('Toggle one');
    } else {
      return CupertinoButton(
        onPressed: () {},
        child: Text('Toggle two'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(
        child: _getToggleChild(),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: Icon(Icons.update),
      ),
    );
  }
}