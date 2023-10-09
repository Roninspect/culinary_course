import 'package:culinary_course/src/core/constants/tab_widgets.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/home/provider/nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
    final index = ref.watch(navNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Culinary Course",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: tabWidgets[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          currentIndex: index,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) =>
              ref.read(navNotifierProvider.notifier).setIndex(index: value),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          ]),
    );
  }
}
