part of 'characters_bloc.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
class CharactersLoaded extends CharactersState {
  final List<Results> characters;

  CharactersLoaded(this.characters);
}

class CharactersLoading extends CharactersState {
  final List<Results> oldCharactersList;
  final bool isFirstFetch;

  CharactersLoading(this.oldCharactersList, {this.isFirstFetch=false});
}