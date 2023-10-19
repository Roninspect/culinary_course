import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/core/widgets/custom_button.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/cart/controller/cart_controller.dart';
import 'package:culinary_course/src/features/courses/widgets/rating_bar.dart';
import 'package:culinary_course/src/features/courses/widgets/video_player.dart';

import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:readmore/readmore.dart';

class CourseDetailsPage extends ConsumerStatefulWidget {
  final Course course;
  const CourseDetailsPage({
    super.key,
    required this.course,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseDetailsPageState();
}

class _CourseDetailsPageState extends ConsumerState<CourseDetailsPage> {
  bool isVideoInitialized = false;

  @override
  Widget build(BuildContext context) {
    final Course course = widget.course;
    bool isLoading = ref.watch(cartControllerProvider);
    final user = ref.watch(userDataProvider.select((value) => value.cart));

    Text getTotalLessons() {
      if (course.totalContentCount < 10) {
        return Text(
          "0${course.totalContentCount} Lessons",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        );
      }

      return Text(
        "${course.totalContentCount} Lessons",
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,

      //   leading: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       CircleAvatar(
      //         radius: 20,
      //         backgroundColor: Color.fromARGB(78, 182, 182, 182),
      //         child: GestureDetector(
      //           onTap: () => context.pop(),
      //           child: Icon(
      //             Icons.arrow_back_ios_outlined,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* intro video player
              CourseVideoPlayer(course: course),

              const SizedBox(height: 10),
              //* title of the course
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 35,
                            )),
                      ],
                    ),

                    Row(
                      children: [
                        //* average reviews
                        const AvgRatingbar(),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.circle,
                            size: 8,
                          ),
                        ),

                        //* total lessons
                        Row(
                          children: [
                            const Icon(Icons.menu_book, color: primaryColor),
                            const SizedBox(width: 5),
                            getTotalLessons(),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 10),

                    //* description

                    ReadMoreText(
                      course.description,
                      trimLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      lessStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    const SizedBox(height: 20),
                    //*   Instructor Information   */
                    Row(
                      children: [
                        //* instructor profile image
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                            course.instructor.profile,
                            cacheKey: course.instructor.id,
                          ),
                        ),
                        const SizedBox(width: 10),
                        //* name and worksAt

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.instructor.instructorName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              course.instructor.worksAt,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //* Course curriculum list
                    const Text(
                      "Course curriculum",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: course.curriculum.length,
                itemBuilder: (context, index) {
                  final singleCurriculum = course.curriculum[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      collapsedIconColor: primaryColor,
                      iconColor: primaryColor,
                      backgroundColor: const Color(0xffEBE3E0),
                      collapsedBackgroundColor: const Color(0xffEBE3E0),
                      title: Text(singleCurriculum.title),
                      children: singleCurriculum.content
                          .map((e) => Column(
                                children: [
                                  ListTile(
                                    title: Text(e.title),
                                  ),
                                  const Divider()
                                ],
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          children: [
            CustomButton(
                height: 50,
                width: 150,
                text: "Enroll Now \$120",
                onpressed: () {},
                backgroundColor: primaryColor),
            const SizedBox(width: 10),
            Row(
              children: [
                user.any((element) => element.id == course.id)
                    ? CustomButton(
                        height: 50,
                        width: 150,
                        text: "Added To Cart",
                        onpressed: () {},
                        backgroundColor: primaryColor)
                    : isLoading
                        ? CustomButton(
                            height: 50,
                            width: 150,
                            icon: Icons.shopping_cart_sharp,
                            text: "Adding...",
                            onpressed: () {},
                            backgroundColor: primaryColor)
                        : CustomButton(
                            height: 50,
                            width: 150,
                            icon: Icons.shopping_cart_sharp,
                            text: "Add to Cart",
                            onpressed: () {
                              ref
                                  .read(cartControllerProvider.notifier)
                                  .addToCart(
                                      courseId: course.id,
                                      context: context,
                                      course: course,
                                      ref: ref);
                            },
                            backgroundColor: primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
