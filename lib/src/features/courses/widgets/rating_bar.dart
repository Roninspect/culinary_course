import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/home/widgets/rating_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvgRatingbar extends ConsumerWidget {
  const AvgRatingbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
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
          ),
        )
      ],
    );
  }
}
