import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hc_morocco_doctors/constants.dart';
import 'package:hc_morocco_doctors/models/User.dart';
import 'package:hc_morocco_doctors/models/UserModel.dart';
import 'package:hc_morocco_doctors/screens/auth/login_screen.dart';
import 'package:hc_morocco_doctors/screens/profile/profile_screen.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';

class BottomUserInfo extends StatelessWidget {
  final bool isCollapsed;

  const BottomUserInfo({
    Key? key,
    required this.isCollapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Moved firebaseUser and user declaration inside the build method to ensure freshness.
    Future<UserModel?> fetchData() async {
      auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
      UserModel? user;
      try {
        user =
            await FireStoreUtils.getUserByEmail(firebaseUser!.email.toString());
      } catch (e) {
        // Handle any exceptions that may occur during data fetching.
        print('Error fetching data: $e');
      }
      return user;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isCollapsed ? 70 : 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<UserModel?>(
        future: fetchData(),
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
              ),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            // Extracted the common widgets used in both collapsed and expanded states into separate functions.
            return isCollapsed
                ? _buildCollapsedWidget(context,snapshot.data)
                : _buildExpandedWidget(context, snapshot.data);
          } else {
            // Show a message or default widget when there's no data
            return Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }

  Widget _buildCollapsedWidget(BuildContext context, UserModel? data) {
    return Center(
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    data!.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        data?.firstname != null && data?.lastname != null
                            ? '${data!.firstname} ${data!.lastname}'
                            : 'Unknown User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data.user_type,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        },
      ),
    );
  }

  Widget _buildExpandedWidget(BuildContext context, UserModel? data) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                data!.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );},
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
