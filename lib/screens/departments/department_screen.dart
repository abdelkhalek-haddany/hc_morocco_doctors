import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/constants.dart';
import 'package:hc_morocco_doctors/models/DepartmentModel.dart';
import 'package:hc_morocco_doctors/models/PostModel.dart';
import 'package:hc_morocco_doctors/screens/profile/doctor_profile_screen.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'package:hc_morocco_doctors/services/helper.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import 'package:hc_morocco_doctors/models/DoctorModel.dart';
import 'package:hc_morocco_doctors/models/utils/doctor.dart';

class DepartmentScreen extends StatefulWidget {
  String DepartmentID;
  DepartmentScreen(this.DepartmentID);

  // const DoctorProfile(this.DoctorID, {Key? key}) : super(key: key);

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  final fireStoreUtils = FireStoreUtils();
  DepartmentModel? department;

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
      print(widget.DepartmentID);
      var departmentData = await FireStoreUtils.getDepartmentByID(widget.DepartmentID);
      print(departmentData?.title);
      setState(() {
        department = departmentData;
      });
    } catch (e) {
      // Handle any exceptions that may occur during data fetching.
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: ListView(physics: BouncingScrollPhysics(), children: [
        Stack(children: [
          Image.asset(
            "assets/icons/doctor.png",
            height: 300,
            width: double.infinity,
          ),
        ]),
        SizedBox(
          height: 28,
        ),

        buildName(department),

        SizedBox(
          height: 28,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Department posts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: 20,
        ),
        PostsSection(department_id: widget.DepartmentID,),
      ]),
    );
  }

  Widget buildName(DepartmentModel? departmentModel) => Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: departmentModel != null ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                departmentModel!.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ]),
            InkWell(
              child: Text(
                '+ interested',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {},
            ),
          ]),
          SizedBox(height: 20),
          IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Column(
                  children: [
                    Row(children: [
                      Icon(Icons.post_add),
                      Text(
                        "16",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Container(
                      child: InkWell(
                        child: Text(
                          "Posts",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onTap: () => {},
                      ),
                    ),
                  ],
                ),
                VerticalDivider(),
                Column(
                  children: [
                    Row(children: [
                      Icon(Icons.supervised_user_circle_sharp),
                      Text(
                        "726",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Container(
                      child: InkWell(
                        child: Text(
                          "Doctors",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onTap: () => {},
                      ),
                    ),
                  ],
                ),
              ])),
          SizedBox(height: 35),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      departmentModel!.description,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, overflow: TextOverflow.clip),
                    )
                  ])),
        ],
      )
  : Container(child:Text("there are no department"))
  );
}

class PostsSection extends StatelessWidget {
    late String department_id;
    List<PostModel>? posts;
    PostsSection({Key? key, required this.department_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<PostModel>>? lstPost;
    lstPost = FireStoreUtils.getPostsByDepartmentID(department_id);
    return Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<PostModel>>(
                  future: lstPost,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                          AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                        ),
                      );

                    if (snapshot.hasData ||
                        (snapshot.data?.isNotEmpty ?? false)) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length > 15
                              ? 15
                              : snapshot.data!.length,
                          itemBuilder: (_, i) {
                            PostModel data = snapshot.data![i];
                            return PostCard(
                              post: data,
                            );
                          });

                      // });
                      // Container(child:Text(snapshot.data.toString())),
                      // ListView.builder(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.vertical,
                      //     physics: BouncingScrollPhysics(),
                      //     itemCount: vendors.length > 15
                      //         ? 15
                      //         : vendors.length,
                      //   itemBuilder: (BuildContext context, int index) =>
                      //     buildAllRestaurantsData(vendors[index]),
                      //     ),
                    } else {
                      return showEmptyState('No Posts'.tr(),
                          'Start by adding posts to database.'.tr());
                    }
                  }),

              // PostCard(
              //     image: 'assets/icons/departments/heart.svg', title: 'Heart', content: 'hello world',),
              // PostCard(
              //     image: 'assets/icons/departments/heart.svg', title: 'Heart', content: 'hello world',),
              // PostCard(
              //     image: 'assets/icons/departments/heart.svg', title: 'Heart', content: 'hello world',),
            ]));
  }
}
class PostCard extends StatelessWidget {
  PostModel post;

  PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DepartmentModel? department;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<DoctorModel?>(
                  future: post.doctor(),
                  initialData: null,
                  builder: (context, snapshot) => snapshot.hasData
                      ? Row(children: [
                    InkWell(
                        child: CachedNetworkImage(
                          imageUrl:
                          getImageVAlidUrl(snapshot.data!.avatar),
                          height: 50,
                          width: 50,
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(
                                    Color(COLOR_PRIMARY)),
                              )),
                          errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/icons/google.png",
                                fit: BoxFit.cover,
                                cacheHeight: 100,
                                cacheWidth: 100,
                              )),
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          // switch to doctor profile
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DoctorProfile(snapshot.data!.id)),
                          );
                        }),
                    // CircleAvatar(
                    //   child: Image.asset("assets/icons/google.png"),
                    // ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<DoctorModel?>(
                              future: post.doctor(),
                              initialData: null,
                              builder: (context, snapshot) => snapshot
                                  .hasData
                                  ? InkWell(
                                  child: Text(
                                      snapshot.data!.firstname +
                                          ' ' +
                                          snapshot.data!.firstname),
                                  onTap: () {
                                    // switch to doctor profile
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorProfile(
                                                  snapshot.data!.id)),
                                    );
                                  })
                                  : Text('unknown doctor'),
                            ),
                            FutureBuilder<DepartmentModel?>(
                              future: post.get_department(),
                              initialData: null,
                              builder: (context, snapshot) =>
                              snapshot.hasData
                                  ? Text(snapshot.data!.title)
                                  : Text('unknown department'),
                            ),
                          ],
                        )),
                  ])
                      : Text('uknowen doctor'),
                ),
                InkWell(
                  child: Text(
                    "+ Folow",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {},
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CachedNetworkImage(
              imageUrl: post.thumbnail,
              height: 220,
              width: double.infinity,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:
                  DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                  )),
              errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/image1.png",
                    fit: BoxFit.cover,
                    cacheHeight: 100,
                    cacheWidth: 100,
                  )),
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              post.title.length>100 ?
              post.title.substring(0, 100)+'...' : post.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              post.content.length>200 ?
              post.content.substring(0, 200) + '...': post.content,
            ),
            SizedBox(
              height: 5,
            ),
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
                    onPressed: () {}, icon: Icon(Icons.thumb_up_alt_outlined)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.contact_support_outlined)),
              ],
            )
          ],
        ));
  }
}