import '../models/shopping_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ShoppingItem>> fetchShoppingItems() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:4000/shopping_item/get'));
  if (response.statusCode == 200) {
    // Can run in a seperate isolate:
    // return compute(parseShoppingItems, response.body);
    return _parseShoppingItems(response.body);
  } else {
    throw Exception('Failed to connet');
  }
}

List<ShoppingItem> _parseShoppingItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ShoppingItem>((json) => ShoppingItem.fromJson(json))
      .toList();
}

Future<ShoppingItem> addShoppingItems(List<ShoppingItem> shoppingItems) async {
  String temp = jsonEncode(shoppingItems);
  final response = await http.post(
    Uri.parse('http://10.0.2.2:4000/shopping_item/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(shoppingItems),
  );

  if (response.statusCode == 200) {
    // return ShoppingItem.fromJson(jsonDecode(response.body));
    return shoppingItems[0];
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create shopping item.');
  }
}
