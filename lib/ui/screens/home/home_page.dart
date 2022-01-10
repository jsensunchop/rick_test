import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_test/domain/bloc/characters_bloc/characters_bloc.dart';

import 'package:rick_test/ui/utils/theme.dart' as Style;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Timer? debouncer;

  ///INICIALIZAR LA BASE DE DATOS
  String keyword = '';
  int userId = 0;
  late String userName;
  late String userEmail;
  late String userPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prueba de ingreso"),
        backgroundColor: Style.Colors.mainColor,
      ),

        body: BlocBuilder<CharacterBloc, CharacterState>(builder: (context, state) {
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
                          child: Card(
                            elevation: 0,
                            child: ListTile(
                              leading: Image.network(
                                state.charactersResponse.results[index].image,
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  );
                                },
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 7,
                                  ),

                                  ///NOMBRE DE USUARIO
                                  Text(
                                    state.charactersResponse.results[index].name,
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
                                        state.charactersResponse.results[index].status,
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),

                                  ///EMAIL DE USUARIO
                                  Row(
                                    children: <Widget>[
                                      const Icon(Icons.mail,
                                          size: 15,
                                          color: Style.Colors.mainColor),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.charactersResponse.results[index].gender,
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
          else {
            ///EN CASO DE QUE NO SE PUEDA CARGAR
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })

    );
  }
}
