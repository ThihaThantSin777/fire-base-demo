import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/network/data_agent/feed_data_agent.dart';

const kFeedPath = 'feed';

class FeedDataAgentCloudFireStoreImpl extends FeedDataAgent {
  FeedDataAgentCloudFireStoreImpl._();

  static final FeedDataAgentCloudFireStoreImpl _singleton = FeedDataAgentCloudFireStoreImpl._();

  factory FeedDataAgentCloudFireStoreImpl() => _singleton;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  @override
  Future<FeedVO> getFeedByID(int id) async {
    return _firebaseFireStore.collection(kFeedPath).doc(id.toString()).get().then((value) {
      final rawData = value.data();
      return FeedVO.fromJson(Map<String, dynamic>.from(rawData as Map));
    });
  }

  @override
  Future<List<FeedVO>> getFeedList() async {
    throw UnimplementedError();
  }

  @override
  Future saveFeed(FeedVO feedVO) => _firebaseFireStore.collection(kFeedPath).doc(feedVO.id.toString()).set(feedVO.toJson());

  @override
  Future deleteFeed(int id) => _firebaseFireStore.collection(kFeedPath).doc(id.toString()).delete();

  @override
  Stream<List<FeedVO>?> getFeedListStream() => _firebaseFireStore.collection(kFeedPath).snapshots().map((querySnapShot) {
        return querySnapShot.docs.map<FeedVO>((document) {
          return FeedVO.fromJson(document.data());
        }).toList();
      });
}
