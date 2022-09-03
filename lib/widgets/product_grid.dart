import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //импортируем провайдера чтоб обратиться к модели и данным

import '../providers/products.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  const ProductGrid({Key? key, required this.showFavs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //получаем класс Products в котором есть все данные и модель
    final productsData = Provider.of<Products>(context);

    //получаем из класса Products список элементов данных Product
    //добавили проверку на избранное полученное из овервьюскрин
    //через products.dart фильтруем и создаем новый список
    final products =
        showFavs ? productsData.favoritesItems : productsData.items;

    return GridView.builder(
      //отступы
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //количество столбцов
        childAspectRatio: 3 / 2, //соотношение сторон
        crossAxisSpacing: 10, //отступы поперечное
        mainAxisSpacing: 10, //отступы основные
      ),

      //получаем данные из контекста из виджетов продуктитем
      itemBuilder:
          //это основной способ, но если мы будем только просматривать то лучше использовать
          //способ ниже просто принимая значение а не создавая его
          //   (ctx, i) => ChangeNotifierProvider(
          // create: (context) => products[i],

          //слушаем через провайдер значение а не создаем его
          (context, i) => ChangeNotifierProvider.value(
        key: Key("item$i"), //используем ключи обязательно а то будет ошибка
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      itemCount: products
          .length, //количество ячеек в сетке в зависимости от длины списка
    );
  }
}
