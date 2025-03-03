import 'package:flutter/foundation.dart';
import 'cartlog.dart';

// CartModel 成为监听器。 CartModel 实例的状态被 ChangeNotifier 监控。 类似于观察者模式
class CartModel extends ChangeNotifier {

  // The current catalog. Used to construct items from numeric ids.
  final CatalogModel _catalog;

  final List<int> _itemIds;

  CartModel(this._catalog, CartModel previous)
  : assert(_catalog != null),
  _itemIds = previous?._itemIds ?? [];

  /// List of items in the cart.
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  /// The current total price of all items.
  int get totalPrice => items.fold(0, (total, current) => total + current.price);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _itemIds.add(item.id);

    // This line tells [Model] that it should rebuild the widgets that depend on it.
    notifyListeners();
  }

}
