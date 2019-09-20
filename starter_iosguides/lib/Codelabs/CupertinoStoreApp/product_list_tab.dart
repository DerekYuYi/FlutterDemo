import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/product_row_item.dart';

/// 商品列表
class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // TODO: What Consumer<AppStateModel> is meaning?
    return CupertinoPageScaffold(
      child:  Consumer<AppStateModel>(
        builder: (context, model, child) {

          // 通过 model 获取商品列表
          final products = model.getProducts();

          return CustomScrollView(
            semanticChildCount: products.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar( // iOS 11 的导航栏，那岂不是所有 iOS 平台（包括 iOS 11 以下的也能使用）
                largeTitle: Text('Cupertino Store'),
              ),

              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < products.length) {
                          return ProductRowItem(
                            index: index,
                            product: products[index],
                            lastItem: index == products.length - 1,
                          );
                        }
                        return null;
                      }
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}