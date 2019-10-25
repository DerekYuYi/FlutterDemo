
import 'package:flutter/material.dart';

// 在 Flutter 中，Widget 通过回调的到状态改变的通知，同时当前状态通知给其他 widget 用于显示。
// 重定向这一流程的共同父级是 state.

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}


class CounterIncrementor extends StatelessWidget {

  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CounterIncrementor(onPressed: _increment),
        CounterDisplay(count: _counter),
      ],
    );
  }
}

// 例子:  一个购物应用显示各种出售的产品, 并在购物车中维护想购买的物品.

// 1. 当用户点击列表中的一项，widget 不会直接改变 `inCart` 的值，而是通过调用父 widget 接受到的 onCartChanged 函数。
//    这种方式可以在组件的生命周期哪种呢存储状态更长久，从而使状态持久化。甚至，widget 传给 runApp() 的状态可以持久到整个应用的生命周期
// 2. 当父级接收到 onCartChanged 回调时，父级会更新其内部状态，从而触发父级重建并使用新的 inCart 值来创建新的 ShoppingListItem 实例。
//    尽管父级在重建时会创建 ShoppingListItem 的新实例，但是由于框架会将新构建的 widget 与先前构建的 widget 进行比较，仅将差异应用于底层的 RenderObject，这种代价是很小的

class Product {

  const Product({this.name});
  final String name;
}

typedef void CartChangeCallback(Product product, bool inCart);

// 用于显示单个列表项
class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: ObjectKey([product]));

  final Product product;
  final bool inCart;
  final CartChangeCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}


class ShoppingList extends StatefulWidget {

  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time a widget appears at a given location
  // in the tree, If the parent rebuilds and uses the same type of widget (with the same key),
  // the framework re-uses the State object instead of creating a new State object.

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {

    setState(() {
      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}


