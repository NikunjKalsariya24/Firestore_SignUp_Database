import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_signup_form/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ViewData extends StatelessWidget {
  ViewData({Key? key}) : super(key: key);
  SignUpController signUpController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: signUpController.firestore.collection('data').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Row(
              children: [
                data['image'] == ""
                    ? Image.asset(
                        "asset/image/Vodafone.png",
                        height: 10.h,
                        width: 10.h,
                      )
                    : Image.network(
                        "${data['image']}",
                        height: 10.h,
                        width: 10.w,
                      ),
                Column(
                  children: [
                    Text("${data['full_name']}"),
                    Text("${data['email']}"),
                    Text("${data['phone Number']}"),
                  ],
                ),
              ],
            );
          }).toList(),
        );
      },
    ));
  }
}
