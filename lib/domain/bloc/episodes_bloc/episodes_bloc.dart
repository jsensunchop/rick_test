import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as snack;
import 'package:rick_test/data/repository/user_repo.dart';
import 'package:rick_test/domain/entities/characters_response.dart';
import 'package:rick_test/domain/entities/episode_response.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  EpisodesBloc(this.userRepo) : super(InitialCharacterState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<EpisodesEvent, EpisodesState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<EpisodesState> mapEventToState(EpisodesEvent event) async* {
    if (event is FetchEpisodesEvent) {
      yield FetchingEpisodes();
      try {
        //consuming api
        final data = await userRepo.fetchEpisodes();
        print(data.info.count);
        yield EpisodesFetched(data);
      } catch (error) {
        ///EVENTO DE ERROR
        yield ErrorFetching();
        print(error);
        print("hello");
        snack.Get.snackbar("Error", "Hubo un error al obtener la data",backgroundColor: Colors.red);
      }
    }
  }

  EpisodesState get initialState => InitialCharacterState();
}