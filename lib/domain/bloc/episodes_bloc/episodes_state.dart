part of 'episodes_bloc.dart';


abstract class EpisodesState extends Equatable {}

class InitialCharacterState extends EpisodesState{
  @override
  List<Object> get props => [];
}
// success state
class EpisodesFetched extends EpisodesState {
  final EpisodeResponse episodeInfo;

  EpisodesFetched(this.episodeInfo);

  @override
  List<Object> get props => [episodeInfo];
}
//loading state
class FetchingEpisodes extends EpisodesState{
  @override
  List<Object> get props => [];

//error state
}class ErrorFetching extends EpisodesState{
  @override
  List<Object> get props => [];
}