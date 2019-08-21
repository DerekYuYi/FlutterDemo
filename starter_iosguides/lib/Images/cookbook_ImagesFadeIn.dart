
/*使用 FadeInImage 淡入显示图片*/
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';


// 使用占位符
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Stack(
          children: <Widget>[
            Center(child: CircularProgressIndicator()),

            // 1. 从内存加载占位符
            Center(
              child: FadeInImage.memoryNetwork(

                // 使用 transparent_image 实现一个简单的透明占位符
                placeholder: kTransparentImage,

                image: 'https://picsum.photos/250?image=9',
              ),
            ),

            // 2. 从本地存储加载占位符
            Center(
              child: FadeInImage.assetNetwork(
                // 使用本地资源作为占位符
                placeholder: 'assets/loading.gif',
                image: 'https://picsum.photos/250?image=9',
              ),
            ),
          ],
        ),
      ),
    );

    // 2. 从本地存储加载占位符

  }

}


// 使用 Image 来加载网络图片
class ImageDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Image.network(
//          'https://picsum.photos/250?image=9',
// Image 直接加载 Gif
          'https://github.com/flutter/plugins/raw/master/packages/video_player/doc/demo_ipod.gif?raw=true',
        ),
      ),
    );
  }

}

