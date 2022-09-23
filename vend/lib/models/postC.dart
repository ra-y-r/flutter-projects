import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'dart:math';

import 'postComment.dart';

class postCItem extends StatefulWidget {
  final PostCom w_item;
  List<PostCom> wishes = [];
  postCItem({required this.wishes, required this.w_item});

  @override
  State<postCItem> createState() => _postCState();
}

class _postCState extends State<postCItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text('${widget.w_item.user_id}'),
        subtitle: Text('${widget.w_item.value}'),
      ),
    );
  }
}
