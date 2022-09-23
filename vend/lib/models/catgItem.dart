import 'package:flutter/cupertino.dart';

class caItem with ChangeNotifier {
  final num user_id;
  final String name;
  final num id;

  caItem({required this.user_id, required this.name, required this.id});
}
