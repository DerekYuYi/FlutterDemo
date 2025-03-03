import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/model/product.dart';
import 'login.dart';

// 将其标记为 @required。 这是当构造函数中的属性没有默认值且不能为 null 时的最佳做法，切记这一标记。
// 请注意，可在构造函数之后添加了 asserts 语句，用来检查传递过来的值不会为 null
class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentCategory,
    @required this.backLayer,
    @required this.frontLayer,
    @required this.frontTitle,
    @required this.backTitle,
  }) :  assert(currentCategory != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(frontTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

const double _kFlingVelocity = 2.0;

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  // 加载到渲染层级之前只会被调用一次
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentCategory != oldWidget.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  // 在 widget 从渲染层级中移除时只会被调用一次
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    // Create a RelativeRectTween Animation
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);
    
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        // 当 back layer 不可见时，这个 widget 会将 backlayer 的菜单选项全部从层级中移除.
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      // replaced leading widget
      title: _BackdropTitle(
        listenable: _controller.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: 'login',
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'login',
          ),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            );
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      // 使用 LayoutBuilder 让 front/back layer 在布局时候才进行构建， 这样可以高效计算出 backdrop 的实际高度
      body: LayoutBuilder(builder: _buildStack),
    );
  }

  // get 修饰表示只读属性，这里只提供 getter 方法， 而并没有提供 setter 方法.
  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({Key key, this.onTap, this.child}) : super(key: key);
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );

  }
}

// 提供带有动画效果的菜单图标， 和在不同层级的标题之间切换的过渡动画

class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  }) : assert(frontTitle != null),
       assert(backTitle != null),
       super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
        style: Theme.of(context).primaryTextTheme.title,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Row(children: <Widget>[

          // branded icon
          SizedBox(
            width: 72.0,
            child: IconButton(
              padding: EdgeInsets.only(right: 8.0),
              onPressed: this.onPress,
              icon: Stack(children: <Widget>[
                Opacity(
                  opacity: animation.value,
                  child: ImageIcon(AssetImage('assets/slanted_menu.png')),
                ),
                FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(1.0, 0.0),
                  ).evaluate(animation),
                  child: ImageIcon(AssetImage('assets/diamond.png')),
                ),
              ]),
            ),
          ),

          Stack(
            children: <Widget>[
              Opacity(
                opacity: CurvedAnimation(
                  parent: ReverseAnimation(animation),
                  curve: Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(0.5, 0.0),
                  ).evaluate(animation),
                  child: backTitle,
                ),
              ),

              Opacity(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset(-0.25, 0.0),
                    end: Offset.zero,
                  ).evaluate(animation),
                  child: frontTitle,
                ),
              ),
            ],
          ),
        ]),
    );
  }

}

