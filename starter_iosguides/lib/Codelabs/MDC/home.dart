import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/model/product.dart';
import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/model/products_repository.dart';
import 'package:starter_iosguides/Codelabs/MDC/supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {

  final Category category;

  const HomePage({this.category: Category.all});

  @override
  Widget build(BuildContext context) {

    return AsymmetricView(products: ProductsRepository.loadProducts(category));
    /*
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'Menu',
          ),
          onPressed: () {
            debugPrint('Menu button');
          },
        ),
        // 标题尾部添加按钮。在 Flutter 中它们被称为 'actions'.
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              debugPrint('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              debugPrint('Tune button');
            },
          ),
        ],
        title: Text('SHRINE'),
      ),

      body: GridView.count(
        crossAxisCount: 2, // 指不可滚动轴展示的数量，这里是水平方向
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context)
      ),
    );
     */
  }

  // Make a collection of cards
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    // 获取当前的文本样式
    final ThemeData theme = Theme.of(context);

    // 货币格式设置
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        elevation: 0.0, // 标高： 类似于 iOS 中 z 轴高度
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product == null ? '' : formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

}

