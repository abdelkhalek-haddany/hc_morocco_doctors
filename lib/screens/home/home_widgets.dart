import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/constants.dart';
import 'package:hc_morocco_doctors/models/DoctorModel.dart';
import 'package:hc_morocco_doctors/models/PostModel.dart';
import 'package:hc_morocco_doctors/screens/blog/view_blog_screen.dart';
import 'package:hc_morocco_doctors/screens/departments/department_screen.dart';
import 'package:hc_morocco_doctors/screens/profile/doctor_profile_screen.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';

import '../../models/DepartmentModel.dart';
import '../../services/helper.dart';

class DoctorsBanner extends StatelessWidget {
  const DoctorsBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final fireStoreUtils = FireStoreUtils();
    Future<List<DoctorModel>>? lstDoctors;
    lstDoctors = fireStoreUtils.getAllDoctors();
    int carousleindex = 0;
    return FutureBuilder<List<DoctorModel>>(
      future: fireStoreUtils.getAllDoctors(),
      builder: (context, snapshot) => snapshot.hasData
          ? StatefulBuilder(
              builder: (context, setState) => Container(
                  margin: EdgeInsets.only(top: 3),
                  height: 180,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 180,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(
                              () {
                                carousleindex = index;
                              },
                            );
                          },
                          autoPlayInterval: const Duration(seconds: 8),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: snapshot.data!.map((i) {
                          DoctorModel data = snapshot.data![carousleindex];
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  // borderRadius: BorderRadius.circular(20)
                                ),
                                // border: Border.all(color: primaryColor, width: 1)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: getImageVAlidUrl(data.avatar),
                                      height: 100,
                                      width: 100,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                        valueColor: AlwaysStoppedAnimation(
                                            Color(COLOR_PRIMARY)),
                                      )),
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                "assets/icons/google.png",
                                                fit: BoxFit.cover,
                                                cacheHeight: 40,
                                                cacheWidth: 40,
                                              )),
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              data.lastname +
                                                  ' ' +
                                                  data.lastname,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '#' + 'Departement',
                                              style: TextStyle(
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  data.address,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            InkWell(
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 5),
                                                  margin:
                                                      EdgeInsets.only(top: 30),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Text(
                                                    'Profile',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorProfile(
                                                              data.id)),
                                                );
                                              },
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      // AnimatedSmoothIndicator(
                      //   activeIndex: carousleindex,
                      //   count: snapshot.data!.length,
                      //   effect: ExpandingDotsEffect(
                      //       activeDotColor: Colors.pink,
                      //       dotColor: Colors.grey,
                      //       dotWidth: 2,
                      //       dotHeight: 1),
                      // )
                    ],
                  )),
            )
          : Center(
              child: Text('There is no doctor'),
            ),
    );
  }
}

