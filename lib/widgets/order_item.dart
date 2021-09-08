import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _extends = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _extends = !_extends;
                  });
                },
                icon: Icon(
                    _extends ? Icons.expand_less_sharp : Icons.expand_more)),
          ),
          if (_extends)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView(
                  children: widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(prod.title,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text('${prod.quantity}x   \$${prod.price}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey))
                            ],
                          ))
                      .toList()),
            )
        ],
      ),
    );
  }
}
