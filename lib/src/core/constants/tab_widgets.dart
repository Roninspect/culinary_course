import 'package:culinary_course/src/features/cart/pages/cart_page.dart';
import 'package:culinary_course/src/features/enrolled-course/pages/my_course_page.dart';
import 'package:culinary_course/src/features/home/pages/homepage.dart';
import 'package:culinary_course/src/features/profile/pages/profile_page.dart';
import 'package:culinary_course/src/features/search/pages/search_page.dart';
import 'package:flutter/material.dart';

List<Widget> tabWidgets = const [
  HomePage(),
  SearchPage(),
  MyCoursePage(),
  CartPage(),
  ProfilePage(),
];
