//виджет для отображениия макета в сетке

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  //**== закоментировали потому как получаем все через провайдер */
  //получаем данные переданные в виджет из products_overviewscreen
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(this.id, this.title, this.imageUrl); //не обязательные именнованные

  @override
  Widget build(BuildContext context) {
    // получаем все через провайдер все данные по продукту
    //отключаем слушателя чтоб не забивать память
    //слушатель подключим на конкретный виджет избранное
    //обернув его в Consumer
    final product = Provider.of<Product>(
      context,
      listen: false,
    );

    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    //возвращаем макет ячейки для сетки
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        //оборачиваем картинку в кнопку
        footer: GridTileBar(
          backgroundColor: Colors.black54,

          //добавляем иконку избранное
          //оборачивваем в виджет слушателя
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              icon: Icon(
                  //проверяем значение избранного и делаем разные иконки
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                //переключаем статус избранный методом обращаясь к product.dart
                product.toggleFavoriteStatus();
              },
            ),
          ),

          //заголовок взязи из полученных даннных отцентрировали и ранее бек черный
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),

          //добавляем иконку-кнопку корзина
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            //передаем данные из товара в корзину
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
          ),
        ),
        //оборачиваем картинку в кнопку
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          //получаем картинку по урлу
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
