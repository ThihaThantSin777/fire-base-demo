import 'dart:convert';

import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/network/data_agent/feed_data_agent.dart';
import 'package:fire_base/network/response/feed_response.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

const kFeedPath = 'feed';

class FeedDataAgentRealTimeDatabaseImpl extends FeedDataAgent {
  FeedDataAgentRealTimeDatabaseImpl._();

  static final FeedDataAgentRealTimeDatabaseImpl _singleton = FeedDataAgentRealTimeDatabaseImpl._();

  factory FeedDataAgentRealTimeDatabaseImpl() => _singleton;
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Future<FeedVO> getFeedByID(int id) async {
    return databaseRef.child(kFeedPath).child(id.toString()).once().then((event) {
      final rawData = event.snapshot.value;
      return FeedVO.fromJson(Map<String, dynamic>.from(rawData as Map));
    });
  }

  @override
  Future<List<FeedVO>> getFeedList() async {
    throw UnimplementedError();
  }

  @override
  Future saveFeed(FeedVO feedVO) {
    return databaseRef.child(kFeedPath).child(feedVO.id.toString()).set(feedVO.toJson());
  }

  @override
  Future deleteFeed(int id) {
    return databaseRef.child(kFeedPath).child(id.toString()).remove();
  }

  @override
  Stream<List<FeedVO>?> getFeedListStream() {
    return databaseRef.child(kFeedPath).onValue.map((event) {
      return event.snapshot.children.map<FeedVO>((snapshot) {
        return FeedVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }
}
