import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vend/models/catgItem.dart';
import 'package:http/http.dart' as http;
import 'package:vend/models/http_exception.dart';

class categ with ChangeNotifier {
  final token;
  categ(this.token, this.item);
  List<caItem> item = [];
  List<caItem> get items {
    return [...item];
  }

  final n = caItem(id: 0, name: '', user_id: 0);

  int get itemcount {
    return item.length;
  }

  caItem findById(String id) {
    return item.firstWhere((prod) => prod.id.toString() == id,
        orElse: () => n as caItem);
  }

  Future<void> addCategory(caItem cate) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Map<String, dynamic> pro = {};
    pro['name'] = cate.name;
    Uri url = Uri.parse("http://10.0.2.2:8000/api/category");
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

      var Data = jsonDecode(response.body);

      final newCateg = caItem(
        id: cate.id,
        name: cate.name,
        user_id: cate.user_id,
      );
      item.add(newCateg);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, caItem cate) async {
    final prodIndex = item.indexWhere((prod) => prod.id.toString() == id);
    Map<String, dynamic> pro = {};
    var existingProduct = findById(id);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    pro['id'] = existingProduct.id.toString();
    pro['user_id'] = existingProduct.user_id.toString();

    pro['name'] = cate.name;

    Uri url = Uri.parse("http://10.0.2.2:8000/api/category/$id");
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
      print(response.body);
      item[prodIndex] = existingProduct;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAll() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/category");
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
      var Data = jsonDecode(resp.body);
      print(Data);
      // var id = Data['data']['id'];
      final extractedData = Data['data'];
      print(extractedData);
      //print(Data);
      if (extractedData == null) {
        return;
      }
      final List<caItem> loadedproducts = [];
      print(extractedData);
      extractedData.forEach((prodData) {
        loadedproducts.add(caItem(
          id: prodData['id'],
          name: prodData['name'],
          user_id: prodData['user_id'],
        ));
      });
      item = loadedproducts;
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/category/$id");
    // final existingProductIndex = item.indexWhere((prod) => prod.id == id);
    // item[existingProductIndex];
    var existingProduct = findById(id);
    final existingProductIndex = existingProduct.id - 1;

    print(existingProduct);
    item.removeAt(existingProductIndex.toInt() - 1);
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
        item.insert(existingProductIndex.toInt() - 1, existingProduct);
        notifyListeners();
        throw HttpException('could not delete');
      }

      existingProduct = null as caItem;
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }
}
