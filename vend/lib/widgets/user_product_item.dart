import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';
import '../screens/editting screen/edit_product_screen.dart';

class UserProductItem extends StatefulWidget {
  final Product prod;
  List<Product> prods = [];
  UserProductItem({required this.prod, required this.prods});

  @override
  State<UserProductItem> createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final Pro = Provider.of<Products>(context, listen: false);
    return ListTile(
      title: Text(widget.prod.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.prod.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: widget.prod.id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Pro.deleteProduct(widget.prod.id.toString());
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
