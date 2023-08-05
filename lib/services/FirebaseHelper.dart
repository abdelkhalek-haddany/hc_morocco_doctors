import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:hc_morocco_doctors/constants.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:hc_morocco_doctors/models/CityModel.dart';
import 'package:hc_morocco_doctors/models/Conversation.dart';
import 'package:hc_morocco_doctors/models/DepartmentModel.dart';
import 'package:hc_morocco_doctors/models/DoctorModel.dart';
import 'package:hc_morocco_doctors/models/Message.dart';
import 'package:hc_morocco_doctors/models/PostModel.dart';
import 'package:hc_morocco_doctors/models/QuestionModel.dart';
import 'package:hc_morocco_doctors/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hc_morocco_doctors/models/UserModel.dart';

import 'helper.dart';

class FireStoreUtils {
  double radiusValue = 0.0;
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();

   Future<User?> getCurrentUser() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(USERS).doc(firebaseUser?.uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      return User.fromJson(userDocument.data()!);
    } else {
      return null;
    }
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    try {
      var snapshot = await firestore.collection(USERS).where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        // You might want to consider using a forEach loop here in case multiple users have the same email.
        // For now, we'll just use the first document found.
        var data = snapshot.docs[0].data();
        UserModel doctor = UserModel.fromJson(data);
        return doctor;
      } else {
        return null;
      }
    } catch (e) {

    }
  }

  static Future<String> getUserID() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      return firebaseUser.uid.toString();
    } else {
      return '';
    }
  }

  // Stream<DoctorModel> getUserByID(String id) async* {
  //   StreamController<DoctorModel> userStreamController = StreamController();
  //   firestore.collection(USERS).where('id',isEqualTo: id).snapshots().listen((user) {
  //     try {
  //       DoctorModel doctorModel = DoctorModel.fromJson(user.data());
  //       userStreamController.sink.add(doctorModel);
  //     } catch (e) {
  //       // print('FireStoreUtils.getUserByID failed to parse user object ${user.id}');
  //     }
  //   });
  //   yield* userStreamController.stream;
  // }

  static Future<UserModel?> getUserByID(String id) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(USERS).doc(id).get();
    if (userDocument.data() != null && userDocument.exists) {
      print("dataaaaaa aaa ");
      return UserModel.fromJson(userDocument.data()!);
    } else {
      print("nulllll");
      return null;
    }
  }

  // static Future<DoctorModel?> getDoctorByID(String id) async {
  //   DocumentSnapshot<Map<String, dynamic>> userDocument = await firestore.collection(USERS).doc(id).get();
  //   if (userDocument.data() != null && userDocument.exists) {
  //     print("dataaaaaa aaa ");
  //     return DoctorModel.fromJson(userDocument.data()!);
  //   } else {
  //     print("nulllll");
  //     return null;
  //   }
  // }

  static Future<DepartmentModel?> getDepartmentByID(String id) async {
    DocumentSnapshot<Map<String, dynamic>> departementDocument =
        await firestore.collection(DEPARTMENTS).doc(id).get();
    if (departementDocument.data() != null && departementDocument.exists) {
      print("dataaaaaa aaa ");
      return DepartmentModel.fromJson(departementDocument.data()!);
    } else {
      print("nulllll");
      return null;
    }
  }

  // static Future<DepartmentModel> getDepartmentById(String id) async {
  //   QuerySnapshot<Map<String, dynamic>> productsQuery =
  //   await firestore.collection(DEPARTMENTS).where('doctor_id', isEqualTo: id).get();
  //
  //   // Use 'firstWhere' with an async predicate to find the first valid department.
  //   QueryDocumentSnapshot<Map<String, dynamic>> validDocument = await productsQuery.docs.firstWhere(
  //         (document) async {
  //       try {
  //         return DepartmentModel.fromJson(document.data());
  //       } catch (e) {
  //         print('Error parsing department data: $e');
  //         return false; // If parsing fails, return false to continue searching.
  //       }
  //     } as bool Function(QueryDocumentSnapshot<Map<String, dynamic>> element),
  //     // Return null if no valid department is found.
  //   );
  //
  //   // Return the valid department if found, or a default department if null.
  //   return DepartmentModel.fromJson(validDocument.data());
  // }

  static Future<DepartmentModel?> getDepartmentById(String id) async {
    try {
      var snapshot = await firestore.collection(DEPARTMENTS).where('id', isEqualTo: id).get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs[0].data();
        var department = DepartmentModel.fromJson(data);
        return department;
      }
    } catch (e) {
      print('Error getting department by ID: $e');
    }
    return null; // Return null if department not found or an error occurred
  }

  static Future<UserModel?> createUser(UserModel user) async {
    var User;
    try {
      User =
          await firestore.collection(USERS).add(user.toJson()).then((document) {
        return User;
      });
    } catch (e) {
      print(e);
    }
    return User;
  }


  static Future<DoctorModel?> createDoctor(DoctorModel user) async {
    var User;
    try {
      User =
      await firestore.collection(USERS).add(user.toJson()).then((document) {
        return User;
      });
    } catch (e) {
      print("error during doctor registration: ");
      print(e);
    }
    return User;
  }

  static Future<User?> updateCurrentUser(User user) async {
    // UserPreference.setUserId(userID: user.userID);
    return await firestore
        .collection(USERS)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    });
  }

  static Future<PostModel?> createPost(PostModel post) async {
    var Post;
    try {
      Post =
          await firestore.collection(POSTS).add(post.toJson()).then((document) {
        return post;
      });
    } catch (e) {
      print(e);
    }
    return Post;
  }

  static Future<QuestionModel?> createQuestion(QuestionModel question) async {
    var Question;
    try {
      Question = await firestore
          .collection(POSTS)
          .add(question.toJson())
          .then((document) {
        return question;
      });
    } catch (e) {
      print(e);
    }
    return Question;
  }

  static Future<PostModel?> updatePost(PostModel post) async {
    return await firestore
        .collection(POSTS)
        .doc(post.id)
        .set(post.toJson())
        .then((document) {
      return post;
    });
  }

  static Future<String> uploadUserAvatarToFireStorage(
      File image, String userID) async {
    Reference upload = storage.child('images/users/$userID.png');

    UploadTask uploadTask = upload.putFile(image);
    var downloadUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  static Future<String> uploadPostThumbnailToFireStorage(
      File image, String userID) async {
    Reference upload = storage.child('images/posts/$userID.png');

    UploadTask uploadTask = upload.putFile(image);
    var downloadUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    QuerySnapshot<Map<String, dynamic>> productsQuery =
        await firestore.collection(POSTS).where('doctor_id', isNotEqualTo: null).get();
    await Future.forEach(productsQuery.docs,
        (QueryDocumentSnapshot<Map<String, dynamic>> document) {
      try {
        posts.add(PostModel.fromJson(document.data()));
      } catch (e) {
        print('productspppp**-FireStoreUtils.getAllProducts Parse error $e');
      }
    });
    return posts;
  }

  static Future<List<PostModel>> getPostsByDoctorID(String id) async {
    List<PostModel> posts = [];
    QuerySnapshot<Map<String, dynamic>> productsQuery =
    await firestore.collection(POSTS).where('doctor_id', isEqualTo: id).get();
    await Future.forEach(productsQuery.docs,
            (QueryDocumentSnapshot<Map<String, dynamic>> document) {
          try {
            posts.add(PostModel.fromJson(document.data()));
          } catch (e) {
            print('productspppp**-FireStoreUtils.getAllProducts Parse error $e');
          }
        });
    return posts;
  }


  static Future<List<PostModel>> getPostsByDepartmentID(String id) async {
    List<PostModel> posts = [];
    QuerySnapshot<Map<String, dynamic>> productsQuery =
    await firestore.collection(POSTS).where('department_id', isEqualTo: id).get();
    await Future.forEach(productsQuery.docs,
            (QueryDocumentSnapshot<Map<String, dynamic>> document) {
          try {
            posts.add(PostModel.fromJson(document.data()));
          } catch (e) {
            print('productspppp**-FireStoreUtils.getAllProducts Parse error $e');
          }
        });
    return posts;
  }

  static Future<DoctorModel?> getDoctorById(String id) async {
    try {
      var snapshot = await firestore.collection(USERS).where('id', isEqualTo: id).get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs[0].data();
        var doctor = DoctorModel.fromJson(data);
        return doctor;
      }
    } catch (e) {
      print('Error getting doctor by ID: $e');
    }
    return null; // Return null if doctor not found or an error occurred
  }

  static Future<UserModel?> getUserById(String id) async {
    try {
      var snapshot = await firestore.collection(USERS).where('id', isEqualTo: id).get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs[0].data();
        var user = UserModel.fromJson(data);
        return user;
      }
    } catch (e) {
      print('Error getting doctor by ID: $e');
    }
    return null; // Return null if doctor not found or an error occurred
  }

  // Function to fetch cities from Firestore
  Future<List<CityModel>?> fetchCities() async {
    List<CityModel>? cities;
    try {
      final citiesCollection = FirebaseFirestore.instance.collection(CITIES);
      final querySnapshot = await citiesCollection.get();

      cities = querySnapshot.docs.map((doc) => CityModel.fromJson(doc.data())).toList();
    } catch (e) {
      print('Error fetching cities: $e');
    }
    return cities;
  }

  Future<List<DepartmentModel>?> fetchDepartments() async {
    List<DepartmentModel>? departments;
    try {
      final citiesCollection = FirebaseFirestore.instance.collection(DEPARTMENTS);
      final querySnapshot = await citiesCollection.get();

      departments = querySnapshot.docs.map((doc) => DepartmentModel.fromJson(doc.data())).toList();
    } catch (e) {
      print('Error fetching cities: $e');
    }
    return departments;
  }

  Future<DoctorModel?> getDoctorByID(String id) async {
    DoctorModel doctor;
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(USERS).doc(id).get();
    if (userDocument.data() != null && userDocument.exists) {
      print("dataaaaaa aaa ");
      doctor = DoctorModel.fromJson(userDocument.data()!);
    } else {
      print("nulllll");
      return null;
    }
  }

  Future<List<DoctorModel>> getAllDoctors() async {
    List<DoctorModel> doctors = [];
    QuerySnapshot<Map<String, dynamic>> productsQuery = await firestore
        .collection(USERS)
        .where('user_type', isEqualTo: 'doctor')
        .get();
    await Future.forEach(productsQuery.docs,
        (QueryDocumentSnapshot<Map<String, dynamic>> document) {

      // try {
      doctors.add(DoctorModel.fromJson(document.data()));
      // } catch (e) {
      //   print('productspppp**-FireStoreUtils.getAllProducts Parse error $e');
      // }
    });
    print(doctors);
    return doctors;
  }

  static Future<DepartmentModel?> createDepartment(DepartmentModel post) async {
    var Post;
    try {
      Post = await firestore
          .collection(DEPARTMENTS)
          .add(post.toJson())
          .then((document) {
        return post;
      });
    } catch (e) {
      print(e);
    }
    return Post;
  }

  static Future<DepartmentModel?> updateDepartment(
      DepartmentModel department) async {
    return await firestore
        .collection(POSTS)
        .doc(department.id)
        .set(department.toJson())
        .then((document) {
      return department;
    });
  }

  Future<List<DepartmentModel>> getAllDepartments() async {
    List<DepartmentModel> departments = [];
    QuerySnapshot<Map<String, dynamic>> productsQuery =
        await firestore.collection(DEPARTMENTS).get();
    await Future.forEach(productsQuery.docs,
        (QueryDocumentSnapshot<Map<String, dynamic>> document) {
      try {
        departments.add(DepartmentModel.fromJson(document.data()));
      } catch (e) {
        print('ProductHunt**-FireStoreUtils.getAllProducts Parse error $e');
      }
    });
    return departments;
  }

  Future<String?> getplaceholderimage() async {
    var collection = FirebaseFirestore.instance.collection(SETTINGS);
    var docSnapshot = await collection.doc('placeHolderImage').get();
    Map<String, dynamic>? data = docSnapshot.data();
    var value = data?['image'];

    placeholderImage = value;
    return placeholderImage;
  }

  static Future<File> compressImage(File file) async {
    File compressedImage = await FlutterNativeImage.compressImage(
      file.path,
      quality: 25,
    );
    return compressedImage;
  }

  // _signUpWithEmailAndPassword(email, password, _image, firstName, lastName,
  //     mobile) async {
  //   UserModel? user;
  //   await showProgress(context, "creatingNewAccountPleaseWait".toString(), false);
  //   dynamic result = await FireStoreUtils.firebaseSignUpWithEmailAndPassword(
  //       email!,
  //       password!,
  //       _image!,
  //       firstName!,
  //       lastName!,
  //       mobile!,
  //       context);
  //
  //   await hideProgress();
  //   if (result != null && result is UserModel) {
  //     MyApp.currentUser = result as UserModel?;
  //
  //     user = UserModel(
  //       email: result!.email.toString(),
  //       firstname: result!.firstname,
  //       lastname: result!.lastname,
  //       phone: result!.phone,
  //       id: '',
  //       address: '',
  //       avatar: result!.avatar,
  //       password: '',
  //     );
  //     MyApp.currentUser = user;
  //
  //   } else if (result != null && result is String) {
  //     showAlertDialog(context, 'failed'.toString(), result, true);
  //   } else {
  //     showAlertDialog(context, 'failed'.toString(), "couldNotSignUp".toString(), true);
  //   }
  // }

  static firebaseSignUpWithEmailAndPassword(
      String emailAddress,
      String password,
      File? image,
      String firstName,
      String lastName,
      String mobile,
      BuildContext context) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      String profilePicUrl = '';
      if (image != null) {
        File compressedImage = await FireStoreUtils.compressImage(image);
        final bytes = compressedImage.readAsBytesSync().lengthInBytes;
        final kb = bytes / 1024;
        final mb = kb / 1024;

        if (mb > 2) {
          hideProgress();
          showAlertDialog(
              context, "error".toString(), "imageTooLarge".toString(), true);
          return;
        }
        updateProgress('Uploading image, Please wait...'.toString());
        profilePicUrl = await uploadUserAvatarToFireStorage(
            compressedImage, result.user?.uid ?? '');
      }
      UserModel user = UserModel(
          email: emailAddress,
          active: true,
          phone: mobile,
          firstname: firstName,
          id: result.user?.uid ?? '',
          lastname: lastName,
          avatar: profilePicUrl,
          address: AutofillHints.addressCityAndState,
          password: mobile);
      UserModel? errorMessage = await createUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'Couldn\'t sign up for firebase, Please try again.';
      }
    } on auth.FirebaseAuthException catch (error) {
      print(error.toString() + '${error.stackTrace}');
      String message = "notSignUp".toString();
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please pick another email!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
      return message;
    } catch (e) {
      return "notSignUp".toString();
    }
  }

  static resetPassword(String emailAddress) async =>
      await auth.FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress);

  static deleteUser() async {
    try {
      // delete user records from CHANNEL_PARTICIPATION table
      await firestore
          .collection(QUESTIONS)
          .where('user_id',
              isEqualTo: auth.FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        for (var doc in value.docs) {
          await firestore.doc(doc.reference.path).delete();
        }
      });

      // delete user records from users table
      await firestore
          .collection(USERS)
          .doc(auth.FirebaseAuth.instance.currentUser!.uid)
          .delete();

      // delete user  from firebase auth
      await auth.FirebaseAuth.instance.currentUser!.delete();
    } catch (e, s) {
      print('FireStoreUtils.deleteUser $e $s');
    }
  }

  // Method to get conversations for the current user from Firestore
  static Stream<List<Conversation>> getConversations() {
    final currentUserUid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUid == null) {
      // If the user is not authenticated, return an empty stream
      return Stream.value([]);
    }

    // Firestore query to fetch conversations for the current user
    final query = firestore
        .collection('conversations')
        .where('members', arrayContains: currentUserUid)
        .snapshots();

    // Map the Firestore snapshots to a list of Conversation objects
    return query.map((snapshot) {
      final conversations =
      snapshot.docs.map((doc) => Conversation.fromSnapshot(doc)).toList();
      return conversations;
    });
  }
  // Method to get messages for a specific conversation from Firestore
  static Stream<List<Message>> getMessages(String conversationId) {
    // Firestore query to fetch messages for the specified conversation
    final query = firestore.collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();

    // Map the Firestore snapshots to a list of Message objects
    return query.map((snapshot) {
      final messages = snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList();
      return messages;
    });
  }

  // Method to send a message and save it in Firestore
  static Future<void> sendMessage(String chatId, Message message) async {
    try {
      final messageData = {
        'senderId': message.senderId,
        'content': message.content,
        'timestamp': Timestamp.fromDate(message.timestamp),
      };

      // Add the message data to the messages sub-collection of the conversation
      await firestore
          .collection('conversations')
          .doc(chatId)
          .collection('messages')
          .add(messageData);
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
