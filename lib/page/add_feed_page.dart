import 'dart:io';

import 'package:fire_base/bloc/add_feed_page_bloc.dart';
import 'package:fire_base/utils/enums.dart';
import 'package:fire_base/utils/file_picker_utils.dart';
import 'package:fire_base/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({super.key, this.feedID = -1});

  final int feedID;

  @override
  State<AddFeedPage> createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddFeedPageBloc>(
      create: (_) => AddFeedPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.feedID != 1 ? "Add Feed" : "Edit Feed"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Selector<AddFeedPageBloc, FileType>(
                  selector: (_, bloc) => bloc.getFileType,
                  builder: (_, fileType, __) => _FileTypeChipItemView(
                        currentFileType: fileType,
                      )),
              Flexible(
                  child: _DescriptionTextFieldView(
                controller: _controller,
              )),
              Selector<AddFeedPageBloc, FileType>(
                  selector: (_, bloc) => bloc.getFileType, builder: (_, fileType, __) => _FileTypeView(fileType: fileType)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FileTypeView extends StatelessWidget {
  const _FileTypeView({required this.fileType});

  final FileType fileType;

  @override
  Widget build(BuildContext context) {
    return Selector<AddFeedPageBloc, File?>(
        selector: (_, bloc) => bloc.getSelectFile,
        builder: (_, file, __) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: file != null && fileType == FileType.photo
                  ? _PhotoView(
                      file: file,
                    )
                  : file != null && fileType == FileType.video
                      ? _VideoPlayerView(
                          filePath: file.path,
                        )
                      : file != null && fileType == FileType.file
                          ? _FileView(file: file)
                          : const SizedBox(),
            ));
  }
}

class _FileView extends StatelessWidget {
  const _FileView({required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddFeedPageBloc>();
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.file_present,
                  size: 32,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(file.path.split('/').last)
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              bloc.setSelectFile = null;
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 28,
            ),
          ),
        )
      ],
    );
  }
}

class _VideoPlayerView extends StatefulWidget {
  const _VideoPlayerView({required this.filePath});

  final String filePath;

  @override
  State<_VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<_VideoPlayerView> {
  late VideoPlayerController _controller;
  bool _isPlay = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath), videoPlayerOptions: VideoPlayerOptions());
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
    final bloc = context.read<AddFeedPageBloc>();
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
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    bloc.setSelectFile = null;
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
              )
            ],
          )
        : const LoadingWidget();
  }
}

class _PhotoView extends StatelessWidget {
  const _PhotoView({required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddFeedPageBloc>();
    return Stack(
      children: [
        Positioned.fill(child: Image.file(file)),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              bloc.setSelectFile = null;
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 28,
            ),
          ),
        )
      ],
    );
  }
}

class _DescriptionTextFieldView extends StatelessWidget {
  const _DescriptionTextFieldView({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        maxLines: null,
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'What is in your mind?',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _FileTypeChipItemView extends StatelessWidget {
  const _FileTypeChipItemView({required this.currentFileType});

  final FileType currentFileType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: FileType.values
            .map((e) => Expanded(
                  child: _FileChipView(
                    fileType: e,
                    isSelect: e == currentFileType,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _FileChipView extends StatelessWidget {
  const _FileChipView({required this.fileType, required this.isSelect});

  final FileType fileType;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddFeedPageBloc>();
    return GestureDetector(
      onTap: () async {
        final image = fileType == FileType.photo
            ? await FilePickerUtils.getImage()
            : fileType == FileType.video
                ? await FilePickerUtils.getVideo()
                : await FilePickerUtils.getFile();
        bloc.setFileType = fileType;
        bloc.setSelectFile = image;
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: isSelect ? Colors.green : Colors.black, width: isSelect ? 2 : 1)),
        child: Text(fileType.name),
      ),
    );
  }
}
