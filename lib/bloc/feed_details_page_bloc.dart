import 'package:fire_base/bloc/base_bloc.dart';
import 'package:fire_base/data/vos/feed_vo.dart';

import '../data/model/feed_model.dart';
import '../utils/enums.dart';

class FeedDetailsPageBloc extends BaseBloc {
  FeedVO? _feed;

  FeedVO? get getFeed => _feed;

  final FeedModel _feedModel = FeedModel();

  FeedDetailsPageBloc({required int feedID}) {
    setLoadingState = LoadingState.loading;
    notifyListeners();

    _feedModel.getFeedByID(feedID).then((value) {
      setLoadingState = LoadingState.complete;
      _feed = value;
      notifyListeners();
    }).catchError((error) {
      setLoadingState = LoadingState.error;
      setErrorMessage = error.toString();
      notifyListeners();
    });
  }

  Future deleteFeed(int id) => _feedModel.deleteFeed(id);
}
