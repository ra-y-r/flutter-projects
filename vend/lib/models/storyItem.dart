import 'package:flutter/cupertino.dart';

class stItem with ChangeNotifier {
  num user_id;
  final String desc;
  final String quantity;
  final String img;
  final num story_id;
  final String price;
  stItem(
      {required this.story_id,
      required this.user_id,
      required this.desc,
      required this.img,
      required this.quantity,
      required this.price});
}
