import 'package:mongo_dart/mongo_dart.dart';

import '../models/DoctorModel.dart';
import '../models/UserModel.dart';
const String MONGO_CONN_URL ="mongodb+srv://morocco_hr:morocco_hr@cluster0.nk4o04n.mongodb.net/?retryWrites=true&w=majority";

 var userCollection;
 var doctorsCollection;
 var postsCollection;
 var questionCollection;
 var productsCollection;

class MongoDatabase{

  static var db;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection('users');
    doctorsCollection = db.collection('doctors');
    postsCollection = db.collection('posts');
    questionCollection = db.collection('questions');
    productsCollection = db.collection('products');

    print("Database connected successfully");
  }

  static insert(UserModel user) async {
    try {
      var result = await userCollection.insertOne(user.toJson());
      if (result.isSuccess) {
        return "the data inserted successfully";
      } else {
        return "Error data don't inserted";
      }
    }catch(e){
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
  
  static update(DoctorModel user) async {
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
  static delete(DoctorModel user) async {
    try{
    await userCollection.remove(user.id);
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }


  // return FutureBuilder(
  // future: MongoDatabase.getDocuments(),
  // builder: (context, snapshot) {
  // if (snapshot.connectionState == ConnectionState.waiting) {
  // // Show loading indicator
  // } else {
  // if (snapshot.hasError) {
  // // Return error
  // } else {
  // // Return Listview with documents data
  // }
  // }
  // )

  // insertUser() async {
  //   final user = User(
  //     id: M.ObjectId(),
  //     name: nameController.text,
  //     phone: int.parse(phoneController.text),
  //     age: int.parse(ageController.text),
  //   );
  //   await MongoDatabase.insert(user);
  //   Navigator.pop(context);
  // }
  //
  // updateUser(User user) async {
  //   print('updating: ${nameController.text}');
  //   final u = User(
  //     id: user.id,
  //     name: nameController.text,
  //     phone: int.parse(phoneController.text),
  //     age: int.parse(ageController.text),
  //   );
  //   await MongoDatabase.update(u);
  //   Navigator.pop(context);
  // }
}