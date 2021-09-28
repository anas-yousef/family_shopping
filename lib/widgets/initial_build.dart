import 'package:flutter/material.dart';
import '../models/shopping_item.dart';
import '../widgets/shopping_items.dart';

class InitialBuild extends StatelessWidget {
  final double appFullHeight;
  final double appFullWidth;
  final List<ShoppingItem> newShoppingItems;
  final Future<List<ShoppingItem>> futureShoppingItems;
  const InitialBuild({
    Key? key,
    required this.appFullHeight,
    required this.appFullWidth,
    required this.newShoppingItems,
    required this.futureShoppingItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ShoppingItem>>(
      future: futureShoppingItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ShoppingItemsHolder(
            newShoppingItems: newShoppingItems,
            itemsList: snapshot.data!,
            appFullHeight: appFullHeight,
            appFullWidth: appFullWidth,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
