import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/profile/widgets/name_avatar.dart';
import 'package:culinary_course/src/features/wishlist/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);

    String getLength() {
      if (user.wishlist.length < 10 && user.wishlist.isNotEmpty) {
        return "0${user.wishlist.length}";
      } else {
        return "${user.wishlist.length}";
      }
    }

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.more_horiz, size: 30, color: Colors.black))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            //** name and proflie */
            const NameAvatarWidget(),
            const SizedBox(height: 10),
            //** inforamtion tabbar */
            TabBar(
              // dividerColor: Colors.transparent,
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              splashFactory: NoSplash.splashFactory,
              tabAlignment: TabAlignment.center,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                const Tab(text: "My Courses"),
                Tab(text: "Wishlist (${getLength()})"),
                const Tab(text: "Subscription"),
              ],
            ),
            const Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                  Center(
                    child: Text("My courses"),
                  ),
                  WishlistPage(),
                  Center(
                    child: Text("Subscription"),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
