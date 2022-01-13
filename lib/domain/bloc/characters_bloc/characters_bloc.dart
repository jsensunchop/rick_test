import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_test/data/repository/user_repo.dart';
import 'package:rick_test/domain/entities/characters_response.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class PostsCubit extends Cubit<CharactersState> {
  PostsCubit(this.repository) : super(CharactersInitial());

  int page = 1;
  final UserRepo repository;

  void loadPosts() {
    if (state is CharactersLoading) return;

    final currentState = state;

    var oldPosts = <Results>[];
    if (currentState is CharactersLoaded) {
      oldPosts = currentState.characters;
    }

    emit(CharactersLoading(oldPosts, isFirstFetch: page == 1));

    repository.fetchCharacters(page).then((newPosts) {
      page++;

      final posts = (state as CharactersLoading).oldCharactersList;
      posts.addAll(newPosts.results);

      emit(CharactersLoaded(posts));
    });
  }

}