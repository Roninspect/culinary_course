import 'package:chewie/chewie.dart';
import 'package:culinary_course/src/features/enrolled-course/providers/content_provider.dart';
import 'package:culinary_course/src/features/enrolled-course/providers/curriculum_provider.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class PlaylistVideoPlayer extends ConsumerStatefulWidget {
  const PlaylistVideoPlayer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaylistVideoPlayerState();
}

class _PlaylistVideoPlayerState extends ConsumerState<PlaylistVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  int currentCurriculumIndex = 0;
  int currentContentIndex = 0;
  List<Curriculum> curriculums = [];

  @override
  void initState() {
    curriculums = ref.read(curriculumNotifierProvider);
    super.initState();
    playCurriculum();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void playCurriculum() {
    if (currentCurriculumIndex < curriculums.length) {
      final curriculum = curriculums[currentCurriculumIndex];
      playContent(curriculum.content[currentContentIndex]);

      _videoPlayerController?.addListener(() {
        if (_videoPlayerController!.value.isCompleted) {
          // Video finished, trigger your logic here
          ref.read(curriculumNotifierProvider.notifier).markAsDone(
                currentCurriculumIndex: currentCurriculumIndex,
                currentContentIndex: currentContentIndex,
              );

          // Move to the next content or curriculum
          setState(() {
            currentContentIndex++;

            if (currentContentIndex < curriculum.content.length) {
              playContent(curriculum.content[currentContentIndex]);
            } else {
              currentCurriculumIndex++;
              currentContentIndex = 0;

              if (currentCurriculumIndex < curriculums.length) {
                // Ensure to stop the current video before starting the next one
                _videoPlayerController?.pause();
                playCurriculum();
              } else {
                currentCurriculumIndex++;
                currentContentIndex = 0;
              }
            }
          });
        }
      });
    }
  }

  void playContent(Content content) {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(content.link));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: false,
      aspectRatio: 16 / 10,
      // You can customize other Chewie options here
    );

    _videoPlayerController!.initialize().then((_) {
      setState(() {
        // Start playing the content
        _videoPlayerController!.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 10, child: Chewie(controller: _chewieController!));
  }
}
