import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/styles.dart';
import 'model/app_state_model.dart';
import 'model/product.dart';

const double _kDateTimePickerHeight = 216;

/// 负责掌控需要购买的产品列表和客户信息， 是一个 StatefulWidget

class ShoppingCartTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {

  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  // 货币单位
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            ),
          ],
        );
      },
    );
  }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(AppStateModel model) {
    return SliverChildBuilderDelegate(
        (context, index) {
          // 商品的序号， 4 表示固定的四个 Padding 块
          final productIndex = index - 4;
          switch (index) {
            case 0:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildNameField(),
              );

            case 1:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildEmailField(),
              );

            case 2:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildLocationField(),
              );

            case 3:
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: _buildDateAndTimePicker(context),
              );

            default:
              if (model.productsInCart.length > productIndex) {
                return ShoppingCartItem(
                    product: model.getProductById(model.productsInCart.keys.toList()[productIndex]),
                    index: index,
                    lastItem: productIndex == model.productsInCart.length - 1,
                    quantity: model.productsInCart.values.toList()[productIndex],
                    formatter: _currencyFormat);
                // the summary total price, taxs
              } else if (model.productsInCart.keys.length == productIndex && model.productsInCart.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // 约定子组件在主轴最右边
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end, // 约束子组件水平方向尾部对齐

                        children: <Widget>[
                          Text(
                            'Shipping '
                                '${_currencyFormat.format(model.shippingCost)}',
                            style: Styles.productRowItemPrice,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tax ${_currencyFormat.format(model.tax)}',
                            style: Styles.productRowItemPrice,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Total  ${_currencyFormat.format(model.totalCost)}',
                            style: Styles.productRowItemPrice,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
          }
          return null;
        },
    );
  }

  // build name field
  Widget _buildNameField() {
    return CupertinoTextField(
      // 现在文本前面的组件
      prefix: const Icon(
        CupertinoIcons.person_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,

      decoration: const BoxDecoration(
        border: Border(
          // 绘制边界宽度和颜色, 这里只设置底部的边界
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Name',
      onChanged: (newName) {
        setState(() {
          name = newName;
        });
      },
    );
  }

  Widget _buildEmailField() {
    return const CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.mail_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Email',
    );
  }

  Widget _buildLocationField() {
    return const CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.location_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Location',
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'Delivery time',
                  style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              style: Styles.deliveryTime,
            ),
          ],
        ),
        Container(
          height: _kDateTimePickerHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: dateTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
            },
          ),
        ),
      ],
    );
  }

}

/// 已添加购物车商品单元类
class ShoppingCartItem extends StatelessWidget {

  const ShoppingCartItem({
    @required this.product,
    @required this.index,
    @required this.lastItem,
    @required this.quantity,
    @required this.formatter,
  });

  final Product product;
  final int index;
  final bool lastItem;
  final int quantity;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: Styles.productRowItemName,
                        ),
                        Text(
                          '${formatter.format(quantity * product.price)}',
                          style: Styles.productRowItemName,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${quantity > 1 ? '$quantity x ' : ''}'
                          '${formatter.format(product.price)}',
                      style: Styles.productRowItemPrice,
                    ),
                  ],
                ),
                
              ),
            ),
          ],
        ),
      ),
    );

    return row;
  }
}
