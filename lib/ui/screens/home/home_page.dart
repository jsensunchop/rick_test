import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:rick_test/domain/bloc/characters_bloc/characters_bloc.dart';
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
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      if (state is PostsLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Results> posts = [];
      bool isLoading = false;

      if (state is PostsLoading) {
        posts = state.oldPosts;
        isLoading = true;
      } else if (state is PostsLoaded) {
        posts = state.posts;
      }

      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < posts.length)
            return _post(posts[index], context);
          else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: posts.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _post(Results post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Card(
                                    elevation: 1,
                                    child: ListTile(
                                      subtitle: Row(
                                        children: [
                                          Image.network(
                                            post.image,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 7,
                                              ),

                                              ///NOMBRE DE USUARIO
                                              InkWell(
                                                onTap: () => fetchIndividualCharacter(post.id),
                                                child: Text(
                                                  post.name,
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          Style.Colors.mainColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),

                                              ///TELEFONO DE USUARIO
                                              Row(
                                                children: <Widget>[
                                                  const Icon(Icons.phone,
                                                      size: 15,
                                                      color: Style
                                                          .Colors.mainColor),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    post.status,
                                                    style: const TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),

                                              ///EMAIL DE USUARIO
                                              Text(
                                                post.gender,
                                                style: const TextStyle(
                                                    fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   static const routeName = '/home-page';
//
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   ///INICIALIZAR LA BASE DE DATOS
//   String keyword = '';
//   int characterId = 0;
//   int characterPage = 1;
//
//
//   final list = <Results>[];
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // BlocProvider.of<CharacterBloc>(context)
//   //   //     .add(FetchNextCharacterPage(characterPage: characterPage)
//   //   //   // FetchBusinessEvent()
//   //   // );
//   //
//   //   _scrollController.addListener(() {
//   //     if (_scrollController.position.pixels ==
//   //         _scrollController.position.maxScrollExtent) {
//   //       BlocProvider.of<CharacterBloc>(context).add(FetchCharacter()
//   //           // FetchBusinessEvent()
//   //           );
//   //     }
//   //   });
//   // }
//   //
//   // @override
//   // void dispose() {
//   //   _scrollController.dispose();
//   //   super.dispose();
//   // }
//
//   void fetchIndividualCharacter(int id) {
//     BlocProvider.of<IndividualCharacterBloc>(context)
//         .add(FetchCharacterById(characterId: id)
//             // FetchBusinessEvent()
//             );
//     Get.toNamed(DetailsPage.routeName);
//   }
//
//   // Timer? debouncer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Rick Test"),
//           backgroundColor: Style.Colors.mainColor,
//         ),
//         body: BlocBuilder<CharacterBloc, CharacterState>(
//             builder: (context, state) {
//           if (state is CharactersFetched) {
//
//             return Column(
//               children: [
//                 ///CREACION DEL WIDGET DE FILTRO DE USUARIOS
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: TextField(
//                 //     decoration: const InputDecoration(
//                 //       icon: Icon(Icons.search),
//                 //       border: OutlineInputBorder(
//                 //       ),
//                 //       labelText: 'Buscar usuario',),
//                 //     onChanged: (value) {
//                 //       keyword = value;
//                 //       setState(() {
//                 //
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//                 ///CREACION DE LA LISTA DE USUARIOS DEL API
//                 Expanded(
//                   child: LazyLoadScrollView(
//                     onEndOfPage: () {
//                       BlocProvider.of<CharacterBloc>(context).add(FetchCharacter());
//                     },
//                     scrollOffset: 70,
//                     child: ListView.separated(
//                         separatorBuilder: (BuildContext context, int index) {
//                           return const SizedBox(
//                             height: 20,
//                           );
//                         },
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemCount: state.charactersResponse.results.length,
//                         itemBuilder: (context, index) {
//                           return index >= state.charactersResponse.results.length
//                               ? const Center(
//                                   child: SizedBox(
//                                     height: 24,
//                                     width: 24,
//                                     child: CircularProgressIndicator(
//                                         strokeWidth: 1.5),
//                                   ),
//                                 )
//                               : SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.19,
//
//                                   ///WIDGET DE TARJETA
//                                   child: Card(
//                                     elevation: 1,
//                                     child: ListTile(
//                                       subtitle: Row(
//                                         children: [
//                                           Image.network(
//                                             state.charactersResponse
//                                                 .results[index].image,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.25,
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.5,
//                                             loadingBuilder:
//                                                 (BuildContext context,
//                                                     Widget child,
//                                                     ImageChunkEvent?
//                                                         loadingProgress) {
//                                               if (loadingProgress == null)
//                                                 return child;
//                                               return CircularProgressIndicator(
//                                                 value: loadingProgress
//                                                             .expectedTotalBytes !=
//                                                         null
//                                                     ? loadingProgress
//                                                             .cumulativeBytesLoaded /
//                                                         loadingProgress
//                                                             .expectedTotalBytes!
//                                                     : null,
//                                               );
//                                             },
//                                           ),
//                                           SizedBox(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.05,
//                                           ),
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(
//                                                 height: 7,
//                                               ),
//
//                                               ///NOMBRE DE USUARIO
//                                               InkWell(
//                                                 onTap: () => fetchIndividualCharacter(state
//                                                     .charactersResponse.results[index].id),
//                                                 child: Text(
//                                                   state.charactersResponse
//                                                       .results[index].name,
//                                                   style: const TextStyle(
//                                                       fontSize: 14.0,
//                                                       color:
//                                                           Style.Colors.mainColor,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 height: 7,
//                                               ),
//
//                                               ///TELEFONO DE USUARIO
//                                               Row(
//                                                 children: <Widget>[
//                                                   const Icon(Icons.phone,
//                                                       size: 15,
//                                                       color: Style
//                                                           .Colors.mainColor),
//                                                   const SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Text(
//                                                     state.charactersResponse
//                                                         .results[index].status,
//                                                     style: const TextStyle(
//                                                         fontSize: 14.0),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(
//                                                 height: 7,
//                                               ),
//
//                                               ///EMAIL DE USUARIO
//                                               Text(
//                                                 state.charactersResponse
//                                                     .results[index].gender,
//                                                 style: const TextStyle(
//                                                     fontSize: 14.0),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                         }),
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             ///EN CASO DE QUE NO SE PUEDA CARGAR
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         }));
//   }
// }
