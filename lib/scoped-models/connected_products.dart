import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  int _selProductIndex;
  List<Product> _products = [];
  User _authenticatedUser;
  bool _isLoading = true;

  Future<Null> addProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
          notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://www.friars.co.uk/images/lindt-gold-milk-chocolate-bar-p504-7263_image.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http
        .post('https://flutter-products-vitcool.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  Product get selectedProduct {
    return selectedProductIndex != null
        ? _products[selectedProductIndex]
        : null;
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  bool get showFavorites {
    return _showFavorites;
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
  }

  void fetchProducts() {
    _isLoading = true;
          notifyListeners();
    http
        .get('https://flutter-products-vitcool.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData != null) {
        productListData.forEach((String productId, dynamic productData) {
          final Product product = Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              image: productData['image'],
              price: productData['price'],
              userEmail: productData['userEmail'],
              userId: productData['userId']);
          fetchedProductList.add(product);
        });
        _products = fetchedProductList;
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectProduct(int productId) {
    _selProductIndex = productId;
    if (productId != null) {
      notifyListeners();
    }
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = _products[selectedProductIndex].isFavorite;
    final bool newFavoriteState = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        image: selectedProduct.image,
        price: selectedProduct.price,
        isFavorite: newFavoriteState,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[_selProductIndex] = updatedProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '123123', email: email, password: password);
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
