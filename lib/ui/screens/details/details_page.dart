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
        title: const Text("Rick Test"),
        backgroundColor: Style.Colors.mainColor,
      ),
      body: BlocBuilder<IndividualCharacterBloc, IndividualCharacterState>(
          builder: (context, state) {
        if (state is IndividualCharacterFetched) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Card(
              color: Colors.grey.shade200,
              elevation: 1,
              child: ListTile(
                title: Image.network(
                  state.individualCharacter.image,
                  scale: 1.7,
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
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        state.individualCharacter.name,
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
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
                      ),Text(
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
                        state.individualCharacter.episode[0],
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        else{
          ///EN CASO DE QUE NO SE PUEDA CARGAR
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
