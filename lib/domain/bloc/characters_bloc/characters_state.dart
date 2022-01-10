part of 'characters_bloc.dart';


abstract class CharacterState extends Equatable {}

class InitialCharacterState extends CharacterState{
  @override
  List<Object> get props => [];
}
// success state
class CharactersFetched extends CharacterState {
  final CharactersResponse charactersResponse;

  CharactersFetched(this.charactersResponse);

  @override
  List<Object> get props => [charactersResponse];
}
//loading state
class FetchingCharacters extends CharacterState{
  @override
  List<Object> get props => [];

//error state
}class ErrorFetching extends CharacterState{
  @override
  List<Object> get props => [];
}