import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

//метод для смены статуса избранного для кнопки избранного в сетке построения продуктов
  void toggleFavoriteStatus() {
    // меняем статус избранного
    isFavorite = !isFavorite;

    //отправляем слушателям статус
    notifyListeners();
  }
}
