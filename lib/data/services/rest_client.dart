// import 'package:retrofit_generator/retrofit_generator.dart'; // Solo quitar para correr build runner
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:rick_test/domain/entities/characters_response.dart';


part 'rest_client.g.dart';

//Retrofit client for API requests

@RestApi(baseUrl: "https://rickandmortyapi.com/api/")
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @GET("character/?page={number}")
  Future<CharactersResponse> getAllCharacters(@Path("number") int number);

  // @GET("posts")
  // Future<List<PostResponse>> getAllPosts();
  //
  // @GET("posts?userId={id}")
  // Future<List<PostResponse>> getPostsById(@Path("id") int userId);


}
