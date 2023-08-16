import 'package:fire_base/bloc/add_feed_page_bloc.dart';
import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/page/feed_details_page.dart';
import 'package:fire_base/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../utils/enums.dart';
import '../utils/url_launcher_utils.dart';
import 'cache_network_image_widget.dart';

class FeedBodyWidget extends StatelessWidget {
  const FeedBodyWidget({super.key, required this.feedVO});

  final FeedVO? feedVO;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateToNext(FeedDetailsPage(feedID: feedVO?.id ?? -1));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CacheNetworkImageWidget(
                    imageURL: feedVO?.fileURL ?? '',
                  ),
                )
              ],
              if (feedVO?.getFileType == FileType.video) ...[
                const SizedBox(),
              ],
              if (feedVO?.getFileType == FileType.file) ...[_FeedFileView(fileURL: feedVO?.fileURL ?? '')]
            ],
          ),
        ),
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
