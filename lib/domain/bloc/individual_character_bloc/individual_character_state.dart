part of 'individual_character_bloc.dart';


abstract class IndividualCharacterState extends Equatable {}

class InitialCharacterState extends IndividualCharacterState{
  @override
  List<Object> get props => [];
}
// success state
class IndividualCharacterFetched extends IndividualCharacterState {
  final Results individualCharacter;

  IndividualCharacterFetched(this.individualCharacter);

  @override
  List<Object> get props => [individualCharacter];
}
//loading state
class FetchingIndividualCharacter extends IndividualCharacterState{
  @override
  List<Object> get props => [];

//error state
}class ErrorFetching extends IndividualCharacterState{
  @override
  List<Object> get props => [];
}