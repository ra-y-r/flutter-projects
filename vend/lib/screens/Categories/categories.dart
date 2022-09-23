import 'dart:math';
import 'addcategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/providers/cate.dart';
import 'package:vend/widgets/app_drawer.dart';
import 'package:vend/widgets/categ_item.dart';

class CateScreen extends StatefulWidget {
  static const routeName = '/category';

  @override
  State<CateScreen> createState() => _CateScreenState();
}

class _CateScreenState extends State<CateScreen> {
  Future<void> _Refresh(BuildContext context) async {
    await Provider.of<categ>(context, listen: false).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<categ>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        title: Text(
          'Yummy corner',
          style: TextStyle(
            fontFamily: 'Caveat-Medium',
            color: Color(0XFFFFF9900),
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(addcateg.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _Refresh(context),
        child: ListView.builder(
          //      shrinkWrap: true,
          itemBuilder: (context, i) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                  color: Colors.black38, width: 2, style: BorderStyle.solid),
            ),
            child: cateItemS(
              p_item: Data.item[i],
              posts: Data.items,
            ),
          ),
          itemCount: Data.itemcount,
          padding: EdgeInsets.all(10),

          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 1,
          //   childAspectRatio: 4 / 2,
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          // ),
        ),
      ),
      drawer: Drawer(child: AppDrawer()),
    );
  }
}
