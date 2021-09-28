class ShoppingItem {
  final String id;
  final String item;
  final String date;
  final num amount;

  final String description;

  ShoppingItem({
    required this.id,
    required this.item,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['_id'],
      item: json['item'],
      amount: json['amount'],
      date: json['date'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "item": item,
      "date": date,
      "amount": amount,
      "description": description,
    };
  }
}
