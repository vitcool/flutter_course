import 'package:flutter/material.dart';

import './products.dart';

class ProductManager extends StatefulWidget {
  final String startingProducts;

  ProductManager(this.startingProducts) {
    print('[ProductManager Widget] Constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[ProductManager Widget] createState');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
    print('[_ProductManager State] initState');
    super.initState();
    _products.add(widget.startingProducts);
  }

  @override
  Widget build(BuildContext context) {
    print('[_ProductManager State] build');
    return Column(children: [
      Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
              onPressed: () {
                setState(() {
                  _products.add('Advanced Food Tester');
                });
              },
              child: Text('Add product'))),
      Products(_products)
    ]);
  }
}
