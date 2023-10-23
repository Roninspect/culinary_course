import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Course> wishList =
        ref.watch(userDataProvider.select((value) => value.wishlist));

    bool isLoading = ref.watch(wishControllerProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: wishList.isEmpty
            ? const Center(
                child: Text("no item in wishlist"),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: wishList.length,
                          itemBuilder: (context, index) {
                            final wishlist = wishList[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                child: ListTile(
                                  onTap: () => context.pushNamed(
                                      AppRoutes.course.name,
                                      pathParameters: {'id': wishlist.id},
                                      extra: wishlist),
                                  tileColor:
                                      const Color.fromARGB(255, 231, 229, 229),
                                  contentPadding: EdgeInsets.zero,
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 10,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: wishlist.thumbnail,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(wishlist.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(
                                      wishlist.instructor.instructorName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "\$${wishlist.price}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref
                                              .watch(wishControllerProvider
                                                  .notifier)
                                              .removeFromCart(
                                                  courseId: wishlist.id,
                                                  context: context,
                                                  course: wishlist,
                                                  ref: ref);
                                        },
                                        icon: const Icon(Icons.close_rounded,
                                            size: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
      ),
    );
  }
}
