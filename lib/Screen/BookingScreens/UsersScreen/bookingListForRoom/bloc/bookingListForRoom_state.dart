part of 'bookingListForRoom_bloc.dart';

abstract class bookingListForRoomState extends Equatable {
  const bookingListForRoomState();
}

class bookingListForRoomLoadingState extends bookingListForRoomState {
  @override
  List<Object?> get props => [];
}

class bookingListForRoomErrorState extends bookingListForRoomState {
  final String message;

  const bookingListForRoomErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class bookingListForRoomLoadState extends bookingListForRoomState {
  final List<BookingFullListForRoom> model;

  const bookingListForRoomLoadState(this.model);

  @override
  List<Object?> get props => [model];
}
