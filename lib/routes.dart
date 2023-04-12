import 'package:firebase_signup_form/login/getstarted_page.dart';
import 'package:firebase_signup_form/login/view_data.dart';
import 'package:get/get.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;
  static const String getStartedPage = '/GetStartedPage';
  static const String viewData = '/ViewData';
  static List<GetPage<dynamic>> pages = [
  GetPage<dynamic>(
  name: getStartedPage,
  page: () => GetStartedPage(),
  transition: defaultTransition,
  ),
    GetPage<dynamic>(
  name: viewData,
  page: () => ViewData(),
  transition: defaultTransition,
  ),




  ];
}