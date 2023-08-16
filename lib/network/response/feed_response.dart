import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/feed_vo.dart';

part 'feed_response.g.dart';

@JsonSerializable()
class FeedResponse {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  List<FeedVO> data;

  FeedResponse({required this.code, required this.message, required this.data});

  factory FeedResponse.fromJson(Map<String, dynamic> json) => _$FeedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedResponseToJson(this);
}
