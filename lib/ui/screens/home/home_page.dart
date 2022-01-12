import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_test/domain/bloc/characters_bloc/characters_bloc.dart';
import 'package:rick_test/domain/bloc/individual_character_bloc/individual_character_bloc.dart';
import 'package:get/get.dart';
import 'package:rick_test/ui/screens/details/details_page.dart';
import 'package:rick_test/ui/utils/theme.dart' as Style;

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///INICIALIZAR LA BASE DE DATOS
  String keyword = '';
  int characterId = 0;
  late String userName;
  late String userEmail;
  late String userPhone;

  void fetchBusinessList(int id) {
    BlocProvider.of<IndividualCharacterBloc>(context)
        .add(FetchCharacterById(characterId: id)
            // FetchBusinessEvent()
            );
    Get.toNamed(DetailsPage.routeName);
  }

  // Timer? debouncer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rick Test"),
          backgroundColor: Style.Colors.mainColor,
        ),
        body: BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
          if (state is CharactersFetched) {
            return Column(
              children: [
                ///CREACION DEL WIDGET DE FILTRO DE USUARIOS
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextField(
                //     decoration: const InputDecoration(
                //       icon: Icon(Icons.search),
                //       border: OutlineInputBorder(
                //       ),
                //       labelText: 'Buscar usuario',),
                //     onChanged: (value) {
                //       keyword = value;
                //       setState(() {
                //
                //       });
                //     },
                //   ),
                // ),
                ///CREACION DE LA LISTA DE USUARIOS DEL API
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.charactersResponse.results.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.19,

                          ///WIDGET DE TARJETA
                          child: InkWell(
                            onTap: () => fetchBusinessList(
                                state.charactersResponse.results[index].id),
                            child: Card(
                              elevation: 1,
                              child: ListTile(
                                subtitle: Row(
                                  children: [
                                    Image.network(
                                      state.charactersResponse.results[index]
                                          .image,
                                      width: MediaQuery.of(context).size.width*0.25,
                                      height: MediaQuery.of(context).size.width*0.5,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
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
                                    SizedBox(width: MediaQuery.of(context).size.width*0.05,),
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
                                        Text(
                                          state.charactersResponse
                                              .results[index].name,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Style.Colors.mainColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),

                                        ///TELEFONO DE USUARIO
                                        Row(
                                          children: <Widget>[
                                            const Icon(Icons.phone,
                                                size: 15,
                                                color: Style.Colors.mainColor),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              state.charactersResponse
                                                  .results[index].status,
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
                                          state.charactersResponse
                                              .results[index].gender,
                                          style: const TextStyle(
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else {
            ///EN CASO DE QUE NO SE PUEDA CARGAR
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}
