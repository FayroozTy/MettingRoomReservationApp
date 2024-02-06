import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Model/user/BookingFullListForRoom.dart';
import '../repository/bookingListRepository.dart';




part 'bookingListForRoom_event.dart';

part 'bookingListForRoom_state.dart';

class bookingListForRoomBloc extends Bloc<bookingListForRoomEvent, bookingListForRoomState> {
  final bookingListForRoomRepository _repository;

  bookingListForRoomBloc(this._repository) : super(bookingListForRoomLoadingState()) {
    on<LoadbookingListForRoomEvent>((event, emit) async {
      emit(bookingListForRoomLoadingState());
      try {
        final model = await _repository.getList();
        emit(bookingListForRoomLoadState(model));
      } catch (e) {
        emit(bookingListForRoomErrorState(e.toString()));
      }
    });
  }
}
