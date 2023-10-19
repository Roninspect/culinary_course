import 'package:culinary_course/src/features/cart/pages/cart_page.dart';
import 'package:culinary_course/src/features/home/pages/homepage.dart';
import 'package:culinary_course/src/features/search/pages/search_page.dart';
import 'package:flutter/material.dart';

List<Widget> tabWidgets = const[
   HomePage(),
   SearchPage(),
   HomePage(),
   CartPage(),
   HomePage(),
];
