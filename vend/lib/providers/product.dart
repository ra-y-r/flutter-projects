import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class Product with ChangeNotifier {
  num views;
  var id;
  final String title;
  final String description;
  final num price;
  final num quantity;
  bool is_favourite;
  final String imageUrl;
  String exp_date;
  String cat_id;
  num user_id;

  Product({
    required this.user_id,
    required this.views,
    required this.cat_id,
    required this.exp_date,
    required this.id,
    required this.imageUrl,
    this.is_favourite = false,
    required this.price,
    required this.quantity,
    required this.title,
    required this.description,
  });

  void _setFavValue(bool newValue) {
    is_favourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String? token) async {
    final oldStatus = is_favourite;
    is_favourite = !is_favourite;
    notifyListeners();
    ////checktheurl////
    Uri url = Uri.parse("http://10.0.2.2:8000/api/product/$id");
    try {
      final response = await http.put(url,
          body: json.encode({
            'isFavorite': is_favourite,
          }),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Charset': 'utf-8',
            'Connection': 'keep-alive',
          });
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
