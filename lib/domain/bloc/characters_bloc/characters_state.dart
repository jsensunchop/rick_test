part of 'characters_bloc.dart';


@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}
class PostsLoaded extends PostsState {
  final List<Results> posts;

  PostsLoaded(this.posts);
}

class PostsLoading extends PostsState {
  final List<Results> oldPosts;
  final bool isFirstFetch;

  PostsLoading(this.oldPosts, {this.isFirstFetch=false});
}