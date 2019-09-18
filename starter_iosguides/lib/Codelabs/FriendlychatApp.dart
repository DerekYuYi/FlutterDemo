import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';


// 针对 iOS 和 Android 进行自定义
// 在 iOS 上使用 `CupertinoButton`, 在 Android 上则使用 Meterial Design `IconButton`.

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: "FriendlychatApp",
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  // 聊天消息列表
  final List<ChatMessage> _messages = <ChatMessage>[];

  final TextEditingController _textController = new TextEditingController();

  // indicates whether the input text is empty.
  bool _isComposing = false;

  @override

  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Text("Friendlychat"),
        // app bar 的 z 坐标
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(

          children: <Widget>[
            // 通知框架允许已接受的消息列表进行扩展以填充 Column 高度

            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true, // 表示是否从底部开始， 默认是 false, 从顶部显示
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTextComposer() {

    return IconTheme(
        // 指定当前主题背景颜色
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  decoration: new InputDecoration.collapsed(
                      hintText: "Send a message"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Theme.of(context).platform == TargetPlatform.iOS ?
                CupertinoButton(
                  child: Text("Send"),
                  onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                ) :
                IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
                )
              ),
            ],
          ),
        ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    // 更新 _isComposing 的值
    setState(() {
      _isComposing = false;
    });

    // 每次发送一条信息，创建对应的消息组件
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    // 调用 setState() 以修改 _messages, 并让框架了解此部分微件树已发生变化，且需要重新构建界面
    setState(() {
      _messages.insert(0, message);
    });

    // 发送时向前播放动画
    message.animationController.forward();
  }
}


const String _name = "Derek";

/// Chat message screen

class ChatMessage extends StatelessWidget {

  // 初始两个参数值作为成员变量的值
  ChatMessage({this.text, this.animationController});

  // 成员变量
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {

    return SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController,
            curve: Curves.fastOutSlowIn,
        ),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])), // 头像显示第一个字母
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_name, style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

