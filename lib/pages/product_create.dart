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
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': null,
    'image': 'assets/food.jpeg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildTitleTextField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Product title'),
        validator: (String value) {
          if (value.isEmpty || value.length < 5) {
            return ('Title is required and should be 5+ chars long.');
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        });
  }

  Widget _buildProductDescription() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product description'),
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return ('Description is required and should be 10+ chars long.');
        }
      },
      maxLines: 4,
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\[.,]\d+)?$').hasMatch(value)) {
          return ('Price is required and should be a number.');
        }
      },
      onSaved: (String value) {
        _formData['value'] =
            double.parse(value.replaceFirst(RegExp(r','), '.'));
      },
      keyboardType: TextInputType.number,
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> product = _formData;
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            width: targetWidth,
            margin: EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  children: <Widget>[
                    _buildTitleTextField(),
                    _buildProductDescription(),
                    _buildPriceTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Save'),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      onPressed: _submitForm,
                    )
                  ],
                ))));
  }
}
