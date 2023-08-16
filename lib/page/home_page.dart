import 'package:fire_base/bloc/home_page_bloc.dart';
import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/page/add_feed_page.dart';
import 'package:fire_base/page/feed_details_page.dart';
import 'package:fire_base/utils/enums.dart';
import 'package:fire_base/utils/extensions.dart';
import 'package:fire_base/widgets/feed_body_widget.dart';
import 'package:fire_base/widgets/loading_state_widget.dart';
import 'package:fire_base/widgets/show_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (_) => HomePageBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.navigateToNext(const AddFeedPage());
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Selector<HomePageBloc, LoadingState>(
            selector: (_, bloc) => bloc.getLoadingState,
            builder: (_, loadingState, __) => LoadingStateWidget(
                loadingState: loadingState,
                loadingSuccessWidget: const HomePageItemView(),
                errorWidget: const _HomePageErrorStateItemView())),
      ),
    );
  }
}

class _HomePageErrorStateItemView extends StatelessWidget {
  const _HomePageErrorStateItemView();

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, String?>(
        selector: (_, bloc) => bloc.getErrorMessage, builder: (_, errorMessage, __) => ShowErrorWidget(errorMessage: errorMessage ?? ""));
  }
}

class HomePageItemView extends StatelessWidget {
  const HomePageItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePageBloc>();
    return Selector<HomePageBloc, List<FeedVO>?>(
        selector: (_, bloc) => bloc.getFeedList,
        builder: (_, feedList, __) => ListView.separated(
            itemBuilder: (_, index) => FeedBodyWidget(
                  feedVO: feedList?[index],
                  onTapDelete: () {
                    context.navigateBack();
                    bloc.deleteFeed(feedList?[index].id ?? -1);
                  },
                  onTapEdit: () {},
                  onTapFeed: () {
                    context.navigateToNext(FeedDetailsPage(feedID: feedList?[index].id ?? -1));
                  },
                ),
            separatorBuilder: (_, index) => const Divider(),
            itemCount: feedList?.length ?? 0));
  }
}
