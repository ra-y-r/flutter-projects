// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import '../providers/auth.dart';
//import '../screens/createAccount.dart';
import '../widgets/product_item.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Products with ChangeNotifier {
  final token;
  Products(this.token, this.item);

  List<Product> item = [
    // Product(
    //   id: 'p1',
    //   title: 'ground beef',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   quantity: 4,
    //   imageUrl: 'https://m.media-amazon.com/images/I/91ZXNnbC6vL._SX385_.jpg',
    //   cat_id: '3',
    //   exp_date: '2022',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Cento Tomatoes',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   quantity: 4,
    //   imageUrl: 'https://m.media-amazon.com/images/I/812Q3qIMDOL._SL1500_.jpg',
    //   cat_id: '3',
    //   exp_date: '2022',
    // ),
    // Product(
    //   cat_id: '3',
    //   exp_date: '2022',
    //   id: 'p3',
    //   title: 'SPAM Classic',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   quantity: 4,
    //   imageUrl:
    //       'https://cdn0.woolworths.media/content/wowproductimages/large/033964.jpg',
    // ),
    // Product(
    //   cat_id: '3',
    //   exp_date: '2022',
    //   id: 'p4',
    //   title: 'Del Monte',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   quantity: 8,
    //   imageUrl:
    //       'https://www.delmonte.com/sites/default/files/products//2017-09/slicedpeaches-regular.png',
    // ),
    // Product(
    //   cat_id: '3',
    //   exp_date: '2022',
    //   id: 'p5',
    //   title: 'Coconut Milk',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   quantity: 5,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   cat_id: '3',
    //   exp_date: '2022',
    //   id: 'p6',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   quantity: 2,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [...item];
  }

  List<Product> get favItems {
    return item.where((ProductItem) => ProductItem.is_favourite).toList();
  }

  Product findById(String id) {
    return item.firstWhere((prod) => prod.id.toString() == id,
        orElse: () => null as Product);
  }

  Future<void> fetchproducts() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product");
    try {
      final resp = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Connection': 'keep-alive',
        },
      );
      print(resp.body);
      var Data = jsonDecode(resp.body);
      print(Data);
      // var id = Data['data']['id'];
      final extractedData = Data['data'];
      print(extractedData);
      //print(Data);
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedproducts = [];
      print(extractedData);
      extractedData.forEach((prodData) {
        loadedproducts.add(Product(
            user_id: prodData['user_id'],
            views: prodData['views'],
            exp_date: prodData['exp_date'],
            cat_id: prodData['category_id'].toString(),
            id: prodData["id"],
            imageUrl: prodData['img_url'],
            price: prodData['price'],
            quantity: prodData['quantity'],
            title: prodData['name'],
            description: prodData['description']));
      });
      item = loadedproducts;
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Map<String, dynamic> pro = {};
    pro['name'] = product.title;
    pro['description'] = product.description;
    pro['img_url'] = product.imageUrl;
    pro['price'] = product.price.toString();
    pro['user_id'] = product.user_id.toString();
    pro['quantity'] = product.quantity.toString();
    pro['category_id'] = product.cat_id;
    pro["exp_date"] = product.exp_date;
    pro['user_id'] = product.user_id;
    //  Uri url =;
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product");
    try {
      final response = await http.post(
        url,
        body: pro,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Connection': 'keep-alive',
        },
      );
      print(response.body);
      final newProduct = Product(
        user_id: product.user_id,
        views: product.views,
        cat_id: product.cat_id,
        exp_date: product.exp_date,
        quantity: product.quantity,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: product.id,
      );
      item.add(newProduct);
      item.insert(0, newProduct); // at the start of the list

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // void addProduct(Product product) {
  //   final newProduct = Product(
  //     is_favourite: product.is_favourite,
  //     quantity: product.quantity,
  //     title: product.title,
  //     type: product.type,
  //     price: product.price,
  //     imageUrl: product.imageUrl,
  //     id: DateTime.now().toString(),
  //   );
  //   _items.add(newProduct);
  //   //_items.insert(0, newProduct); // at the start of the list
  //   notifyListeners();
  // }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = item.indexWhere((prod) => prod.id == newProduct.id);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Map<String, dynamic> pro = {};
    pro['name'] = newProduct.title;
    pro['description'] = newProduct.description;
    pro['img_url'] = newProduct.imageUrl;
    pro['price'] = newProduct.price.toString();

    pro['quantity'] = newProduct.quantity.toString();
    pro['category_id'] = newProduct.cat_id;
    pro["exp_date"] = newProduct.exp_date;

    if (prodIndex >= 0) {
      Uri url = Uri.parse("http://10.0.2.2:8000/api/product/$id");
      //patch/put?
      // await http.patch(url,
      //     body: jsonEncode({
      //       'title': newProduct.title,
      //       'description': newProduct.description,
      //       'imageUrl': newProduct.imageUrl,
      //       'price': newProduct.price,
      //       'quantity': newProduct.quantity,
      //     }));

      try {
        final response = await http.put(
          url,
          body: pro,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Charset': 'utf-8',
            'Connection': 'keep-alive',
          },
        );
        print(pro);
        print(response.body);
        item[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        print(error);
        throw error;
      }
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    print(id);
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product/$id");
    // final existingProductIndex = item.indexWhere((prod) => prod.id == id);
    // item[existingProductIndex];
    var existingProduct = findById(id);

    final existingProductIndex = existingProduct.id - 1;
    print(existingProduct);
    item.removeAt(existingProductIndex - 1);
    notifyListeners();
    try {
      final response = await http.delete(
        url,
        body: {},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Connection': 'keep-alive',
        },
      );

      print(response.body);

      if (response.statusCode >= 400) {
        item.insert(existingProductIndex - 1, existingProduct);
        notifyListeners();
        throw HttpException('could not delete');
      }

      existingProduct = null as Product;
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }

  // Future<void> getSingleAds(id) async {
  //   http.Response response = await http.get(
  //     Uri.parse('http://10.0.2.2:8000/api/product/$id'),
  //     headers: {
  //       'accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   try {
  //     var jsonRsponse = jsonDecode(response.body);
  //     print(id);

  //     print(response.body);
  //     //print(ModelAds1.id);
  //     ModelAds1.name = jsonRsponse['name'];
  //     ModelAds1.price = jsonRsponse['price'];
  //     ModelAds1.des = jsonRsponse['description'];
  //     ModelAds1.exp = jsonRsponse['exp_date'];
  //     ModelAds1.quan = jsonRsponse['quantity'];

  //     ModelAds1.photo1 = "http://192.168.1.105:80/" + jsonRsponse['img_url'];
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }
}
