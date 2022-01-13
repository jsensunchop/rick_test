import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_test/domain/bloc/individual_character_bloc/individual_character_bloc.dart';
import 'package:rick_test/ui/utils/theme.dart' as Style;

class DetailsPage extends StatelessWidget {
  static const routeName = '/details-list';

  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocBuilder<IndividualCharacterBloc, IndividualCharacterState>(
          builder: (context, state) {
        if (state is IndividualCharacterFetched) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Card(
              color: Colors.grey.shade200,
              elevation: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      "Detalle",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Style.Colors.darkBlue,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      state.individualCharacter.image,
                      scale: 1.4,
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
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.individualCharacter.name,
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: Style.Colors.darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 7,
                          ),


                          Text(
                            state.individualCharacter.gender,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            state.individualCharacter.origin.name,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            state.individualCharacter.location.name,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            state.individualCharacter.status,
                            style: const TextStyle(fontSize: 14.0),
                          ),const SizedBox(
                            height: 7,
                          ),
                          Text(
                            state.individualCharacter.episode[0],
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          ///EN CASO DE QUE NO SE PUEDA CARGAR
          return const Center(
            child: CircularProgressIndicator(
              color: Style.Colors.mainColor,
            ),
          );
        }
      }),
    );
  }
}
