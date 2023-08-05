import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/models/DepartmentModel.dart';
import 'package:hc_morocco_doctors/models/PostModel.dart';
import 'package:hc_morocco_doctors/models/QuestionModel.dart';
import 'package:hc_morocco_doctors/screens/blog/profile/components/profile_field.dart';
import 'package:hc_morocco_doctors/screens/home/DashboardScreen.dart';
import 'package:hc_morocco_doctors/screens/profile/edit_profile_screen.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'package:hc_morocco_doctors/services/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  DepartmentModel? selectedDepartment;
  var selectedDepartmentName;
  var departmentID;
  List<DepartmentModel>? departments;
  late Future<List<DepartmentModel>> department;
  List<DepartmentModel> departmentLst = [];
  FireStoreUtils  fireStoreUtils =  FireStoreUtils();

  final ImagePicker _imagePicker = ImagePicker();
  List<dynamic> _mediaFiles = [];
  List<String> selected = [];

  Map<dynamic, dynamic> selecte = {};
  Map<String, dynamic> filters = {};

  final titleController = TextEditingController();
  final contentController = TextEditingController();


  @override
  void initState() {
    super.initState();
    department = fireStoreUtils.getAllDepartments();
    department.then((value) {
      setState(() {
        departmentLst.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white54,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text('Add Your Question', style: TextStyle(color: Color(0xff191A1C)),),
        ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all(width: 2,color:Color.fromRGBO(165, 117, 255, 1) ),
                borderRadius: BorderRadius.circular(20)),
                child:
              _mediaFiles.isEmpty == true
                  ? InkWell(
                  child: const Icon(Icons.add_photo_alternate_outlined, color: Color.fromRGBO(165, 117, 255, 1), size: 60,),
                  onTap: () {
                    _pickImage();
                     }): _imageBuilder(_mediaFiles.first),
                  ),
              const SizedBox(height: 24),

              Container(
                height: 60,
                child: DropdownButtonFormField<DepartmentModel>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),

                      // filled: true,
                      //fillColor: Colors.blueAccent,
                    ),
                    //dropdownColor: Colors.blueAccent,
                    value: selectedDepartment,
                    onChanged: (value) {
                      setState(() {
                        selectedDepartment = value;
                        departmentID = value!.id;
                        selectedDepartmentName = value.title;
                      });
                    },
                    hint: Text('Select Question Department'.toString()),
                    items: departmentLst.map((DepartmentModel item) {
                      return DropdownMenuItem<DepartmentModel>(
                        child: Text(item.title),
                        value: item,
                      );
                    }).toList()),
              ),

              ProfileField(
                controller: titleController,
                labelText: 'Title',
                hintText: 'Provide title of your blog',
                maxLength: 60,
                iconData: Icons.title,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ProfileField(
                controller: contentController,
                labelText: 'Description',
                hintText: 'Provide description of your blog',
                iconData: Icons.description,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description can\'t be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
                  ],
                )
                //    Container(
                //   alignment: Alignment.center,
                //   child: CircularProgressIndicator.adaptive(
                //     valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                //   ),
                // )
                //     : buildrow(vendorData!)
      )
    ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Color.fromRGBO(165, 117, 255, 1),
                  ),
                ),
                primary: Color.fromRGBO(165, 117, 255, 1),
              ),
              onPressed: () {
                validate();
              },
              child: Text(
                'Create'.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode(context) ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validate() async {
      if (_mediaFiles.isEmpty) {
        showimgAlertDialog(context, 'Please add Image'.toString(), 'Add Image to continue'.toString(), true);
      } else if (titleController.text.isEmpty) {
        showimgAlertDialog(context, 'Please enter valid title'.toString(), 'Add title no. to continue'.toString(), true);
      }
      else if (contentController.text.isEmpty) {
        showimgAlertDialog(context, 'Please enter content title'.toString(), 'Add content no. to continue'.toString(), true);
      } else{
        var uuid = Uuid();
        final image_url = await FireStoreUtils.uploadPostThumbnailToFireStorage(_mediaFiles.first,uuid.v1());
        var _id = await FireStoreUtils.getUserID();
        QuestionModel question = QuestionModel(id: uuid.v1(),
            title: titleController.text,
            thumbnail: image_url,
            department_id: departmentID,
            status: "accepted",
            content: contentController.text,
            user_id: _id.toString());
        await FireStoreUtils.createQuestion(question);
        titleController.text='';
        contentController.text='';
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashboardScreen()));
      }
  }

  _pickImage() {
    final action = CupertinoActionSheet(
      message: Text(
        'Add Picture',
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Choose image from gallery'),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              // _mediaFiles.removeLast();
              _mediaFiles.add(File(image.path));
              // _mediaFiles.add(null);
              setState(() {});
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Take a picture'),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
            if (image != null) {
              // _mediaFiles.removeLast();
              _mediaFiles.add(File(image.path));
              // _mediaFiles.add(null);
              setState(() {});
            }
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'.toString()),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  _imageBuilder(dynamic image) {
    // bool isLastItem = image == null;
    return GestureDetector(
      onTap: () {
        _viewOrDeleteImage(image);
      },
      child: Container(
        width: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image is File
                ? Image.file(
              image,
              fit: BoxFit.cover,
            )
                : displayImage(image),
          ),
        ),
      ),
    );
  }

  _viewOrDeleteImage(dynamic image) {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            // _mediaFiles.removeLast();
            if (image is File) {
              _mediaFiles.removeWhere((value) => value is File && value.path == image.path);
            } else {
              _mediaFiles.removeWhere((value) => value is String && value == image);
            }
            // _mediaFiles.add(null);
            setState(() {});
          },
          child: Text('Remove picture'.toString()),
          isDestructiveAction: true,
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            // push(context, image is File ? FullScreenImageViewer(imageFile: image) : FullScreenImageViewer(imageUrl: image));
          },
          isDefaultAction: true,
          child: Text('View picture'.toString()),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel'.toString()),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return false;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return regExp.hasMatch(phoneNo);
  }

  showimgAlertDialog(BuildContext context, String title, String content, bool addOkButton) {
    Widget? okButton;
    if (addOkButton) {
      okButton = TextButton(
        child: Text('OK'.toString()),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    if (Platform.isIOS) {
      CupertinoAlertDialog alert = CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [if (okButton != null) okButton],
      );
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else {
      AlertDialog alert = AlertDialog(title: Text(title), content: Text(content), actions: [if (okButton != null) okButton]);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  showAlertDialog1(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK".toString()),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title".toString()),
      content: Text("This is my message.".toString()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

