import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/models/catgItem.dart';
import 'package:vend/providers/cate.dart';
import 'package:vend/screens/Categories/addcategory.dart';
import '../models/postItem.dart';
import '../providers/postsProvider.dart';
import '../screens/postComments.dart';

class cateItemS extends StatefulWidget with ChangeNotifier {
  final caItem p_item;
  List<caItem> posts = [];
  cateItemS({required this.posts, required this.p_item});

  @override
  State<cateItemS> createState() => _cateItemSState();
}

class _cateItemSState extends State<cateItemS> {
  @override
  // void didChangeDependencies() {
  //   final postId = ModalRoute.of(context)!.settings.arguments as String?;

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<categ>(context);

    return GestureDetector(
      onTap: () {
        //fetchspec
        // Navigator.of(context)
        //     .pushNamed(P_ComScreen.routeName, arguments: widget.p_item.user_id);
      },
      child: SizedBox(
        height: 100,
        width: 100,
        child: Container(
          child: ListTile(
            title: Text(widget.p_item.name),
            trailing: Container(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          addcateg.routeName,
                          arguments: widget.p_item.id);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Data.deleteProduct(widget.p_item.id.toString());
                    },
                    color: Theme.of(context).errorColor,
                  ),
                ],
              ),
            ),
          ),
          // color: Colors.black26,
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       child: Row(
          //         children: [
          //           Text(
          //             'category id: ${widget.p_item.id}',
          //             style: TextStyle(fontSize: 14),
          //           ),
          //           Spacer(),
          //           IconButton(
          //             icon: Icon(Icons.edit),
          //             onPressed: () {
          //               Navigator.of(context).pushNamed(addcateg.routeName,
          //                   arguments: widget.p_item.id);
          //             },
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           //    Text('${widget.p_item.datetime.toString()}'),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       //   color: Colors.black26,
          //       child: Card(
          //         margin: EdgeInsets.all(10),
          //         // shadowColor: Colors.black,
          //         //     color: Colors.black12,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'category name: ${widget.p_item.name}',
          //               style: TextStyle(
          //                 // backgroundColor: Colors.black26,
          //                 fontFamily: 'Lato-bold',
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
