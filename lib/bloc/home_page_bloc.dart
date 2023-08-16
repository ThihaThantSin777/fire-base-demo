import 'package:fire_base/bloc/base_bloc.dart';
import 'package:fire_base/data/model/feed_model.dart';
import 'package:fire_base/utils/enums.dart';

import '../data/vos/feed_vo.dart';

class HomePageBloc extends BaseBloc {
  List<FeedVO>? _feedList;

  List<FeedVO>? get getFeedList => _feedList;

  final FeedModel _feedModel = FeedModel();

  HomePageBloc() {
    setLoadingState = LoadingState.loading;
    notifyListeners();
    _feedModel.getFeedList().then((value) {
      setLoadingState = LoadingState.complete;
      _feedList = value;
      notifyListeners();
    }).catchError((error) {
      setLoadingState = LoadingState.error;
      setErrorMessage = error.toString();
      notifyListeners();
    });
  }
}
