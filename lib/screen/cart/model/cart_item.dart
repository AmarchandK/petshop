class CartItemModel {
  final String image;
  final String name;
  final double price;
  int quantity;
  final int id;
     
  CartItemModel({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "name": name,
      "price": price,
      "quantity": quantity,
      "id": id,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      image: json['image'] ?? "",
      name: json['name'] ?? "",
      price: json['price'] ?? 0.0,
      quantity: json['quantity'] ?? 0,
      id: json['id'] ?? 0,
    );
  }
}
