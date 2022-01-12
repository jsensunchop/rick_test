part of 'individual_character_bloc.dart';

abstract class IndividualCharacterEvent extends Equatable {
  const IndividualCharacterEvent();
  @override
  List<Object> get props => [];
}

class FetchCharacterById extends IndividualCharacterEvent{

  final int characterId;

  const FetchCharacterById({required this.characterId});
  @override
  List<Object> get props => [characterId];
}

class FetchCharacterEvent extends IndividualCharacterEvent{
  @override
  List<Object> get props => [];
}

