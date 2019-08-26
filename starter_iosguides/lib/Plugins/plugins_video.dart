import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/*
* 1. 创建一个 StatefulWidget 组件和 State 类
* 2。 在 State 类中增加一个变量来存放 VideoPlayerController
* 3. 在 State 类中增加另外一个变量来存放 VideoPlayerController.initialize 返回的 Future
* 4. 在 initState 方法里创建和初始化控制器
* 5. 在 dispose 方法里销毁控制器
* */


void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();

}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  VideoPlayerController _controller;
  Future<void> _initilizeVideoPlayerFuture;
  
  @override
  void initState() {

    // Create an store the VideoController. the VideoController offers several different constructors to play videos form assets, files,
    // or the internet.
    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _initilizeVideoPlayerFuture = _controller.initialize();
    
    _controller.setLooping(true);

    super.initState();
  }
  
  @override
  void dispose() {
    // Ensure disposing of the VideoController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoController to finish initializing.
      body: FutureBuilder(
        future: _initilizeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the correct icon is shown.
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}