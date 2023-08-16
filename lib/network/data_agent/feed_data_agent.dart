import 'package:fire_base/data/vos/feed_vo.dart';

abstract class FeedDataAgent {
  Stream<List<FeedVO>?> getFeedListStream();
  Future<List<FeedVO>> getFeedList();

  Future<FeedVO> getFeedByID(int id);

  Future saveFeed(FeedVO feedVO);

  Future deleteFeed(int id);
}
