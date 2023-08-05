import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hc_morocco_doctors/screens/auth/forget_password.dart';
import 'package:hc_morocco_doctors/screens/auth/role_page.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import 'package:hc_morocco_doctors/screens/auth/signup_screen.dart';
import 'package:hc_morocco_doctors/screens/home/DashboardScreen.dart';
import 'package:hc_morocco_doctors/widgets/bezierContainer.dart';
import 'package:provider/provider.dart';
import '../../components/LoadingPopup.dart';
import '../../constants.dart';

import 'successful_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // App app = MyApp() as App;

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
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
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        const Positioned(
          child: BezierContainer(),
          top: 0,
        ),
        Container(
          padding: const EdgeInsets.only(top: 180),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                userInput(emailController, 'Email', TextInputType.emailAddress),
                userInput(passwordController, 'Password',
                    TextInputType.visiblePassword),
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
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      showAwesomeLoadingPopup(context);
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        // If login is successful, you can navigate to another screen or perform other actions.
                        // For example:
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => DashboardScreen()));
                      } catch (e) {
                        // Handle login errors here, such as displaying a snackbar or alert dialog with the error message.
                        // For example:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Login failed. Please check your credentials.')),
                        );
                      }
                      // Provider.of<Auth>(context, listen: false).signup(emailController.text, passwordController.text);
                      // String hashedPassword = Crypt.sha256(passwordController.text).toString();
                      // Credentials emailPwCredentials = Credentials.emailPassword(emailController.text, hashedPassword);
                      // await app.logIn(emailPwCredentials);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: InkWell(
                  child: const Text('Forgot password ?'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()));
                  },
                )),
                const SizedBox(height: 20),
                Center(
                    child: InkWell(
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: "if you don't have any account, "
                          'please sign up',
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>  RolePage()));
                  },
                )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.transparent),
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(8),
                          margin:
                              EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Image.asset("assets/icons/google.png")),
                      onTap: () async {
                        print("GGGGGGGGGGGGGGGGGGGGGG");
                        // context.loaderOverlay.show();
                        try {
                          await signInWithGoogle(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DashboardScreen()));
                        } catch (e) {
                          if (e is FirebaseAuthException) {
                            print(e);
                            // context.loaderOverlay.hide();
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
                            margin:
                                EdgeInsets.only(top: 20, right: 30, left: 30),
                            child: Image.asset("assets/icons/twitter.png")),
                        onTap: () async {}),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    )));
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
User? user;
late final GoogleSignInAccount? googleSignInAccount;

Future<void> signInWithGoogle(BuildContext context) async {
  if (FirebaseAuth.instance.currentUser == null) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      googleSignInAccount = await googleSignIn.signIn();
    } catch (e) {
      print(e);
    }
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      user = result.user;
    }
  }
}
// else {
//   Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (context) => MainScreen()));
// }
// }
//
