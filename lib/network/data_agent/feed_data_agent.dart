import 'package:fire_base/data/vos/feed_vo.dart';

abstract class FeedDataAgent {
  Future<List<FeedVO>> getFeedList();

  Future<FeedVO> getFeedByID(int id);

  void saveFeed(FeedVO feedVO);

  void deleteFeed(int id);
}
