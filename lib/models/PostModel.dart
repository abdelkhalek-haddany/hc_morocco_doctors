import 'package:hc_morocco_doctors/models/DepartmentModel.dart';
import 'package:hc_morocco_doctors/models/DoctorModel.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';

class PostModel {
  final String id, title, content, thumbnail, department, status, doctor_id;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.thumbnail,
    required this.department,
    required this.status,
    required this.doctor_id,
  });

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      department: map['department'] as String,
      thumbnail: map['thumbnail'] as String,
      status: map['status'] as String,
      doctor_id: map['doctor_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['department'] = this.department;
    data['status'] = this.status;
    data['doctor_id'] = this.doctor_id;
    return data;
  }

  Future<DoctorModel?> doctor() async {
    DoctorModel? doctor;
    try {
      doctor = await FireStoreUtils.getDoctorById(this.doctor_id) as DoctorModel?;
    } catch (e) {
      print("erroooooooooooooooooooooor");
    }
    return doctor;
  }
  Future<DepartmentModel?> get_department() async {
    DepartmentModel? __department;
    try {
      __department = await FireStoreUtils.getDepartmentById(this.department) as DepartmentModel?;
    } catch (e) {
      print("erroooooooooooooooooooooor");
    }
    return __department;
  }
}
