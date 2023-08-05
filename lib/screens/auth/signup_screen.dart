import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hc_morocco_doctors/components/LoadingPopup.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'package:hc_morocco_doctors/services/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:hc_morocco_doctors/database/connection.dart';
import 'package:hc_morocco_doctors/models/UserModel.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import 'package:hc_morocco_doctors/screens/auth/login_screen.dart';
import 'package:hc_morocco_doctors/screens/home/DashboardScreen.dart';
import 'package:hc_morocco_doctors/widgets/bezierContainer.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNmaeController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  dynamic _mediaFiles = null;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        Positioned(
          child: BezierContainer(),
          top: 0,
        ),
        Container(
          padding: EdgeInsets.only(top: 60),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    _mediaFiles == null
                        ? Center(child: displayCircleImage('', 120, false))
                        : _imageBuilder(_mediaFiles),
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      start: 80,
                      end: 0,
                      child: FloatingActionButton(
                          heroTag: 'userImage',
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.camera_alt,
                            color: isDarkMode(context)
                                ? Colors.black
                                : Colors.white,
                          ),
                          mini: true,
                          onPressed: () => {_pickImage()}),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // CircleAvatar(
                //   child: _mediaFiles.isEmpty == true
                //       ? InkWell(
                //           child: Container(
                //             height: 100,
                //             decoration: BoxDecoration(
                //                 color: Colors.white24,
                //               borderRadius: BorderRadius.circular(50)
                //             ),
                //             child: const Icon(
                //               Icons.account_circle,
                //               color: Color.fromRGBO(165, 117, 255, 1),
                //               size: 60,
                //             ),
                //           ),
                //           onTap: () {
                //             _pickImage();
                //           })
                //       : _imageBuilder(_mediaFiles.first),
                // ),
                userInput(firstNmaeController, 'First Name', TextInputType.text,
                    false),
                userInput(
                    lastNameController, 'Last Name', TextInputType.text, false),
                userInput(phoneController, 'Phone', TextInputType.phone, false),
                userInput(emailController, 'Email', TextInputType.emailAddress,
                    false),
                userInput(
                    addressController, 'Address', TextInputType.text, false),
                userInput(passwordController, 'Password',
                    TextInputType.visiblePassword, true),
                userInput(passwordConfirmationController, 'Confirm Password',
                    TextInputType.visiblePassword, true),
                Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: primaryColor,
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      showAwesomeLoadingPopup(context);
                      await validate();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                    child: InkWell(
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: 'if you have aready an account, '
                          'please try to sign in',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                        text: ' here',
                        style: TextStyle(color: Colors.blue, fontSize: 20)),
                  ])),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )),
                const SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              margin:
                                  EdgeInsets.only(top: 20, right: 30, left: 30),
                              child: Image.asset("assets/icons/facebook.png")),
                          onTap: () async {
                            try {
                              context.loaderOverlay.show();
                              final facebookLoginResult =
                                  await FacebookAuth.instance.login();
                              final userData =
                                  await FacebookAuth.instance.getUserData();

                              final facebookAuthCredintial =
                                  FacebookAuthProvider.credential(
                                      facebookLoginResult.accessToken!.token);
                              await FirebaseAuth.instance
                                  .signInWithCredential(facebookAuthCredintial);
                            } on FirebaseAuthException catch (e) {
                              context.loaderOverlay.hide();
                            }
                          }),
                      InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: primaryColor, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(8),
                            margin:
                                EdgeInsets.only(top: 20, right: 30, left: 30),
                            child: Image.asset("assets/icons/google.png")),
                        onTap: () async {
                          context.loaderOverlay.show();
                          try {
                            // await signup(context);

                            context.loaderOverlay.hide();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DashboardScreen()));
                          } catch (e) {
                            if (e is FirebaseAuthException) {
                              context.loaderOverlay.hide();
                            }
                          }
                        },
                      ),
                      InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(8),
                              margin: const EdgeInsets.only(
                                  top: 20, right: 30, left: 30),
                              child: Image.asset("assets/icons/twitter.png")),
                          onTap: () async {}),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    )));
  }

  validate() async {
    if (_mediaFiles == null) {
      showimgAlertDialog(context, 'Please add Image'.toString(),
          'Add Image to continue'.toString(), true);
    }
    var uuid = const Uuid();

    final imageUrl = await FireStoreUtils.uploadUserAvatarToFireStorage(
        _mediaFiles, uuid.v1());

    UserModel post = UserModel(
        id: uuid.v1(),
        firstname: firstNmaeController.text,
        lastname: lastNameController.text,
        email: emailController.text,
        address: addressController.text,
        avatar: imageUrl,
        phone: phoneController.text,
        password: passwordController.text);
    await FireStoreUtils.createUser(post);

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    await registerWithEmailPassword(email, password);

    firstNmaeController.text = '';
    lastNameController.text = '';
    addressController.text = '';
    emailController.text = '';
    phoneController.text = '';
    passwordController.text = '';
  }

  _pickImage() {
    final action = CupertinoActionSheet(
      message: const Text(
        'Add Picture',
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text('Choose image from gallery'),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              // _mediaFiles.removeLast();
              _mediaFiles = File(image.path);
              // _mediaFiles.add(null);
              setState(() {});
            }
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Take a picture'),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image =
                await _imagePicker.pickImage(source: ImageSource.camera);
            if (image != null) {
              // _mediaFiles.removeLast();
              _mediaFiles = File(image.path);
              // _mediaFiles.add(null);
              setState(() {});
            }
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'.toString()),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  _imageBuilder(dynamic image) {
    // bool isLastItem = image == null;
    return GestureDetector(
      onTap: () {
        _viewOrDeleteImage(image);
      },
      child: Container(
        width: 120,
        height: 120,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(60),
          ),
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: image is File
                ? Image.file(
                    image,
                    fit: BoxFit.cover,
                  )
                : displayImage(image),
          ),
        ),
      ),
    );
  }

  _viewOrDeleteImage(dynamic image) {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            // _mediaFiles.removeLast();
            if (image is File) {
              _mediaFiles.removeWhere(
                  (value) => value is File && value.path == image.path);
            } else {
              _mediaFiles
                  .removeWhere((value) => value is String && value == image);
            }
            // _mediaFiles.add(null);
            setState(() {});
          },
          child: Text('Remove picture'.toString()),
          isDestructiveAction: true,
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            // push(context, image is File ? FullScreenImageViewer(imageFile: image) : FullScreenImageViewer(imageUrl: image));
          },
          isDefaultAction: true,
          child: Text('View picture'.toString()),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'.toString()),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return false;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return regExp.hasMatch(phoneNo);
  }

  showimgAlertDialog(
      BuildContext context, String title, String content, bool addOkButton) {
    Widget? okButton;
    if (addOkButton) {
      okButton = TextButton(
        child: Text('OK'.toString()),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    if (Platform.isIOS) {
      CupertinoAlertDialog alert = CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [if (okButton != null) okButton],
      );
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else {
      AlertDialog alert = AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [if (okButton != null) okButton]);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  showAlertDialog1(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK".toString()),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title".toString()),
      content: Text("This is my message.".toString()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType, bool obscureText) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Field can\'t be empty';
            }
            return null;
          },
          controller: userInput,
          autocorrect: false,
          obscureText: obscureText,
          enableSuggestions: false,
          maxLines: 1,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
