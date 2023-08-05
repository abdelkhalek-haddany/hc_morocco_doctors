import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/firebase_options.dart';
import 'package:hc_morocco_doctors/screens/auth/login_screen.dart';
import 'package:hc_morocco_doctors/screens/auth/welcome_screen.dart';
import 'package:hc_morocco_doctors/screens/onboard/onboard.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'models/UserModel.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    initializeUser();
  }

  Future<void> initializeUser() async {
    print("I'm in the initializeUser function");
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      print("There is a user");
      UserModel? user =
      await FireStoreUtils.getUserByEmail(firebaseUser.email.toString());
      print(user!.toJson().toString());
      if (user.user_type == USER_ROLE_CUSTOMER) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboard()),
        );
      }
    } else {
      print("There is no user");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  static UserModel? currentUser;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Morocco HC',
      home: LoginScreen(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
