import 'package:flutter/material.dart';
import '../models/shopping_item.dart';

class ShoppingItemsHolder extends StatelessWidget {
  final List<ShoppingItem> itemsList;
  final List<ShoppingItem> newShoppingItems;
  final double appFullHeight;
  final double appFullWidth;
  const ShoppingItemsHolder({
    Key? key,
    required this.itemsList,
    required this.appFullHeight,
    required this.appFullWidth,
    required this.newShoppingItems,
  }) : super(key: key);

  Widget _renderShoppingItem(int index, ShoppingItem shoppingItem) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: FittedBox(
            child: Text(
              (index + 1).toString(),
            ),
          ),
        ),
        title: Text(
          shoppingItem.item,
        ),
        subtitle: Text(
          'Amount to get: ${shoppingItem.amount.toString()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _showFetchedItems(int index) {
    return _renderShoppingItem(index, itemsList[index]);
  }

  Widget _drawDivider(int index) {
    return Column(
      children: [
        Divider(
          thickness: 10,
          color: Colors.black,
        ),
        _renderShoppingItem(index, newShoppingItems[index]),
      ],
    );
  }

  Widget _showNewAddedItems(int index) {
    return index == 0
        ? _drawDivider(index)
        : _renderShoppingItem(index, newShoppingItems[index]);
  }

  Widget _showAllItems(int index) {
    int fetchedListLength = itemsList.length;
    int addedListLength = newShoppingItems.length;
    if (index <= fetchedListLength - 1) {
      return _showFetchedItems(index);
    } else {
      return _showNewAddedItems(index - fetchedListLength);
    }
  }

  Widget _dialogBuilder(BuildContext context, ShoppingItem shoppingItem) {
    return SimpleDialog(
      children: [
        Container(
          width: appFullWidth,
          height: appFullHeight * 0.3,
          child: Text(shoppingItem.description),
        )
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) {
            if (index < itemsList.length) {
              return _dialogBuilder(context, itemsList[index]);
            } else {
              return _dialogBuilder(
                  context, newShoppingItems[index - itemsList.length]);
            }
          }),
      child: _showAllItems(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return itemsList.isEmpty
        ? Container(
            decoration: const BoxDecoration(color: Colors.purple),
            child: const Center(
              child: Text('Nothing to show'),
            ))
        : ListView.builder(
            itemBuilder: _listItemBuilder,
            itemCount: itemsList.length + newShoppingItems.length,
          );
  }
}
