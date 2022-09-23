import 'package:flutter/cupertino.dart';

class postItem with ChangeNotifier {
  num user_id;
  final String title;
  final String content;
  final num post_id;
  final String datetime;
  postItem(
      {required this.post_id,
      required this.user_id,
      required this.content,
      required this.title,
      required this.datetime});
}
