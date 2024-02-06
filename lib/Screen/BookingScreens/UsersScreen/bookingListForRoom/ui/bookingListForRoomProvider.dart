import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/bookingListRepository.dart';
import 'BookingListPage.dart';



class bookingListForRoomProvider extends StatelessWidget {
  final int roomid;

  bookingListForRoomProvider(this.roomid, this.roomName);

  final String roomName;


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>bookingListForRoomRepository(),

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: bookingLisScreen(this.roomid, this.roomName),

      ),
    );
  }
}
