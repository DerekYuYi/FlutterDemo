import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'package:starter_iosguides/colors.dart';

final ThemeData _kShrineTheme = _buildShrineTheme();

// 设置样式

// Build a Shrine theme
// 应用全局主题颜色
ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    accentColor: kShrineAltDarkGrey,
    primaryColor: kShrineAltDarkGrey,
    buttonColor: kShrineAltYellow,
    scaffoldBackgroundColor: kShrineAltDarkGrey,
    cardColor: kShrineAltDarkGrey,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    // 使用自定义的主图标主题
    primaryIconTheme: base.iconTheme.copyWith(
      color: kShrineAltYellow
    ),
    // 更改文本输入框的主题
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}

// Build a Shrine Text Theme
// 设置特定文本样式, 通过 apply 的方式设置 fontFamily, 将只会影响通过调用 copywith() 的属性
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
      fontSize: 18.0,
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kShrineSurfaceWhite,
    bodyColor: kShrineSurfaceWhite,
  );
}


class ShrineApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _kShrineTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if(settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );

  }

}
