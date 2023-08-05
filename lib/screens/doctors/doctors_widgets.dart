import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/constants.dart';
import 'package:hc_morocco_doctors/screens/profile/doctor_profile_screen.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import '../../models/DoctorModel.dart';

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireStoreUtils = FireStoreUtils();
    Future<List<DoctorModel>>? lstDoctors;
    lstDoctors = fireStoreUtils.getAllDoctors();
    return FutureBuilder<List<DoctorModel>>(
                  future: lstDoctors,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                        ),
                      );
                    }
                    if (snapshot.hasData ||
                        (snapshot.data?.isNotEmpty ?? false)) {
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length > 5
                              ? 5
                              : snapshot.data!.length,
                          itemBuilder: (_, i) {
                            DoctorModel data = snapshot.data![i];
                            return DoctorCard(
                              id: data.id,
                              avatar: data.avatar,
                              name: data.firstname + ' ' + data.lastname,
                              city: (data.city!=null) ? data.city : '' ,
                              department: (data.department!=null) ? data.department: '',
                            );
                          });
                    }
                    return Container(
                        child: Text(
                      "No Doctors",
                      style: TextStyle(color: Colors.black54),
                    ));
                  },

        // FutureBuilder<List<DoctorModel>>(
        //           future: lstDoctors,
        //           initialData: [],
        //           builder: (context, snapshot) {
        //             if (snapshot.connectionState == ConnectionState.waiting) {
        //               return const Center(
        //                 child: CircularProgressIndicator.adaptive(
        //                   valueColor:
        //                       AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
        //                 ),
        //               );
        //             }
        //             if (snapshot.hasData ||
        //                 (snapshot.data?.isNotEmpty ?? false)) {
        //               return ListView.builder(
        //                   shrinkWrap: true,
        //                   scrollDirection: Axis.horizontal,
        //                   physics: const ClampingScrollPhysics(),
        //                   itemCount: snapshot.data!.length > 5
        //                       ? 5
        //                       : snapshot.data!.length,
        //                   itemBuilder: (_, i) {
        //                     DoctorModel data = snapshot.data![i];
        //                     return DoctorCard(
        //                       avatar: data.avatar,
        //                       name: data.firstname + ' ' + data.lastname,
        //                       city: data.city,
        //                       department: data.department,
        //                     );
        //                   });
        //             }
        //             return Container(
        //                 child: Text(
        //               "No Doctors",
        //               style: TextStyle(color: Colors.black54),
        //             ));
        //           }),
              // DoctorCard(
              // avatar: 'assets/icons/departments/heart.svg', name: 'Heart', city: 'casablanca', department: 'hello world',),
            );
  }
}

class DoctorCard extends StatelessWidget {
  final String id;
  final String avatar;
  final String name;
  final String city;
  final String department;

  const DoctorCard(
      {Key? key,
        required this.id,
        required this.avatar,
        required this.name,
        required this.city,
        required this.department})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.grey)),
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: getImageVAlidUrl(avatar),
              height: 250,
              width: MediaQuery.of(context).size.width,
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
            SizedBox(
              height: 10,
            ),
            InkWell(
            child:
            Row(
              children: [
                Icon(Icons.person),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
              onTap: ()=> {
              print(id),
               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                 return DoctorProfile(id);
               },
    ))
                }
            ),
            Row(children: [
              Icon(
                Icons.tag,
              ),
              Text(
                department,
              ),
            ]),
            Row(children: [
              Icon(
                Icons.location_on_outlined,
              ),
              Text(
                city,
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 1,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Text(
                        '+ Follow',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Text(
                        'Show more',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {},
                    )
                  ],
                ))
          ],
        ));
  }
}
