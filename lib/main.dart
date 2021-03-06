import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rick_test/domain/bloc/characters_bloc/characters_bloc.dart';
import 'package:rick_test/domain/bloc/episodes_bloc/episodes_bloc.dart';
import 'package:rick_test/domain/bloc/individual_character_bloc/individual_character_bloc.dart';
import 'package:rick_test/ui/screens/details/details_page.dart';
import 'package:rick_test/ui/screens/home/home_page.dart';

import 'data/repository/user_repo.dart';

void main() {
  final userRepo = UserRepo();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<IndividualCharacterBloc>(create: (context) {
          return IndividualCharacterBloc(userRepo)..add(FetchCharacterEvent());
        }),
        BlocProvider<EpisodesBloc>(create: (context) {
          return EpisodesBloc(userRepo)..add(FetchEpisodesEvent());
        }),
      ],
      child: MyApp(
        repository:userRepo,
      )));
}

class MyApp extends StatelessWidget {
  final UserRepo repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rick Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PostsCubit(repository),
        child: HomePage(),
      ),
      routes: {
        // HomePage.routeName: (context) => HomePage(),
        DetailsPage.routeName: (context) => DetailsPage()
        //
        // 'splash': ( _ ) => SplashPage(),
        // 'register': ( _ ) => RegisterPage(),
        // 'home' : ( _ ) => HomePage(),
      },
    );
  }
}
