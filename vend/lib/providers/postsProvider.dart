import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/postItem.dart';

class Posts with ChangeNotifier {
  final token;

  Posts(this.token, this.item);
  final n =
      postItem(post_id: 0, user_id: 0, content: '', title: '', datetime: '');

  List<postItem> item = [];
  List<postItem> get items {
    return [...item];
  }

  int get itemcount {
    return item.length;
  }

  postItem findById(String id) {
    return item.firstWhere((prod) => prod.post_id.toString() == id,
        orElse: () => n as postItem);
  }

  Future<void> addPost(postItem post) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Map<String, dynamic> pro = {};
    pro["title"] = post.title;
    pro["content"] = post.content;
    final timestamp = DateTime.now();
    Uri url = Uri.parse("http://10.0.2.2:8000/api/post");

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
      print(pro);
      print(response.body);
      final newPost = postItem(
          post_id: post.post_id,
          user_id: post.user_id,
          content: post.content,
          title: post.title,
          datetime: timestamp.toString());
      item.add(newPost);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAllPost() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/post");
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
      final List<postItem> loadedposts = [];
      print(extractedData);
      extractedData.forEach((prodData) {
        loadedposts.add(postItem(
            post_id: prodData['id'],
            user_id: prodData['user_id'],
            content: prodData['content'],
            datetime: prodData['created_at'],
            title: prodData['title']));
      });
      item = loadedposts;
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }

  Future<void> fetchPost(postItem post) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('adminlogToken');
    Uri url = Uri.parse("http://10.0.2.2:8000/api/post/${post.post_id}");
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
      final extractedData = Data['data'];
      if (extractedData == null) {
        return;
      }
      final DisPost = postItem(
          post_id: extractedData.post_id,
          user_id: extractedData.user_id,
          content: extractedData.content,
          title: extractedData.title,
          datetime: extractedData.datetime);
      // item.insert(0, DisPost);

      print(DisPost);
      notifyListeners();
    } catch (error) {
      print(error);
      //   throw error;
    }
  }
}
