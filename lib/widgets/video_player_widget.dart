import 'dart:io';

import 'package:fire_base/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.filePath, this.isFileIsNetwork = false, this.onTapRemove});

  final String filePath;
  final Function? onTapRemove;
  final bool isFileIsNetwork;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlay = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.isFileIsNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(widget.filePath))
        : VideoPlayerController.file(File(widget.filePath));
    _controller.initialize().whenComplete(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {});
      }
    });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlay = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            children: [
              Positioned.fill(child: VideoPlayer(_controller)),
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      if (_isPlay) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    },
                    icon: Icon(
                      _isPlay ? Icons.pause : Icons.play_arrow,
                      size: 48,
                      color: Colors.white,
                    ),
                  )),
              if (widget.onTapRemove != null) ...[
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      widget.onTapRemove!();
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                )
              ]
            ],
          )
        : const LoadingWidget();
  }
}
