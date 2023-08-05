import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel{
  final String  id, firstname,city, email, lastname, address, avatar,phone, about,department, password, user_type;
  final bool active;
  DoctorModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.city,
    required this.avatar,
    required this.phone,
    required this.about,
    this.active = true,
    required this.department,
    required this.password,
    this.user_type = 'Member',


  });
  factory DoctorModel.fromJson(Map <String, dynamic> map){
    return DoctorModel(
      id: map['id'] as String,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      avatar: map['avatar']as String,
      phone: map['phone'] as String,
      city: map['city'] as String,
      about: map['about'] as String,
      active: map['active'] as bool,
      department: map['department'] as String,
      password: map['password'] as String,
      user_type: map['user_type'] as String,
    );
  }

  factory DoctorModel.fromSnapshot(DocumentSnapshot map){
    return DoctorModel(
      id: map['id'] as String,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      avatar: map['avatar']as String,
      phone: map['phone'] as String,
      city: map['city'] as String,
      about: map['about'] as String,
      active: map['active'] as bool,
      department: map['department'] as String,
      password: map['password'] as String,
      user_type: map['user_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['about'] = this.about;
    data['active'] = this.active;
    data['avatar'] = this.avatar;
    data['department'] = this.department;
    data['password'] = this.password;
    data['user_type'] = this.user_type;
    return data;
  }
}