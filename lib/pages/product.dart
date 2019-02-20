import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../widgets/ui_elements/title_default.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  Widget _buildAddressePriceRow(double price) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Union Square, San Francisco',
          style: TextStyle(color: Colors.grey, fontFamily: 'Oswald')),
      Container(
          child: Text('|'), margin: EdgeInsets.symmetric(horizontal: 5.0)),
      Text(
        '\$${price.toString()}',
        style: TextStyle(color: Colors.grey, fontFamily: 'Oswald'),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Center(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FadeInImage(
                          image: NetworkImage(product.image),
                          height: 300.0,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/background.jpg'),
                        ),
                        TitleDefault(product.title),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: _buildAddressePriceRow(product.price),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: Text(product.description,
                              textAlign: TextAlign.center),
                        )
                      ]))
            ])))));
  }
}
