import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/home/controller/home_controller.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class FetauredCard extends ConsumerWidget {
  const FetauredCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFeaturedProvider(context: context)).when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Featured",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                GestureDetector(
                  onTap: () => context.pushNamed(
                    AppRoutes.course.name,
                    pathParameters: {"id": data.id},
                    extra: data,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 10,
                            child: CachedNetworkImage(
                              imageUrl: data.thumbnail,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: 4.5,
                              itemCount: 5,
                              itemSize: 30,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: 48,
                                      width: 48,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.star,
                                        color: Colors.black,
                                        size: 48,
                                      ),
                                    ),
                                    Container(
                                      height: 48,
                                      width: 48,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.star,
                                        color: ratingColor,
                                        size: 44,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const Text(
                              "(200)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: ratingColor,
                              ),
                            )
                          ],
                        ),
                        Text(
                          data.title,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              MaterialCommunityIcons.chef_hat,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data.instructor.instructorName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              MaterialCommunityIcons.bread_slice,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${data.totalContentCount} Lessons",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Divider(thickness: 0.5),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            if (kDebugMode) {
              print(error);
            }
            return const SizedBox.shrink();
          },
          loading: () => const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          )),
        );
  }
}