//  @override
// Widget build(BuildContext context) {
//   final fireStoreUtils = FireStoreUtils();
//   Future<List<DoctorModel>>? lstDoctors;
//   lstDoctors = fireStoreUtils.getAllDoctors();
//   int carousleindex = 0;
//   return StatefulBuilder(
//       builder: (context, setState) => Container(
//           margin: EdgeInsets.only(top: 3),
//           width: double.infinity,
//           height: 180,
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 180,
//                     aspectRatio: 16 / 9,
//                     viewportFraction: 1,
//                     initialPage: 0,
//                     enableInfiniteScroll: true,
//                     reverse: false,
//                     autoPlay: true,
//                     onPageChanged: (index, reason) {
//                       setState(
//                         () {
//                           carousleindex = index;
//                         },
//                       );
//                     },
//                     autoPlayInterval: const Duration(seconds: 8),
//                     autoPlayAnimationDuration:
//                         const Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     scrollDirection: Axis.horizontal,
//                   ),
//                   items: [
//                     FutureBuilder<List<DoctorModel>>(
//                         future: lstDoctors,
//                         initialData: [],
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: CircularProgressIndicator.adaptive(
//                                 valueColor: AlwaysStoppedAnimation(
//                                     Color(COLOR_PRIMARY)),
//                               ),
//                             );
//                           }
//                           if (snapshot.hasData ||
//                               (snapshot.data?.isNotEmpty ?? false)) {
//                             return ListView.builder(
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.horizontal,
//                                 physics: const ClampingScrollPhysics(),
//                                 itemCount: snapshot.data!.length > 5
//                                     ? 5
//                                     : snapshot.data!.length,
//                                 itemBuilder: (_, i) {
//                                   DoctorModel data = snapshot.data![i];
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.deepPurpleAccent,
//                                       // borderRadius: BorderRadius.circular(20)
//                                     ),
//                                     // border: Border.all(color: primaryColor, width: 1)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         CachedNetworkImage(
//                                           imageUrl:
//                                               getImageVAlidUrl(data.avatar),
//                                           height: 100,
//                                           width: 100,
//                                           imageBuilder:
//                                               (context, imageProvider) =>
//                                                   Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               image: DecorationImage(
//                                                   image: imageProvider,
//                                                   fit: BoxFit.cover),
//                                             ),
//                                           ),
//                                           placeholder: (context, url) =>
//                                               const Center(
//                                                   child:
//                                                       CircularProgressIndicator
//                                                           .adaptive(
//                                             valueColor:
//                                                 AlwaysStoppedAnimation(
//                                                     Color(COLOR_PRIMARY)),
//                                           )),
//                                           errorWidget: (context, url,
//                                                   error) =>
//                                               ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           20),
//                                                   child: Image.asset(
//                                                     "assets/icons/google.png",
//                                                     fit: BoxFit.cover,
//                                                     cacheHeight: 40,
//                                                     cacheWidth: 40,
//                                                   )),
//                                           fit: BoxFit.cover,
//                                         ),
//                                         Container(
//                                             padding: EdgeInsets.only(top: 20),
//                                             child: Column(
//                                               children: [
//                                                 Text(
//                                                   data.lastname +
//                                                       ' ' +
//                                                       data.lastname,
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Text(
//                                                   '#' + 'Departement',
//                                                   style: TextStyle(
//                                                       color: Colors
//                                                           .lightBlueAccent),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Icon(
//                                                       Icons
//                                                           .location_on_outlined,
//                                                       color: Colors.white,
//                                                     ),
//                                                     Text(
//                                                       data.address,
//                                                       style: TextStyle(
//                                                           color:
//                                                               Colors.white),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 InkWell(
//                                                   child: Container(
//                                                       padding: EdgeInsets
//                                                           .symmetric(
//                                                               horizontal: 25,
//                                                               vertical: 5),
//                                                       margin: EdgeInsets.only(
//                                                           top: 30),
//                                                       decoration: BoxDecoration(
//                                                           color: Colors.blue,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       20)),
//                                                       child: Text(
//                                                         'Profile',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       )),
//                                                   onTap: () {},
//                                                 )
//                                               ],
//                                             ))
//                                       ],
//                                     ),
//                                   );
//                                 });
//                           } else {
//                             return Text('No Doctors'.tr());
//                           }
//                         }),
//                     // Container(
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.deepPurpleAccent,
//                     //     // borderRadius: BorderRadius.circular(20)
//                     //   ),
//                     //   // border: Border.all(color: primaryColor, width: 1)),
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //     children: [
//                     //       Image.asset("assets/icons/doctor.png"),
//                     //       Container(
//                     //           padding: EdgeInsets.only(top: 20),
//                     //           child: Column(
//                     //             children: [
//                     //               Text(
//                     //                 'Abdelkhalek Haddany',
//                     //                 style: TextStyle(color: Colors.white),
//                     //               ),
//                     //               SizedBox(
//                     //                 height: 5,
//                     //               ),
//                     //               Text(
//                     //                 '#' + 'Departement',
//                     //                 style: TextStyle(
//                     //                     color: Colors.lightBlueAccent),
//                     //               ),
//                     //               SizedBox(
//                     //                 height: 5,
//                     //               ),
//                     //               Row(
//                     //                 children: [
//                     //                   Icon(
//                     //                     Icons.location_on_outlined,
//                     //                     color: Colors.white,
//                     //                   ),
//                     //                   Text(
//                     //                     'Casablanca',
//                     //                     style: TextStyle(color: Colors.white),
//                     //                   )
//                     //                 ],
//                     //               ),
//                     //               InkWell(
//                     //                 child: Container(
//                     //                     padding: EdgeInsets.symmetric(
//                     //                         horizontal: 25, vertical: 5),
//                     //                     margin: EdgeInsets.only(top: 30),
//                     //                     decoration: BoxDecoration(
//                     //                         color: Colors.blue,
//                     //                         borderRadius:
//                     //                             BorderRadius.circular(20)),
//                     //                     child: Text(
//                     //                       'Profile',
//                     //                       style:
//                     //                           TextStyle(color: Colors.white),
//                     //                     )),
//                     //                 onTap: () {},
//                     //               )
//                     //             ],
//                     //           ))
//                     //     ],
//                     //   ),
//                     // )
//                   ],
//                 )
//               ])));
// }
// }

class DepartmentSection extends StatelessWidget {
  const DepartmentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final fireStoreUtils = FireStoreUtils();
    Future<List<DepartmentModel>>? lstDepartments;
    lstDepartments = fireStoreUtils.getAllDepartments();
    return Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        height: 100,
        width: double.infinity,
        child: FutureBuilder<List<DepartmentModel>>(
            future: lstDepartments,
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                  ),
                );
              }
              if (snapshot.hasData || (snapshot.data?.isNotEmpty ?? false)) {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount:
                        snapshot.data!.length > 15 ? 15 : snapshot.data!.length,
                    itemBuilder: (_, i) {
                      DepartmentModel data = snapshot.data![i];
                      return DepartmentCard(
                          image: data.thumbnail, title: data.title);
                    });
              } else {
                return Text('No Departments'.tr());
              }
            })

        // DepartmentCard(
        //     image: 'assets/icons/departments/sport.svg', title: 'Sport'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/skin.svg', title: 'Skin'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/diabetes.svg', title: 'Diabet'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/teeth.svg', title: 'Teeth'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/eyes.svg', title: 'Eyes'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/pregnant.svg', title: 'Pegnants'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/baby.svg', title: 'Babys'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/scissors.svg', title: 'Surgery'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/heart.svg', title: 'Heart'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/psychologist.svg', title: 'Psychologist'),
        // DepartmentCard(
        //     image: 'assets/icons/departments/all.svg', title: 'All Departments'),

        );
  }
}

