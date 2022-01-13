part of 'characters_bloc.dart';

abstract class CharacterEvent extends Equatable {

  const CharacterEvent();
  @override
  List<Object> get props => [];
}

class FetchCharacter extends CharacterEvent{
  @override
  List<Object> get props => [];
}

class FetchNextCharacterPage extends CharacterEvent{

  final int characterPage;

  const FetchNextCharacterPage({required this.characterPage});
  @override
  List<Object> get props => [characterPage];
}