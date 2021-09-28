import 'package:flutter/material.dart';

class NewShoppingItem extends StatefulWidget {
  final double appFullHeight;
  final Function addItemHandler;
  const NewShoppingItem({
    Key? key,
    required this.appFullHeight,
    required this.addItemHandler,
  }) : super(key: key);

  @override
  _NewShoppingItemState createState() => _NewShoppingItemState();
}

class _NewShoppingItemState extends State<NewShoppingItem> {
  final _itemController = TextEditingController();
  final _amountController = TextEditingController();
  String text = "";

  void _submitData() {
    final double enteredAmount;
    final String enteredItem = _itemController.text;
    if (_amountController.text.isEmpty) {
      enteredAmount = 1;
    } else {
      enteredAmount = double.parse(_amountController.text);
    }
    if (enteredItem.isEmpty || enteredAmount < 0) {
      return;
    }

    widget.addItemHandler(
      '1',
      enteredItem,
      enteredAmount,
      DateTime.now().toString(),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              //textAlign: TextAlign.start,
              //textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                labelText: 'Shopping Item',
              ),
              controller: _itemController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                'Add Item',
              ),
            )
          ],
        ),
      ),
    );
  }
}
