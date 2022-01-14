// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeResponse _$EpisodeResponseFromJson(Map<String, dynamic> json) =>
    EpisodeResponse(
      InfoEpisode.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EpisodeResponseToJson(EpisodeResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

InfoEpisode _$InfoEpisodeFromJson(Map<String, dynamic> json) => InfoEpisode(
      json['count'] as int?,
      json['pages'] as int?,
      json['next'] as String?,
    );

Map<String, dynamic> _$InfoEpisodeToJson(InfoEpisode instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
    };
