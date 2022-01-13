import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_test/data/repository/user_repo.dart';
import 'package:rick_test/domain/entities/characters_response.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc(this.userRepo) : super(InitialCharacterState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<CharacterEvent, CharacterState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<CharacterState> mapEventToState(CharacterEvent event) async* {
    if (event is FetchNextCharacterPage) {
      yield FetchingCharacters();
      try {
        //consuming api
        final _characterPage = event.characterPage;
        final data = await userRepo.fetchCharacters(_characterPage);
        yield CharactersFetched(data);
      } catch (error) {
        ///EVENTO DE ERROR
        yield ErrorFetching();
        print(error);
        print("hello");
      }
    }
  }

  CharacterState get initialState => InitialCharacterState();
}