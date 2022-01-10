// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class DetailsScreen extends StatelessWidget {
//   const DetailsScreen({Key? key, required this.userId, required this.userName, required this.userEmail, required this.userPhone}) : super(key: key);
//   final int userId;
//   final String userName;
//   final String userEmail;
//   final String userPhone;
//
//
//   ///BLOC PARA LLENAR LA BASE DE DATOS POR MEDIO DEL API
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: BlocBuilder<PublicationBloc, PublicationState>(builder: (context, state) {
//           if (state is PublicationsFetched) {
//             return DetailsPage(
//                 userId: userId,
//                 userName: userName,
//                 userEmail: userEmail,
//                 userPhone: userPhone
//             );
//           }
//           else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         }));
//   }
// }