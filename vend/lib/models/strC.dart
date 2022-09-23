import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'dart:math';

import 'postComment.dart';
import 'storyItem.dart';

class storyCItem extends StatefulWidget {
  final stItem w_item;
  List<stItem> wishes = [];
  storyCItem({required this.wishes, required this.w_item});

  @override
  State<storyCItem> createState() => _postCState();
}

class _postCState extends State<storyCItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text('${widget.w_item.user_id}'),
        subtitle: Text('${widget.w_item.desc}'),
      ),
    );
  }
}
