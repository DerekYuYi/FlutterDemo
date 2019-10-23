import 'package:flutter/material.dart';

/**
 *  hero 是指不同屏幕之间飞行的 widgets. hero animation: 把一个 widget 从一个屏幕飞到另一个屏幕的动画 （在 iOS 这被成为转场动画？？）
 *  使 hero 从一个屏幕飞行到另一个屏幕。
 *  Hero widget 实现的动画风格被普遍称为：shared element transitions or shared element animations. 共享元素转换和共享元素动画。
 * */

// 创建 hero，指定其大小， 图片和点击行为

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

// 创建源和目的 PhotoHeroes, 并且初始化 transition.
class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
//    timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'images/flippers-alpha.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Flippers Page'),
                    ),
                    body: Container(
                      // The blue background emphasizes that it's a new route.
                      color: Colors.lightBlueAccent,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: PhotoHero(
                        photo: 'images/flippers-alpha.png',
                        width: 100.0,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                }
            ));
          },
        ),
      ),
    );
  }
}