class UserModel{
  final String  id, firstname, email, lastname, address, avatar,phone,user_type, password;
  final bool active;
  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.avatar,
    required this.phone,
    this.user_type = 'Member',
    this.active = true,
    required this.password


  });
  factory UserModel.fromJson(Map <String, dynamic> map){
    return UserModel(
      id: map['id'] as String,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      avatar: map['avatar']as String,
      phone: map['phone'] as String,
      user_type: map['user_type'] as String,
      active: map['active'] as bool,
      password: map['password'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user_type'] = this.user_type;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    data['password'] = this.password;
    return data;
  }
}