import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/postComment.dart';
import '../models/postItem.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Pcomment with ChangeNotifier {
  var token;
  Pcomment(this.token, this.comments);

  List<PostCom> comments = [];

  List<PostCom> get com {
    return [...comments];
  }

  int get itemcount {
    return comments.length;
  }

  Future<void> addComment(PostCom comment) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Map<String, dynamic> pro = {};

    pro['value'] = comment.value;

    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/post/${comment.post_id}/postcomment");

    try {
      final timestamp = DateTime.now();
      final response = await http.post(url, body: pro, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Connection': 'keep-alive',
      });
      var data = jsonDecode(response.body);
      print(data);
      comments.insert(
          0,
          PostCom(
              post_id: comment.post_id,
              user_id: comment.user_id,
              value: comment.value));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchallcomments(PostCom comment) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/post/${comment.post_id}/postcomment");
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
      final extractedData = Data['data'];
      if (extractedData == null) {
        return;
      }

      final List<PostCom> loadedcomments = [];
      extractedData.forEach((commData) {
        loadedcomments.add(PostCom(
          post_id: commData['post_id'],
          user_id: commData['user_id'],
          value: commData['value'],
        ));
      });
      comments = loadedcomments;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
