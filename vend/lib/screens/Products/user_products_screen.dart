import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/widgets/app_drawer.dart';
import '../../providers/product.dart';
import '../../providers/products_provider.dart';

import '../../widgets/user_product_item.dart';
//import '../widgets/app_drawer.dart';
import '../editting screen/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _Refresh(BuildContext context) async {
    await Provider.of<Products>(context).fetchproducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      //drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _Refresh(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  prod: productsData.item[i],
                  prods: productsData.items,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),
    );
  }
}
