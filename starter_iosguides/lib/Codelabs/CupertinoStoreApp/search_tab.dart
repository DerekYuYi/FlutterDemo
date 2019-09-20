import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/product_row_item.dart';
import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/styles.dart';
import 'package:starter_iosguides/Codelabs/CupertinoStoreApp/search_bar.dart';

/// 搜索页面。是一个 stateful widget, 因为随着用户输入文本的变化，列表中的内容也会随之变化
class SearchTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {

  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  // 创建时调用一次
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // 拿到全局 AppStateModel 类实例
    final model = Provider.of<AppStateModel>(context);
    final results = model.search(_terms);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ProductRowItem(
                  index: index,
                  product: results[index],
                  lastItem: index == results.length - 1,
                ),
                itemCount: results.length,
              ),
            ),
          ],
        ),
      ),
    );

    // 通过嵌套 于CustomScrollView 中的 CupertinoSliverNavigationBar 来实现 iOS11 上的大标题
//    return CustomScrollView(
//      slivers: const <Widget>[
//        CupertinoSliverNavigationBar(
//          largeTitle: Text('Search'),
//        ),
//      ],
//    );
  }
}