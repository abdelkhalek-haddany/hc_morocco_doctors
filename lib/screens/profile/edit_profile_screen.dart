import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hc_morocco_doctors/components/app_bar.dart';
import 'package:hc_morocco_doctors/components/drawer/custom_drawer.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import 'package:hc_morocco_doctors/widgets/profile_widget.dart';
import 'package:hc_morocco_doctors/models/utils/doctor.dart';
import 'package:hc_morocco_doctors/screens/profile/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
final user = DoctorPrefrences.MyDoctor;

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _firstname = new TextEditingController(text: user.firstname);
  TextEditingController _lastname = new TextEditingController(text: user.lastname);
  TextEditingController _email = new TextEditingController(text: user.email);
  TextEditingController _phone = new TextEditingController(text: user.phone);
  TextEditingController _about = new TextEditingController(text: user.about);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: buildAppBar(context),
      body: ListView(physics: BouncingScrollPhysics(), children: [
        ProfileWidget(
            imagePath: user.avatar,
            icon: Icon(Icons.add_a_photo_outlined),
            isEdit:true,
            onClicked: () async {
              final image = await ImagePicker().pickImage(source: ImageSource.gallery);
            }),
        SizedBox(
          height: 28,
        ),
        Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 40),
            child: Column(
              children: [
                _entryField("First Name", _firstname),
                _entryField("Last Name", _lastname),
                _entryField("Email", _email),
                _entryField("Phone", _phone),
                _entryField("Description", _about, lines: 10),
                _submitButton()
              ],
            )),
      ]),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController textController, {
    bool isPassword = false,
    int lines = 1,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              minLines: lines,
              maxLines: lines * 2,
              obscureText: isPassword,
              controller: textController,
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Text(
            'Save',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
