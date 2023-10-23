// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'package:culinary_course/src/models/course.dart';

class CourseVideoPlayer extends ConsumerStatefulWidget {
  final Course course;
  const CourseVideoPlayer({
    super.key,
    required this.course,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends ConsumerState<CourseVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? chewieController;
  bool isLoading = false;
  bool isVideoInitialized = false;

  Future<void> initializeVideo() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.course.intro));
    setState(() {
      isLoading = true;
    });

    await _videoPlayerController!.initialize();

    setState(() {
      isLoading = false;
      isVideoInitialized = true;
    });

    chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        aspectRatio: 17.5 / 11,
        autoPlay: true);
    setState(() {});
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }

    if (chewieController != null) {
      chewieController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Initialize the video when the user taps on it
            if (!isVideoInitialized) {
              initializeVideo();
            }
          },
          child: isVideoInitialized
              ? AspectRatio(
                  aspectRatio: 17.5 / 11,
                  child: Chewie(
                    controller: chewieController!,
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: CachedNetworkImage(
                          imageUrl: widget.course.thumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : Icon(
                            Icons.play_circle_fill,
                            size: 64,
                            color: primaryColor.withOpacity(0.75),
                          ),
                  ],
                ),
        ),
      ],
    );
  }
}
