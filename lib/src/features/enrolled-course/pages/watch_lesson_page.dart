// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:culinary_course/src/features/courses/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:culinary_course/src/models/course.dart';

class WatchLessonPage extends ConsumerStatefulWidget {
  final Curriculum curriculum;
  const WatchLessonPage({
    super.key,
    required this.curriculum,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WatchLessonPageState();
}

class _WatchLessonPageState extends ConsumerState<WatchLessonPage> {
  @override
  Widget build(BuildContext context) {
    final curriculum = widget.curriculum;
    return Scaffold(
      appBar: AppBar(
        title: Text(curriculum.title),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
