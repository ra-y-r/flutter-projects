import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product.dart';

import '../../providers/products_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // SizedBox(height: 50),
            // Text(
            //   '\$${loadedProduct.price}',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   width: double.infinity,
            //   child: Text(
            //     loadedProduct.description,
            //     textAlign: TextAlign.center,
            //     softWrap: true,
            //   ),
            // ),
            // Divider(
            //   color: Colors.black26,
            //   height: 50,
            //   thickness: 6,
            //   endIndent: 20,
            //   indent: 20,
            // ),
            // Container(
            //comments
            // )

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${loadedProduct.description}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Name :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.title}',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Text('Category :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.cat_id}',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Price :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.price}',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Product expiration date :',
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.exp_date} ',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Text('Quantity :', style: TextStyle(fontSize: 16)),
                      ),
                      Text('${loadedProduct.quantity} ',
                          style: TextStyle(fontSize: 14)),
                      Spacer(),
                      Text('${loadedProduct.views.toString()} ',
                          style: TextStyle(fontSize: 14)),
                      Icon(Icons.remove_red_eye)
                    ],
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
