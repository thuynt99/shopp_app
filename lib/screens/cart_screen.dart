import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routerName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total', style: TextStyle(fontSize: 20)),
                        Spacer(),
                        Chip(
                            label: Text(
                                '\$${cart.totalAmount.toStringAsFixed(2)}')),
                        FlatButton(
                            onPressed: () {
                              Provider.of<Orders>(context, listen: false)
                                  .addOrder(
                                cart.items.values.toList(),
                                cart.totalAmount,
                              );
                              cart.clear();
                              Navigator.of(context)
                                  .pushNamed(OrdersScreen.routeName);
                            },
                            child: Text(
                              'ORDER NOW',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ))
                      ])),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].title,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].price),
              ),
            )
          ],
        ));
  }
}
