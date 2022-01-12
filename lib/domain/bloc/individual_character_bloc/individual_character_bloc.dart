import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_test/data/repository/user_repo.dart';
import 'package:rick_test/domain/entities/characters_response.dart';

part 'individual_character_event.dart';
part 'individual_character_state.dart';

class IndividualCharacterBloc extends Bloc<IndividualCharacterEvent, IndividualCharacterState> {
  IndividualCharacterBloc(this.userRepo) : super(InitialCharacterState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<IndividualCharacterEvent, IndividualCharacterState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<IndividualCharacterState> mapEventToState(IndividualCharacterEvent event) async* {
    if (event is FetchCharacterById) {
      yield FetchingIndividualCharacter();
      try {
        //consuming api
        final _characterId = event.characterId;
        final data = await userRepo.fetchCharacterById(_characterId);
        yield IndividualCharacterFetched(data);
      } catch (error) {
        ///EVENTO DE ERROR
        yield ErrorFetching();
        print(error);
        print("hello");
      }
    }
  }

  IndividualCharacterState get initialState => InitialCharacterState();
}