import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';
import '../providers/products_provider.dart';
import '../screens/home/products_overview_screen.dart';

class ProductsGridView extends StatelessWidget {
  final bool showFav;

  ProductsGridView(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favItems : productsData.items;
    return GridView.custom(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(3, 2),
          QuiltedGridTile(2, 2),
          QuiltedGridTile(2, 2),
          QuiltedGridTile(2, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, i) => ChangeNotifierProvider.value(
          value: products[i],
          child: ProductItem(),
        ),
        childCount: products.length,
      ),
    );
  }
}
