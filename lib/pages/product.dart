import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  ProductPage(this.title, this.description, this.price, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(imageUrl),
                        TitleDefault(title),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Union Square, San Francisco',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Oswald')),
                                Container(
                                    child: Text('|'),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0)),
                                Text(
                                  '\$${price.toString()}',
                                  style: TextStyle(
                                      color: Colors.grey, fontFamily: 'Oswald'),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: Text(description, textAlign: TextAlign.center),
                        )
                      ]))
            ])))));
  }
}
