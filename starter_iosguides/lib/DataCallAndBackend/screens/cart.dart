import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_iosguides/DataCallAndBackend/models/cart.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.display4,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.title;
    // 取全局的 cart
    var cart = Provider.of<CartModel>(context);

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.display4.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
            * 1. 必须指定要访问的类型，这里要访问的是 CartModel
            * 2. Consumer 唯一必须的参数是 builder. 当 ChangeNotifier 发生变化时会调用 builder 这个函数。也就是，当你在
            *    模型中调用 notifyListeners() 时，所有和 Consumer 相关的 builder 方法都会调用。
            * 3. build 的三个参数：
            *    3.1. context
            *    3.2. ChangeNotifier的实例
            *    3.3. child: 用于优化目的， 如果 Consumer 下面有子树， 当模型发生改变时，该子树并不会改变，那么你就可以仅仅创建他一次，
            *                然后通过 builder 获取该实例
            * 4. 最好把 Comsumer 放在 widget 树尽量低的位置上
            * */
            Consumer<CartModel>(
              builder: (context, cart, child) => Text('\$(cart.totalPrice)', style: hugeStyle),
            ),
            SizedBox(width: 24),
            FlatButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Buying not supported yet.')),
                );
              },
              color: Colors.white,
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}

