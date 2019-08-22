import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';

    return MaterialApp(
      title: title,
      home: MyHomePage(
          title: title,
          // 创建连接到服务器的 IOWebSocketChannel
          channel: IOWebSocketChannel.connect('ws://echo.websocket.org')
      ),
    );
  }
  

}

class MyHomePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;
  
  MyHomePage({Key key, @required this.title, @required this.channel}) : super(key: key);
  
  @override _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // 关闭 WebSocket 连接
    widget.channel.sink.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),

            // 使用 StreamBuilder 监听新消息
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // 向服务器发送数据
      widget.channel.sink.add(_controller.text);
    }
  }
  
}