class DepartmentCard extends StatelessWidget {
  final String image;
  final String title;

  const DepartmentCard({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SvgPicture.network(
            //   image,
            //   height: 30,
            //   width: 30,
            // ),
            CachedNetworkImage(
              imageUrl: getImageVAlidUrl(image),
              height: 50,
              width: 50,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
              )),
              errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/icons/google.png",
                    fit: BoxFit.cover,
                    cacheHeight: 40,
                    cacheWidth: 40,
                  )),
              fit: BoxFit.cover,
            ),
            Center(child: Text(title))
          ],
        ));
  }
}

class PostsSection extends StatelessWidget {
  const PostsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireStoreUtils = FireStoreUtils();
    Future<List<PostModel>>? lstPost;
    lstPost = fireStoreUtils.getAllPosts();
    final orientation = MediaQuery.of(context).orientation;
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
                                    builder: (context, snapshot) => snapshot
                                            .hasData
                                        ? InkWell(
                                            child: Text(snapshot.data!.title),
                                            onTap: () {
                                              // switch to doctor profile
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DepartmentScreen(
                                                            snapshot.data!.id)),
                                              );
                                            })
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
            InkWell(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                  CachedNetworkImage(
                    imageUrl: post.thumbnail,
                    height: 220,
                    width: double.infinity,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
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
                    post.title.length > 100
                        ? post.title.substring(0, 100) + '...'
                        : post.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    post.content.length > 200
                        ? post.content.substring(0, 200) + '...'
                        : post.content,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
                onTap: () {
                  // switch to doctor profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewBlogScreen(
                              blogModel: post,
                            )),
                  );
                }),
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
