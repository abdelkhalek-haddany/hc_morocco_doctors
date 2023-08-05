// import 'dart:convert';
// import 'dart:io';
//
// import 'package:hc_morocco_doctors/enums/snackbar_message.dart';
// import 'package:hc_morocco_doctors/helpers/my_file_picker.dart';
// import 'package:hc_morocco_doctors/models/PostModel.dart';
// import 'package:hc_morocco_doctors/screens/blog/services/http_service.dart';
// import 'package:hc_morocco_doctors/screens/blog/widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:hc_morocco_doctors/screens/home/DashboardScreen.dart';
//
// class AddBlogController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   late final TextEditingController titleController;
//   late final TextEditingController bodyController;
//   FireStoreUtils fireStoreUtils = new FireStoreUtils();
//   RxBool loading = false.obs;
//   Rx<File?> imageFile = Rx<File?>(null);
//
//   final HttpService httpService = HttpService();
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     titleController = TextEditingController();
//     bodyController = TextEditingController();
//   }
//
//   @override
//   void onClose() {
//     titleController.dispose();
//     bodyController.dispose();
//     super.onClose();
//   }
//
//   void addPost() async {
//     if (formKey.currentState!.validate()) {
//       if (imageFile.value != null) {
//         try {
//           loading(true);
//            PostModel post = new PostModel(id: 'uwgefduywe',
//               title: titleController.text.trim(),
//                content: titleController.text.trim(),
//                doctor_id: await FireStoreUtils.getUserID(),
//              thumbnail: 'wjsgdfjwgf.png'
//            );
//
//           };
//         FireStoreUtils.uploadPostThumbnailToFireStorage(post);
//           FireStoreUtils.createPost(post);
//           if (response.statusCode == 200 || response.statusCode == 201) {
//             uploadImage(jsonData['data']);
//           } else if (response.statusCode == 500) {
//             loading(false);
//             showSnackbar(SnackbarMessage.error, jsonData['msg']);
//           } else {
//             loading(false);
//             showSnackbar(SnackbarMessage.error, 'Unknown Error Occured');
//           }
//         } catch (e) {
//           loading(false);
//           showSnackbar(SnackbarMessage.error, e.toString());
//         }
//       } else {
//         showSnackbar(SnackbarMessage.missing, 'Please upload image');
//       }
//     }
//   }
//
//
//
//   void pickImage(ImageSource imageSource) async {
//     File? pickedFile = await MyFilePicker.pickImage(imageSource);
//     Get.back();
//     if (pickedFile != null) {
//       imageFile(pickedFile);
//     }
//   }
// }
