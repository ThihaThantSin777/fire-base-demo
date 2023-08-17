import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/network/data_agent/feed_data_agent.dart';
import 'package:fire_base/network/data_agent/feed_data_agent_cloud_fire_store_impl.dart';

class FeedModel {
  FeedModel._();

  static final FeedModel _singleton = FeedModel._();

  factory FeedModel() => _singleton;

  //final FeedDataAgent _feedDataAgent = FeedDataAgentPOCImpl();

  //final FeedDataAgent _feedDataAgent = FeedDataAgentRealTimeDatabaseImpl();

  final FeedDataAgent _feedDataAgent = FeedDataAgentCloudFireStoreImpl();

  Future<List<FeedVO>> getFeedList() => _feedDataAgent.getFeedList();

  Future<FeedVO> getFeedByID(int id) => _feedDataAgent.getFeedByID(id);

  void saveFeed(FeedVO feedVO) => _feedDataAgent.saveFeed(feedVO);

  Future deleteFeed(int id) => _feedDataAgent.deleteFeed(id);

  Stream<List<FeedVO>?> getFeedListStream() => _feedDataAgent.getFeedListStream();
}
