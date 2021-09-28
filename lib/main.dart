import './providers/backend_functions.dart';

import 'package:flutter/material.dart';

import './widgets/new_shopping_item.dart';
import './models/shopping_item.dart';
import './widgets/initial_build.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Shopping Items'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<ShoppingItem>> futureShoppingItems;
  List<ShoppingItem> newShoppingItems = [];
  @override
  void initState() {
    super.initState();
    futureShoppingItems = fetchShoppingItems();
  }

  void _showSheet(BuildContext context, double fullHeight) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewShoppingItem(
          appFullHeight: fullHeight,
          addItemHandler: _addNewItem,
        );
      },
    );
  }

  void _addNewItem(String id, String item, double amount, String pickedDate) {
    final newShoppingItem = ShoppingItem(
      id: id,
      item: item,
      amount: amount,
      date: pickedDate,
      description: "Not yet",
    );

    setState(() {
      newShoppingItems.add(newShoppingItem);
    });
  }

  void _refreshItems() {
    if (newShoppingItems.isEmpty) {
      final fetchedItems = fetchShoppingItems();
      fetchedItems.then((value) {
        print('Refreshed');
        setState(() {
          futureShoppingItems = fetchedItems;
        });
      }).catchError((error) {
        throw Exception('Failed to create shopping item.');
      });

      return;
    }
    final createResponse = addShoppingItems(newShoppingItems);
    createResponse.then((shoppingItem) {
      print('Done Done');
      setState(() {
        futureShoppingItems = fetchShoppingItems();
        newShoppingItems.clear();
      });
    }).catchError((error) {
      throw Exception('Failed to create shopping item.');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final _appBar = AppBar(
      title: Text(widget.title),
    );

    double appFullHeight = (MediaQuery.of(context).size.height -
            _appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
        1;
    double appFullWidth = (MediaQuery.of(context).size.width) * 1;
    return Scaffold(
      appBar: _appBar,
      body: InitialBuild(
        appFullHeight: appFullHeight,
        appFullWidth: appFullWidth,
        newShoppingItems: newShoppingItems,
        futureShoppingItems: futureShoppingItems,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(
              Icons.refresh,
            ),
            onPressed: () => _refreshItems(),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            child: const Icon(
              Icons.add,
            ),
            onPressed: () => _showSheet(context, appFullHeight),
          ),
        ],
      ),
    );
  }
}
