// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/home/widgets/rating_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:culinary_course/src/models/course.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CourseCard extends ConsumerWidget {
  final Course course;
  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 200,
                width: 300,
                child: CachedNetworkImage(
                  imageUrl: course.thumbnail,
                  fit: BoxFit.fill,
                ),
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
                      buildIcon(48, Colors.black),
                      buildIcon(44, ratingColor),
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
            course.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                course.instructor.instructorName,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
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
                "${course.totalContentCount} Lessons",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
