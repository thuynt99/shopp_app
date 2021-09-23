import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .featchAndSetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your product'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _refreshProducts(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshProducts(context),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                              itemCount: productList.items.length,
                              itemBuilder: (_, i) => UserProductItem(
                                  productList.items[i].id,
                                  productList.items[i].title,
                                  productList.items[i].imageUrl)),
                        ),
                      )));
  }
}
