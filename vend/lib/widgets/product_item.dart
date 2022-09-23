import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
//import '../providers/wishlistProvider.dart';

//import '../providers/cart_provider..dart';
import '../providers/product.dart';

import '../screens/Products/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    // final cart = Provider.of<Cart>(
    //   context,
    //   listen: false,
    // );
    // final wishes = Provider.of<Wishlist>(
    //   context,
    //   listen: false,
    // );
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              product.is_favourite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Color(0XFFF37475A),
            onPressed: () {
              //   product.toggleFavoriteStatus(authData.logtoken);
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Caveat-Bold', color: Colors.black),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              // cart.addItems(
              //   product.id,
              //   product.imageUrl,
              //   product.price,
              //   product.title,
              // );

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        //cart.removeSingleItem(product.id);
                      }),
                  duration: Duration(seconds: 3),
                  content: Text(
                    'ITEM ADEDDED TO CART',
                    style: TextStyle(fontFamily: 'Caveat'),
                  )));
            },
            color: Color(0XFFF37475A),
          ),
        ),
      ),
    );
  }
}
