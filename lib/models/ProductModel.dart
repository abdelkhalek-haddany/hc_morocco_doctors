class ProductModel{
  final Object id;
  final String  title, images, details;
  ProductModel({
    required this.id,
    required this.title,
    required this.details,
    required this.images,

  });
  factory ProductModel.fromJson(Map <String, dynamic> map){
    return ProductModel(
      id: map['id'] as int,
      title: map['title'] as String,
      details: map['details'] as String,
      images: map['images'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['images'] = this.images;
    return data;
  }
}