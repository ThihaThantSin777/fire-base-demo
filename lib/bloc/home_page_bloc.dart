import 'package:fire_base/bloc/base_bloc.dart';
import 'package:fire_base/data/model/feed_model.dart';
import 'package:fire_base/utils/enums.dart';

import '../data/vos/feed_vo.dart';

class HomePageBloc extends BaseBloc {
  List<FeedVO>? _feedList;

  List<FeedVO>? get getFeedList => _feedList;

  final FeedModel _feedModel = FeedModel();
  Future deleteFeed(int id) => _feedModel.deleteFeed(id);
  HomePageBloc() {
    setLoadingState = LoadingState.loading;
    notifyListeners();
    _feedModel.getFeedListStream().listen((event) {
      if (event?.isEmpty ?? true) {
        setLoadingState = LoadingState.error;
        setErrorMessage = "There is no feed in database";
        notifyListeners();
      } else {
        setLoadingState = LoadingState.complete;
        _feedList = event;
        notifyListeners();
      }
    }, onError: (error) {
      setErrorMessage = error.toString();
      notifyListeners();
    });
  }
}
