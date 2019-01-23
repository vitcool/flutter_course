import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';
  String descriptionValue = '';
  double priceValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Product title'),
              onChanged: (String value) {
                setState(() {
                  titleValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Product description'),
              maxLines: 4,
              onChanged: (String value) {
                setState(() {
                  descriptionValue = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Product price'),
              onChanged: (String value) {
                setState(() {
                  priceValue = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                final Map<String, dynamic> product = {
                  'title': titleValue,
                  'description': descriptionValue,
                  'price': priceValue,
                  'image': 'assets/food.jpeg'
                };
                widget.addProduct(product);
                Navigator.pushReplacementNamed(context, '/');
              },
            )
          ],
        ));
  }
}
