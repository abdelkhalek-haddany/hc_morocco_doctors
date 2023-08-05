import 'package:hc_morocco_doctors/screens/blog/profile/components/profile_field.dart';
import 'package:hc_morocco_doctors/screens/blog/profile/controllers/create_profile_controller.dart';
import 'package:hc_morocco_doctors/screens/blog/widgets/image_bottom_sheet.dart';
import 'package:hc_morocco_doctors/screens/blog/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hc_morocco_doctors/themes/style.dart';

import '../../../widgets/app_button.dart';

class CreateProfileScreen extends GetView<CreateProfileController> {
  const CreateProfileScreen({Key? key}) : super(key: key);
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    Get.put(CreateProfileController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: [
              profileImage(context),
              const SizedBox(height: 20),
              ProfileField(
                controller: controller.nameController,
                labelText: 'Name',
                hintText: 'Your Full Name',
                iconData: Icons.person,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Name can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ProfileField(
                controller: controller.professionController,
                labelText: 'Profession',
                hintText: 'Software Engineer',
                iconData: Icons.badge,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Profession can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    underline: Container(
                      height: 0,
                    ),
                    style: const TextStyle(color: Colors.black),

                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      dropdownValue = value!;
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                      );
                    }).toList(),
                  )
              ),
              const SizedBox(height: 20),
              ProfileField(
                controller: controller.dobController,
                labelText: 'Date of Birth',
                hintText: '23/02/2000',
                iconData: Icons.date_range,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'DOB can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ProfileField(
                controller: controller.titleController,
                labelText: 'Title',
                hintText: 'Flutter Developer',
                iconData: Icons.title,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Title can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              aboutField(),
              const SizedBox(height: 20),
              Center(
                child: Obx(
                      () =>
                  controller.loading.value
                      ? circularProgress()
                      : AppButton(
                    label: 'Submit',
                    onPressed: () => controller.saveProfile(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget aboutField() {
    return TextFormField(
      controller: controller.aboutController,
      maxLines: 4,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value
            .trim()
            .isEmpty) {
          return 'About can\'t be empty';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff00A86B),
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff00A86B),
              width: 2,
            )),
        labelText: 'About',
        hintText: 'I am Flutter Developer',
        labelStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _getImage() {
    return controller.imageFile.value == null
        ? const AssetImage('assets/icons/doctor.png')
        : FileImage(controller.imageFile.value!);
  }

  Widget profileImage(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        Obx(
              () =>
              CircleAvatar(
                radius: 80.0,
                backgroundImage: _getImage(),
              ),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) {
                    return ImageBottomSheet(
                      title: 'Upload Profile Image',
                      cameraPressed: () =>
                          controller.pickImage(ImageSource.camera),
                      galleryPressed: () =>
                          controller.pickImage(ImageSource.gallery),
                    );
                  }),
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: primaryColor),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                  ),
                  child: Material(
                      color: Colors.transparent,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Material(
                              color: Colors.transparent,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              )))))),
        ),
      ]),
    );
  }
}
