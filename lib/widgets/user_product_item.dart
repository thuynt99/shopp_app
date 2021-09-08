import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            )),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ));
  }
}
