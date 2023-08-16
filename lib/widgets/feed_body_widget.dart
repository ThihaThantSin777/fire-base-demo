import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';

import '../utils/enums.dart';
import '../utils/url_launcher_utils.dart';
import 'cache_network_image_widget.dart';

class FeedBodyWidget extends StatelessWidget {
  const FeedBodyWidget({super.key, required this.feedVO, required this.onTapDelete, required this.onTapEdit, required this.onTapFeed});

  final FeedVO? feedVO;
  final Function onTapEdit;
  final Function onTapDelete;
  final Function onTapFeed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return EditDeleteModelSheetView(
                onTapDelete: () {
                  onTapDelete();
                },
                onTapEdit: () {
                  onTapEdit();
                },
              );
            });
      },
      onTap: () {
        onTapFeed();
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feedVO?.feedTitle ?? '',
                maxLines: 3,
                style: const TextStyle(height: 1.5, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              if (feedVO?.getFileType == FileType.photo) ...[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CacheNetworkImageWidget(
                      width: MediaQuery.of(context).size.width,
                      imageURL: feedVO?.fileURL ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
              if (feedVO?.getFileType == FileType.video) ...[
                Expanded(
                  child: VideoPlayerWidget(
                    filePath: feedVO?.fileURL ?? '',
                    isFileIsNetwork: true,
                  ),
                )
              ],
              if (feedVO?.getFileType == FileType.file) ...[Expanded(child: _FeedFileView(fileURL: feedVO?.fileURL ?? ''))]
            ],
          ),
        ),
      ),
    );
  }
}

class EditDeleteModelSheetView extends StatelessWidget {
  const EditDeleteModelSheetView({
    super.key,
    required this.onTapDelete,
    required this.onTapEdit,
  });
  final Function onTapDelete;
  final Function onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              onTapEdit();
            },
            child: const Text("Edit Feed"),
          ),
          const Divider(
            thickness: 1,
          ),
          GestureDetector(
            onTap: () {
              onTapDelete();
            },
            child: const Text("Delete Feed"),
          ),
        ],
      ),
    );
  }
}

class _FeedFileView extends StatelessWidget {
  const _FeedFileView({required this.fileURL});

  final String fileURL;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 30,
        child: GestureDetector(
          onTap: () async {
            UrlLauncherUtils.launchURLToBrowser(fileURL);
          },
          child: const Icon(
            Icons.file_present,
            size: 32,
          ),
        ),
      ),
    );
  }
}
