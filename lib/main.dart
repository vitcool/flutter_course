import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/product.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/auth.dart';
import './scoped-models/products.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductsModel>(
        child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepOrange,
              accentColor: Colors.deepPurple,
              buttonColor: Colors.deepPurple),
          routes: {
            '/': (BuildContext context) => AuthPage(),
            '/products': (BuildContext context) => ProductsPage(),
            '/admin': (BuildContext context) => ProductAdminPage()
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElement = settings.name.split('/');
            if (pathElement[0] != '') {
              return null;
            }
            if (pathElement[1] == 'product') {
              final int index = int.parse(pathElement[2]);
              return MaterialPageRoute<bool>(
                  builder: (BuildContext context) =>
                      ProductPage(index));
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (BuildContext context) => ProductsPage());
          },
        ),
        model: ProductsModel());
  }
}
