import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/enrolled-course/providers/curriculum_provider.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyCoursePage extends ConsumerWidget {
  const MyCoursePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCourses =
        ref.watch(userDataProvider.select((value) => value.enrolled));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Courses"),
      ),
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
                      onTap: () {
                        ref
                            .read(curriculumNotifierProvider.notifier)
                            .selectCurriculum(
                                selectedCurriculum: myCourse.course.curriculum);
                        context.pushNamed(AppRoutes.enrolledCourse.name,
                            extra: myCourse.course,
                            pathParameters: {'id': myCourse.id});
                      },
                      tileColor: const Color.fromARGB(255, 231, 229, 229),
                      contentPadding: EdgeInsets.zero,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
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
