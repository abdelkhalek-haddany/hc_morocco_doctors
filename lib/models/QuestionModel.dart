class QuestionModel{
  final String  id,title, content,thumbnail, department_id,status, user_id;
  QuestionModel({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.department_id,
    required this.user_id,
    required this.status,
    required this.content,
  });
  factory QuestionModel.fromJson(Map <String, dynamic> map){
    return QuestionModel(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      status: map['status'] as String,
      department_id: map['department_id'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.user_id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['content'] = this.content;
    data['department_id'] = this.department_id;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}