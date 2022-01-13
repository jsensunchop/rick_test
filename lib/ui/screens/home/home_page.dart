import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:rick_test/domain/bloc/characters_bloc/characters_bloc.dart';
import 'package:rick_test/domain/bloc/episodes_bloc/episodes_bloc.dart';
import 'package:rick_test/domain/bloc/individual_character_bloc/individual_character_bloc.dart';
import 'package:get/get.dart';
import 'package:rick_test/domain/entities/characters_response.dart';
import 'package:rick_test/ui/screens/details/details_page.dart';
import 'package:rick_test/ui/utils/theme.dart' as Style;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
  }

  void fetchIndividualCharacter(int id) {
    BlocProvider.of<IndividualCharacterBloc>(context)
        .add(FetchCharacterById(characterId: id)
            // FetchBusinessEvent()
            );
    Get.toNamed(DetailsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(
      // backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.13,
        backgroundColor: Style.Colors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "assets/rick_morty.png",
          scale: 5.5,
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<EpisodesBloc, EpisodesState>(
              builder: (context, state) {
            if (state is EpisodesFetched) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  child: Card(
                    elevation: 1,
                    color: Colors.grey.shade200,
                    child: ListTile(
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "La serie en numeros",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Style.Colors.darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "${state.episodeInfo.info.count.toString()} Numero de episodios",
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Style.Colors.darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          }),
          _postList(),
        ],
      ),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostsCubit, CharactersState>(builder: (context, state) {
      if (state is CharactersLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Results> characters = [];
      bool isLoading = false;

      if (state is CharactersLoading) {
        characters = state.oldCharactersList;
        isLoading = true;
      } else if (state is CharactersLoaded) {
        characters = state.characters;
      }

      return Expanded(
        child: ListView.separated(
          controller: scrollController,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
          itemCount: characters.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < characters.length) {
              return _charactersList(characters[index], context);
            } else {
              Timer(Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              return _loadingIndicator();
            }
          },
        ),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: CircularProgressIndicator(
        color: Style.Colors.mainColor,
      )),
    );
  }

  Widget _charactersList(Results post, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        child: Card(
          elevation: 1,
          color: Colors.grey.shade200,
          child: ListTile(
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlineButton(
                  shape: const StadiumBorder(),
                  textColor: Style.Colors.mainColor,
                  child: const Text('Detalles'),
                  borderSide: const BorderSide(
                      color: Style.Colors.mainColor,
                      style: BorderStyle.solid,
                      width: 1),
                  onPressed: () => fetchIndividualCharacter(post.id),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    post.image,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.25,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator(
                        color: Style.Colors.mainColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => fetchIndividualCharacter(post.id),
                        child: Text(
                          post.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Style.Colors.darkBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.adjust_outlined,
                              size: 15, color: Style.Colors.darkBlue),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            post.status,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        post.gender,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
