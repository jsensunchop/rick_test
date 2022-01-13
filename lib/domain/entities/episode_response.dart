import 'package:json_annotation/json_annotation.dart';

part 'episode_response.g.dart';

///PODO ApiResponse
///
//Post model

@JsonSerializable()
class EpisodeResponse {

  final InfoEpisode info;


  EpisodeResponse(this.info);

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) => _$EpisodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeResponseToJson(this);
}


@JsonSerializable()
class InfoEpisode {
  final int? count;
  final int? pages;
  final String? next;
  // final void prev;


  InfoEpisode(this.count, this.pages, this.next);

  factory InfoEpisode.fromJson(Map<String, dynamic> json) => _$InfoEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$InfoEpisodeToJson(this);
}
