import '../models/UserModel.dart';
import 'connection.dart';

class Users {
  static insert(UserModel user) async {
    try {
      var result = await userCollection.insertOne(user.toJson());
      if (result.status == 200) {
        return "the data inserted successfully";
      } else {
        return "Error data don't inserted";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final users = await userCollection.find().toList();
      print(users);
      return users;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static update(UserModel user) async {
    try {
      var u = await userCollection.findOne({"_id": user.id});
      u["name"] = user.firstname;
      u["age"] = user.lastname;
      u["phone"] = user.phone;
      await userCollection.save(u);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static delete(UserModel user) async {
    try {
      await userCollection.remove(user.id);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}