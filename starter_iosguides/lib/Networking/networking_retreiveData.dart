import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
 * 1. Future 是 Dart 用来处理异步操作的一个核心类，它通常代表一个可能的值或者将来或许会用到的错误
 * 2. 将数据请求移除 build() 方法。每当 FLutter 需要改变视图中的一些内容时，频率非常高， 就会调用 build() 方法
 *    2.1. 传入 StatelessWidget: 相当于父组件负责调用数据获取方法，存储结果并传入你的组件中；
 *    2.2. 在 StatefulWidget 状态的生命周期中调用： 可以在 initState() (只会调用一次) 或者 didChangeDependencies() 中调用请求网络方法
 **/

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});
  
  // 工厂方法

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}


Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    // throw an error.
    throw Exception('Failed to load post');
  }
}


//void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          // 处理异步数据源
          child: FutureBuilder<Post>(
            future: post,

            // builder 渲染内容, 依赖于 Future 的状态
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}
