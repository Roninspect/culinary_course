import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCourseProfilePage extends ConsumerWidget {
  const MyCourseProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCourses =
        ref.watch(userDataProvider.select((value) => value.enrolled));
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: myCourses.length,
              itemBuilder: (context, index) {
                final myCourse = myCourses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    child: ListTile(
                      onTap: () {},
                      tileColor: const Color.fromARGB(255, 231, 229, 229),
                      contentPadding: EdgeInsets.zero,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              cacheKey: myCourse.id,
                              imageUrl: myCourse.course.thumbnail,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      title: Text(myCourse.course.title,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(myCourse.course.instructor.instructorName,
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
