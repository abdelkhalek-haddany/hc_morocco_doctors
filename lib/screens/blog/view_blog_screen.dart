import 'package:cached_network_image/cached_network_image.dart';
import 'package:hc_morocco_doctors/constants.dart';
import 'package:hc_morocco_doctors/models/PostModel.dart';
import 'package:hc_morocco_doctors/screens/blog/models/blog_model.dart';
import 'package:hc_morocco_doctors/screens/blog/services/http_service.dart';
import 'package:flutter/material.dart';

class ViewBlogScreen extends StatelessWidget {
  final PostModel blogModel;

  const ViewBlogScreen({Key? key, required this.blogModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:SafeArea(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: getImageVAlidUrl(blogModel.thumbnail),
                height: 230,
                width: double.infinity,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                )),
                errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    child: Image.asset(
                      "assets/icons/google.png",
                      fit: BoxFit.cover,
                      cacheHeight: 230,
                    )),
                fit: BoxFit.cover,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  blogModel.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    blogModel.content,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
