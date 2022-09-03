import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  //получаем список модели продукта в приватную переменную
  //чтоб нельзя было изменить и получить к  ней доступ
  //чтоб его нельзя было редактировать саму модель(класс)
  //чтоб можно было уведомлять слушателей при изменении в классе
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'http://shop.neru14.ru/images/red-shirt.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'http://shop.neru14.ru/images/trousers.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'http://shop.neru14.ru/images/yellow-scarf.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'http://shop.neru14.ru/images/pan.png',
    ),
  ];

/*=== все что под коментами херня, проще statefull widget сделать */
  // var _showFavoritesOnly = false;

//а теперерь передаем в публичный список с которым можем работать
  List<Product> get items {
    //делаем проверку по отметке избранное и создаем другой список
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

/*===== какаято херня творится пока не догоняю */
//сортировка избранного
  List<Product> get favoritesItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

//методы для отображения или избранного или всех
  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

//метод поиска продукта по ID
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //пример изменения модели(класса)
  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
