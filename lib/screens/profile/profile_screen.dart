import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/models/UserModel.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'package:hc_morocco_doctors/widgets/profile_widget.dart';
import 'package:hc_morocco_doctors/models/DoctorModel.dart';
import 'package:hc_morocco_doctors/models/utils/doctor.dart';
import 'package:hc_morocco_doctors/screens/profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final fireStoreUtils = FireStoreUtils();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Change the return type to Future<void> since we don't need to return anything.
  // Use await before the async call to wait for the result.
  // Handle exceptions if necessary.
  Future<void> fetchData() async {
    try {
      UserModel user = fireStoreUtils.getCurrentUser() as UserModel;
      var userData = await FireStoreUtils.getDoctorById(user.email);
      print(userData?.firstname);
      setState(() {
        user = userData as UserModel;
      });
    } catch (e) {
      // Handle any exceptions that may occur during data fetching.
      print('Error fetching data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(physics: BouncingScrollPhysics(), children: [
        ProfileWidget(imagePath: user!.avatar,icon: Icon(Icons.edit), onClicked: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditProfileScreen(),)
          );
        }, isEdit: true,),
        SizedBox(
          height: 28,
        ),
        buildName(user),
      ]),
    );
  }

  Widget buildName(UserModel? user) => Column(
        children: [
          Text(
            user!.firstname + ' ' + user!.lastname,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text(
            user!.email,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 5),
          // Container(
          //   child: InkWell(
          //     child: Text('#' + user.department),
          //     onTap: () => {},
          //   ),
          // ),
          SizedBox(height: 20),
          IntrinsicHeight(
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              children: [
                Text(
                  "16",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: InkWell(
                    child: Text(
                      "Posts",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => {},
                  ),
                ),
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Text(
                  "726",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: InkWell(
                    child: Text(
                      "Folowers",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => {},
                  ),
                ),
              ],
            ),
          ])),
          SizedBox(height: 35),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "About",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   user.about,
                    //   textAlign: TextAlign.center,
                    //   style:
                    //       TextStyle(fontSize: 14, overflow: TextOverflow.clip),
                    // )
                  ])),
        ],
      );
}
