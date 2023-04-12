import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  RxString img = "".obs;
  RxString url = "".obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;



  clearData() {
    emailController.clear();
    nameController.clear();
    phoneNumberController.clear();
    img.value = "";
  }

// ImagePicker pick = ImagePicker();
// RxString imagePath = ''.obs;
// RxString imageName = ''.obs;
// XFile? image;
// RxBool isFileGet = false.obs;
//
// ///ImagePicker
// getFromGallery() async {
//   try {
//     isFileGet.value = false;
//
//     var image = await pick.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       image = image;
//
//       log("IMAge---->${image}");
//       //for single image
//       imageName.value = image.name;
//       imagePath.value = image.path;
//       log("imagePickerPath--------------${imagePath.value}");
//       log("imagePickerName--------------${imageName.value}");
//       log("----XFilePath----------${image.path}");
//       update();
//
//       log("IMAgf55e---->${image.toString()}");
//       isFileGet.value = true;
//     } else {
//       log('No image selected.');
//       isFileGet.value = false;
//     }
//   } catch (e) {
//     //isFileGet.value = false;
//     log("imagePickerError--->${e.toString()}");
//   }
// }
}
