import 'package:json_annotation/json_annotation.dart';

part 'characters_response.g.dart';

///PODO ApiResponse
///
//Post model

@JsonSerializable()
class CharactersResponse {

  final Info info;
  final List<Results> results;


  CharactersResponse(this.info, this.results);

  factory CharactersResponse.fromJson(Map<String, dynamic> json) => _$CharactersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersResponseToJson(this);
}


@JsonSerializable()
class Info {
  final int? count;
  final int? pages;
  final String? next;
  // final void prev;


  Info(this.count, this.pages, this.next);

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}


@JsonSerializable()
class Results {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Origin location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;


  Results(this.id, this.name, this.status, this.species, this.type, this.gender, this.origin, this.location, this.image,
      this.episode, this.url, this.created);

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class Origin {
  final String name;
  final String url;


  Origin(this.name, this.url);

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);

  Map<String, dynamic> toJson() => _$OriginToJson(this);
}