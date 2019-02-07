import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/products.dart';

class ProductEditPage extends StatefulWidget {
  ProductEditPage();

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': null,
    'image': 'assets/food.jpeg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildTitleTextField(Product product) {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Product title'),
        initialValue: !(product == null) ? product.title : '',
        validator: (String value) {
          if (value.isEmpty || value.length < 5) {
            return ('Title is required and should be 5+ chars long.');
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        });
  }

  Widget _buildProductDescription(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product description'),
      initialValue: !(product == null) ? product.description : '',
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

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      initialValue: !(product == null) ? product.price.toString() : '',
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return ('Price is required and should be a number.');
        }
      },
      onSaved: (String value) {
        _formData['price'] =
            double.parse(value.replaceFirst(RegExp(r','), '.'));
      },
      keyboardType: TextInputType.number,
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, [int selectedProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final Product product = new Product(
        title: _formData['title'],
        description: _formData['description'],
        image: _formData['image'],
        price: _formData['price']);
    if (selectedProductIndex == null) {
      addProduct(product);
    } else {
      updateProduct(product);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildSubmitButton([int selectedProductIndex]) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return RaisedButton(
        child: Text('Save'),
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        onPressed: () =>
            _submitForm(model.addProduct, model.updateProduct, model.selectedProductIndex),
      );
    });
  }

  Widget _buildWidgetContent(BuildContext context, Product product, [int selectedProductIndex]) {
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
                    _buildTitleTextField(product),
                    _buildProductDescription(product),
                    _buildPriceTextField(product),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSubmitButton(selectedProductIndex)
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      final Widget pageContent =
          _buildWidgetContent(context, model.selectedProduct);
      return model.selectedProductIndex == null
          ? pageContent
          : Scaffold(
              appBar: AppBar(title: Text('Edit Product')), body: pageContent);
    });
  }
}
