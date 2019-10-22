import 'package:flutter/material.dart';


/// 为你的 Flutter 应用添加交互体验 - 状态管理篇章
/*
* 1. widget 管理自身的状态
* 2. 父 widget 管理此 widget 的状态
* 3. 混搭管理
* */


// 1. TapboxA manages its own state.

// ---------------------- TapboxA ----------------------
class TapboxA extends StatefulWidget {
  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

// 2. ParentWidget manages the state for TapboxB.

/* ParentWidgetState 类：
    - 为 TapboxB 管理 _active 状态；
    - 实现 _handleTapBoxChanged(), 当盒子被点击时调用的方法；
    - 当状态改变时，调用 setState() 更新 UI.

   TapboxB 类：
   继承 StatelessWidget， 因为所有的状态都是其父 widget 处理；
   当检测到点击时，他会通知父 widget.
*/
// ---------------------- ParentWidget ----------------------
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

// 3. ParentCWidget manages the state for TapboxC.

/* _ParentCWidgetState 类：
    - 为 TapboxC 管理 _active 状态；
    - 实现 _handleTapBoxChanged(), 当盒子被点击时调用的方法；
    - 当状态改变时，调用 setState() 更新 UI.

   _TapboxCState 类：
    - 管理 _highlight 状态;
    - 当用户点下时，它添加高亮；当用户释放时，移除高亮
    - 当按下、抬起或者取消点击时更新 _highlight 状态， 调用 setState() 更新 UI
    - 当点击时，widget 属性将状态改变传递给父 widget 并进行合适操作
*/

// ---------------------- ParentCWidget ----------------------
class ParentCWidget extends StatefulWidget {
  @override
  _ParentCWidgetState createState() => _ParentCWidgetState();
}

class _ParentCWidgetState extends State<ParentCWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TapboxC(
          active: _active,
          onChanged: _handleTapboxChanged,
        )
    );
  }
}

// ---------------------- TapboxC ----------------------

class TapboxC extends StatefulWidget {

  TapboxC({Key key, this.active: false, @required this.onChanged}): super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => _TapboxCState();

}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    setState(() {
      widget.onChanged(!widget.active);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Handle the tap events in the order that they occur: down, up, tap, cancel
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? Border.all(
            color: Colors.teal[700],
            width: 10.0,
          ) : null,
        ),
      ),
    );
  }
}

// ---------------------- MyApp ----------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('State Demo'),
        ),
        body: Center(
          child: TapboxA(),
        ),
      ),
    );
  }
}

