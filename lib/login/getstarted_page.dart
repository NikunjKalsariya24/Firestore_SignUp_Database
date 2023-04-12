import 'dart:developer';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_signup_form/controller/signup_controller.dart';
import 'package:firebase_signup_form/login/view_data.dart';
import 'package:firebase_signup_form/login/view_data.dart';
import 'package:firebase_signup_form/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_string.dart';
import 'view_data.dart';
import 'view_data.dart';

class GetStartedPage extends StatefulWidget {
  GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  SignUpController signUpController = Get.put(SignUpController());
  String img = "";
  var uuid = const Uuid();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 6.h,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 6.h,
              margin: const EdgeInsets.only(top: 10, right: 20, left: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(child: Text("Add Product Images")),
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 6.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            ElevatedButton.icon(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final ImagePicker picker = ImagePicker();

                                  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                                  signUpController.img.value = photo?.path ?? "";
                                  // setState(() {
                                  //   img = photo!.path;
                                  // });
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text("Camera")),
                            ElevatedButton.icon(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? images = await picker.pickImage(source: ImageSource.gallery);
                                  print("photo:- ${images?.path}");

                                  signUpController.img.value = images?.path ?? "";
                                  print("abc==================${signUpController.img.value}");
                                },
                                icon: const Icon(Icons.browse_gallery),
                                label: const Text("Gallary")),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add)),
            ),
            Obx(
              () {
                print("Image===============${signUpController.img.value}");
                return signUpController.img.value == ""
                    ? Image.asset("asset/image/Vodafone.png")
                    : Image.file(
                        File(signUpController.img.value),
                        height: 100,
                        width: 100,
                      );
                //Image.asset(signUpController.img.value == "" ? "asset/image/Vodafone.png" : signUpController.img.value);
                //   return CircleAvatar(
                //   radius: 6.h,
                //   backgroundImage: AssetImage(signUpController.img.value == "" ? "asset/image/Vodafone.png" : signUpController.img.value),
                // );
              },
            ),
            SizedBox(
              height: 6.h,
            ),
            TextFormField(
              controller: signUpController.nameController,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: AppString.enterYourName),
            ),
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              controller: signUpController.emailController,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: AppString.enterYourEmailId),
            ),
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              controller: signUpController.phoneNumberController,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: AppString.enterYourPhoneNumber),
            ),
            SizedBox(
              height: 3.h,
            ),
            ElevatedButton(
                onPressed: () async {
         await forStorage();


         await  signUpController.firestore.collection('data').add({
                    'image': signUpController.url.value.toString(),
                    'full_name': signUpController.nameController.text.toString(), // John Doe
                    'email': signUpController.emailController.text.toString(), // Joh // Stokes and Sons
                    'phone Number': signUpController.phoneNumberController.text.toString(), // Joh
                  });


                  Get.toNamed(Routes.viewData,);
         signUpController.clearData();


                  // Future<void> addUser() {
                  //   return users
                  //       .add({
                  //     'uuid':uuid.v1(),
                  //         'full_name': signUpController.nameController, // John Doe
                  //         'email': signUpController.emailController, // Stokes and Sons
                  //         'phone Number': signUpController.phoneNumberController, // 42
                  //         //'image': signUpController.img, // 42
                  //       })
                  //       .then((value) => print("User Added"))
                  //       .catchError((error) => print("Failed to add user: $error"));
                  // }
                },
                child: const Text(AppString.submit)),
          ],
        ),
      ),
    );
  }

  Future<void> addStudent() {
    return users
        .add({
          'full_name': signUpController.nameController, // John Doe
          'email': signUpController.emailController, // Stokes and Sons
          'phone Number': signUpController.phoneNumberController, // 42
        })
        .then((value) => print("Student data Added"))
        .catchError((error) => print("Student couldn't be added."));
  }

  Future<void> forStorage() async {
    try {
      FirebaseStorage _storage = FirebaseStorage.instance;
      print("value================${signUpController.img.value.toString()}");
      List<String>ll = signUpController.img.value.split('/');
      print("list=========$ll");
      final storageRef = FirebaseStorage.instance.ref();
      final spaceRef = storageRef
          .child("images/images${{DateTime.now().millisecondsSinceEpoch}}.jpg");
      await spaceRef.putFile(File(signUpController.img.value));
      spaceRef.getDownloadURL().then((value) async {
        signUpController.url.value=value;
        print("file===============${value}");
      }
      );
    //   Reference reference = _storage.ref().child("images/");
    //
    //   //Upload the file to firebase
    //   log("signUpController.img.value :${signUpController.img.value}");
    //   UploadTask  uploadTask = reference.putFile(File(signUpController.img.value));
    //
    //   // Waits till the file is uploaded then stores the download url
    //   final location = await uploadTask.then((p0) {
    //     print("${p0.state}");
    //     return p0.state;
    //   });
    //   log("location :${location}");
    // }
    }
    catch(e,st){

     log("log+++++++++++++++$e $st");

    }
  }

}
