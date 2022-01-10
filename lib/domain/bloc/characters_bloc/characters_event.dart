part of 'characters_bloc.dart';

abstract class CharacterEvent extends Equatable {}

class FetchCharacter extends CharacterEvent{
  @override
  List<Object> get props => [];
}