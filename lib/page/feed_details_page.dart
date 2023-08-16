import 'package:fire_base/bloc/add_feed_page_bloc.dart';
import 'package:fire_base/bloc/feed_details_page_bloc.dart';
import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/utils/enums.dart';
import 'package:fire_base/utils/extensions.dart';
import 'package:fire_base/widgets/feed_body_widget.dart';
import 'package:fire_base/widgets/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/show_error_widget.dart';

class FeedDetailsPage extends StatelessWidget {
  const FeedDetailsPage({super.key, required this.feedID});

  final int feedID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedDetailsPageBloc>(
      create: (_) => FeedDetailsPageBloc(feedID: feedID),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Feed"),
          ),
          body: Selector<FeedDetailsPageBloc, LoadingState>(
              selector: (_, bloc) => bloc.getLoadingState,
              builder: (_, loadingState, __) => LoadingStateWidget(
                  loadingState: loadingState,
                  loadingSuccessWidget: const _FeedDetailsIteView(),
                  errorWidget: const _FeedDetailsPageErrorStateItemView()))),
    );
  }
}

class _FeedDetailsIteView extends StatelessWidget {
  const _FeedDetailsIteView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedDetailsPageBloc>();
    return Selector<FeedDetailsPageBloc, FeedVO?>(
        selector: (_, bloc) => bloc.getFeed,
        builder: (_, feed, __) => FeedBodyWidget(
              feedVO: feed,
              onTapFeed: () {},
              onTapEdit: () {},
              onTapDelete: () {
                context.navigateBack();
                context.navigateBack();
                bloc.deleteFeed(feed?.id ?? -1);
              },
            ));
  }
}

class _FeedDetailsPageErrorStateItemView extends StatelessWidget {
  const _FeedDetailsPageErrorStateItemView();

  @override
  Widget build(BuildContext context) {
    return Selector<FeedDetailsPageBloc, String?>(
        selector: (_, bloc) => bloc.getErrorMessage, builder: (_, errorMessage, __) => ShowErrorWidget(errorMessage: errorMessage ?? ""));
  }
}
