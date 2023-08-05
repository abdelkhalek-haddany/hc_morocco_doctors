class DepartmentModel {

  final String id, title, description, thumbnail;

  DepartmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory DepartmentModel.fromJson(Map <String, dynamic> map){
    return DepartmentModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}