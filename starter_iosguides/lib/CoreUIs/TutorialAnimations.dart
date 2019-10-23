import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

// 实现放大、缩小，时隐时现效果
// 教程： https://flutter.cn/docs/development/ui/animations/tutorial

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);

//    animation = Tween<double>(begin: 0, end: 300).animate(controller)
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
    ..addStatusListener((status) {
      // 添加呼吸效果
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    })
    ..addStatusListener((state) => debugPrint('$state'));

    // addListener -> setState -> 标记当前 frame 为 dirty -> build
    /*
    ..addListener(() {
      setState(() {
        // The state that has changed here is the animation object's value.
      });
    });
    */
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);
  /*
  Widget build(BuildContext context) => GrowTransition(
    child: LogoWidget(),
    animation: animation,
  );
  */

  @override
  void dispose() {
    // Dispose of the controller when the animation is finished to prevent memory leaks.
    controller.dispose();
    super.dispose();
  }
}

// --------- 使用 AnimatedWidget 进行简化 ---------
// 在绘制时，AnimatedLogo 会读取 animation 当前值。

class AnimatedLogo extends AnimatedWidget {

  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  AnimatedLogo({Key key, Animation<double> animation}): super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}


// --------- 使用 AnimatedBuilder 进行重构 ---------

// 渲染 logo
class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: FlutterLogo(),
  );
}

// 渲染过渡效果
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Center(
    child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) => Container(
          height: animation.value,
          width: animation.value,
          child: child,
        ),
    ),
  );
}


// --------- 同步动画 ---------

// 展示了如何在同一个动画控制器中使用复合补间动画，每个补间动画口感女孩子一个动画的不同效果。