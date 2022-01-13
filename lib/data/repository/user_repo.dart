import 'package:dio/dio.dart';
import 'package:rick_test/data/services/rest_client.dart';
import 'package:rick_test/domain/entities/characters_response.dart';
import 'package:rick_test/domain/entities/episode_response.dart';

class UserRepo {

  //API LIST QUERY REPO

  static final UserRepo _userRepo = UserRepo._internal();

  factory UserRepo(){
    return _userRepo;
  }
  UserRepo._internal();

  static final dio = Dio(BaseOptions(
    contentType: "application/json",
  ));

  RestClient _client = RestClient(dio);

  //Get all users from API
  Future<CharactersResponse> fetchCharacters(int number) async{
    return await _client.getAllCharacters(number);
  }
  //Get all users from API
  Future<Results> fetchCharacterById(int number) async{
    return await _client.getCharacterById(number);
  }

  Future<EpisodeResponse> fetchEpisodes() async{
    return await _client.getEpisodes();
  }



}