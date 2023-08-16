import 'dart:convert';

import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/network/data_agent/feed_data_agent.dart';
import 'package:fire_base/network/response/feed_response.dart';
import 'package:flutter/services.dart';

class FeedDataAgentPOCImpl extends FeedDataAgent {
  FeedDataAgentPOCImpl._();

  static final FeedDataAgentPOCImpl _singleton = FeedDataAgentPOCImpl._();

  factory FeedDataAgentPOCImpl() => _singleton;

  @override
  Future<FeedVO> getFeedByID(int id) async {
    final String response = await rootBundle.loadString('assets/new_feed_json/new_feed.json');
    final feedList = FeedResponse.fromJson(jsonDecode(response)).data;
    return feedList.where((element) => element.id == id).first;
  }

  @override
  Future<List<FeedVO>> getFeedList() async {
    final String response = await rootBundle.loadString('assets/new_feed_json/new_feed.json');
    return FeedResponse.fromJson(jsonDecode(response)).data;
  }

  @override
  void saveFeed(FeedVO feedVO) {
    // TODO
  }

  @override
  void deleteFeed(int id) {
    // TODO
  }
}
