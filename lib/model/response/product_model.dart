class ProductModel {
  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String>? images;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.images});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 1;
    title = json['title'] ?? '';
    price = json['price'] ?? 0;
    description = json['description'] ?? '';
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    images = json['images'].cast<String>();
  }
}

class Category {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
  }
}
