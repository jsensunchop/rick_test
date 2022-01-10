import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_test/domain/bloc/characters_bloc/characters_bloc.dart';

import 'home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  ///BLOC PARA LLENAR LA BASE DE DATOS POR MEDIO DEL API
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CharacterBloc, CharacterState>(builder: (context, state) {
          if (state is CharactersFetched) {
            return const HomePage();
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