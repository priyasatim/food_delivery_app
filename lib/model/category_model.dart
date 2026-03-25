class Category {
  final int? id;
  final String name;
  final String image;

  Category({this.id, required this.name,required this.image});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image': image,
  };

  factory Category.fromJson(Map<String, dynamic> map) => Category(
    id: map['id'],
    name: map['name'],
    image: map['image'],
  );
}