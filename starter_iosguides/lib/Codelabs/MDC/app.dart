import 'package:flutter/material.dart';
import 'package:starter_iosguides/Codelabs/MDC/category_menu_page.dart';

import 'home.dart';
import 'login.dart';
import 'package:starter_iosguides/colors.dart';
import 'backdrop.dart';
import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/model/product.dart';

final ThemeData _kShrineTheme = _buildShrineTheme();

// 设置样式

// Build a Shrine theme
// 应用全局主题颜色
ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(); // 类似于 light, dark mode （iOS 13 新增了 dark mode）
  return base.copyWith(
    accentColor: kShrinePink100,
    primaryColor: kShrinePink100,
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


class ShrineApp extends StatefulWidget {

  @override
  _ShrineAppState createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category catogory) {
    setState(() {
      _currentCategory = catogory;
    });
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Backdrop(
        currentCategory: _currentCategory,
        frontLayer: HomePage(
          category: _currentCategory,
        ),
        backLayer: CategoryMenuPage(
          currentCategory: _currentCategory,
          onCategoryTap: _onCategoryTap,
        ),
        frontTitle: Text('SHRINE'),
        backTitle: Text('MENU'),
      ),
      theme: _kShrineTheme,
      title: 'Shrine',
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );

    /*
    return MaterialApp(
      title: 'Shrine',
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _kShrineTheme,
    );
     */
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
