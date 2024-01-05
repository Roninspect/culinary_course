import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/core/enums/watch_enum.dart';
import 'package:culinary_course/src/features/enrolled-course/providers/content_index_provider.dart';
import 'package:culinary_course/src/features/enrolled-course/providers/content_provider.dart';
import 'package:culinary_course/src/features/enrolled-course/widgets/lesson_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:culinary_course/src/features/enrolled-course/providers/curriculum_provider.dart';
import 'package:culinary_course/src/models/course.dart';

class CoursePlaylistPage extends ConsumerWidget {
  final Course course;
  const CoursePlaylistPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    //* function returns which checkbox IconButton to show
    IconButton watchingState({required String state}) {
      if (state == WatchState.NOTWATCHED.name) {
        return IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_box_outline_blank,
            ));
      } else if (state == WatchState.WATCHED.name) {
        return IconButton(onPressed: () {}, icon: const Icon(Icons.check_box));
      } else {
        return IconButton(
            onPressed: () {}, icon: const Icon(Icons.indeterminate_check_box));
      }
    }

    final selectedCurriculum = ref.watch(curriculumNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PlaylistVideoPlayer(),
              const Text(
                "Course Content",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: selectedCurriculum.length,
                itemBuilder: (context, index) {
                  final singleCurriculum = selectedCurriculum[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                        initiallyExpanded: true,
                        collapsedIconColor: primaryColor,
                        iconColor: primaryColor,
                        backgroundColor: const Color(0xffEBE3E0),
                        collapsedBackgroundColor: const Color(0xffEBE3E0),
                        title: Text(singleCurriculum.title),
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: singleCurriculum.content.length,
                            itemBuilder: (context, index) {
                              final singleContent =
                                  singleCurriculum.content[index];

                              return ListTile(
                                onTap: () {
                                  ref
                                      .read(
                                          contentIndexNotifierProvider.notifier)
                                      .selectContent(selectedContent: index);
                                  // context.pushNamed(AppRoutes.lessons.name,
                                  //     pathParameters: {
                                  //       "id": course.id,
                                  //       "lessonId": singleCurriculum.id
                                  //     },
                                  //     extra: singleCurriculum);
                                },
                                contentPadding: EdgeInsets.zero,
                                leading: watchingState(
                                    state: singleContent.isWatched),
                                title: Text(
                                  singleContent.title,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          )
                        ]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
