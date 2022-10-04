import 'package:flutter/material.dart';
import 'package:market/screens/cart_screen.dart';
import 'package:provider/provider.dart';

// import '../models/product.dart';
// import '../widgets/product_item.dart';
import '../widgets/product_grid.dart';
import '../providers/products.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'cart_screen.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  // const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  //переменная для отображения избранных
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Market'),
        //добавляем всплывающее меню в аппбар
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              //чтобы блок перестраивался добавляем setState
              setState(() {
                // добавляем функцию сортировк
                if (selectedValue == FilterOptions.favorite) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Показать избранное'),
                value: FilterOptions.favorite,
              ),
              PopupMenuItem(
                child: Text('Показать все'),
                value: FilterOptions.all,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch!, //виджет не может быть null поэтому !
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      //создаем генератор сетки
      body: ProductGrid(showFavs: _showOnlyFavorites),
    );
  }
}
