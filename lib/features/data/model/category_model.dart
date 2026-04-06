class Category {
  final int? id;
  final String name;
  final String image;
  final int is_veg;

  Category({this.id, required this.name,required this.image,required this.is_veg});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image': image,
    'is_veg': is_veg,
  };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
    id: map['id'],
    name: map['name'],
    image: map['image'],
    is_veg: map['is_veg'],
  );
}