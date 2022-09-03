import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //получаем id продукта к которому обратились (нулевая безопасность сработала, ID не может быть нулевым)
    final productId = ModalRoute.of(context)?.settings.arguments as String;

    //через полученное ID с помощь. провайдера получаем всю информацию
    //по конкретному продукту и можем потом обращатся к списку с данными
    //метод findById сами определили в провайдер/продуктс и используем сдесь чтоб уменьшить код
    //listen: false стоит чтоб когда продукт сформирован больше не слушать изменения(меньше памяти)
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        //запрашиваем заголовок из полученного списка по конкретному ID
        title: Text(loadedProduct.title),
      ),
    );
  }
}
