import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/chat/chat.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import 'package:hc_morocco_doctors/models/DoctorModel.dart';
import 'package:hc_morocco_doctors/models/utils/doctor.dart';

class DoctorProfile extends StatefulWidget {
  final String doctorID;

  const DoctorProfile(this.doctorID);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final fireStoreUtils = FireStoreUtils();
  DoctorModel? doctor;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    print(widget.doctorID);
    doctor = await FireStoreUtils.getDoctorById(widget.doctorID);
    print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    print(doctor?.firstname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
      Stack(
      children: [
      Image.asset(
        "assets/icons/doctor.png",
        height: 300,
        width: double.infinity,
      ),
      Positioned(
        bottom: 5,
        right: 10,
        child: InkWell(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.chat,
              size: 30,
              color: primaryColor,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ChatScreen(),
              ),
            );
          },
        ),
      ),
      ],
    ),
    SizedBox(height: 28),

          buildName(doctor),
          SizedBox(height: 28),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Doctor posts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          DoctorPostsSection(),
        ],
      ),
    );
  }

  Widget buildName(DoctorModel? user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: user != null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.firstname + ' ' + user.lastname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 5),
                Container(
                  child: InkWell(
                    child: Text('#' + user.department),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                '+ follow',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.post_add),
                      Text(
                        "16",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: InkWell(
                      child: Text(
                        "Posts",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              VerticalDivider(),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.supervised_user_circle_sharp),
                      Text(
                        "726",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: InkWell(
                      child: Text(
                        "Followers",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 35),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "About",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.about,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ],
    )
        : Container(child: Text("There are no doctor")),
  );
}

class DoctorPostsSection extends StatelessWidget {
  const DoctorPostsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        DoctorPostCard(
        image: 'assets/icons/departments/heart.svg',
        title: 'Heart',

          content: 'hello world',
        ),
          DoctorPostCard(
            image: 'assets/icons/departments/heart.svg',
            title: 'Heart',
            content: 'hello world',
          ),
          DoctorPostCard(
            image: 'assets/icons/departments/heart.svg',
            title: 'Heart',
            content: 'hello world',
          ),
        ],
        ),
    );
  }
}

class DoctorPostCard extends StatelessWidget {
  final String image;
  final String title;
  final String content;

  const DoctorPostCard({
    Key? key,
    required this.image,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/test.jpg"),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(content),
          SizedBox(height: 5),
          SizedBox(
            height: 1,
            child: Container(
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.thumb_up_alt_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.contact_support_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
