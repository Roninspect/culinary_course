import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/core/constants/tab_widgets.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/cart/pages/cart_page.dart';
import 'package:culinary_course/src/features/home/pages/homepage.dart';
import 'package:culinary_course/src/features/home/provider/nav_provider.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(navNotifierProvider);
    final user = ref.watch(userDataProvider.select((value) => value.cart));

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              MaterialCommunityIcons.chef_hat,
              color: primaryColor,
              size: 30,
            ),
            Text(
              "  Culinary Course ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => context.pushNamed(AppRoutes.wishlist.name),
              icon: const Icon(Icons.abc))
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: tabWidgets,
        onPageChanged: (value) =>
            ref.read(navNotifierProvider.notifier).setIndex(index: value),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: index,
          onTap: (selectedPageIndex) {
            ref
                .read(navNotifierProvider.notifier)
                .setIndex(index: selectedPageIndex);
            _pageController.jumpToPage(selectedPageIndex);
          },
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Search"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.play_circle), label: "My Courses"),
            BottomNavigationBarItem(
                icon: Badge(
                    backgroundColor: Colors.redAccent,
                    label: Text(user.length.toString()),
                    child: const Icon(Icons.shopping_cart)),
                label: "Cart"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Account"),
          ]),
    );
  }
}
