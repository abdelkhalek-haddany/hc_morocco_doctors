import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hc_morocco_doctors/widgets/bezierContainer.dart';

import '../../themes/style.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        _showSuccessDialog();
      } catch (e) {
        _showErrorDialog('Failed to send reset email. Please try again.');
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Password reset email sent. Please check your inbox.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Positioned(
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
                    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                height: 55,
                                margin: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: primaryColor, width: 1),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 15, right: 25),
                                    child: TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          const InputDecoration.collapsed(
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ))),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor, // Set the background color to black
                              ),
                              onPressed: _resetPassword,
                              child: const Text('Reset Password'),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ])))
    ]));
  }
}
