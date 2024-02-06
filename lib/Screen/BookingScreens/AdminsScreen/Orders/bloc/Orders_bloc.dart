import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservation_app/Screen/BookingScreens/AdminsScreen/Orders/Models/OrdersModel.dart';

import '../repository/OrderRepository.dart';




part 'Orders_event.dart';

part 'Orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _repository;

  OrdersBloc(this._repository) : super(OrdersLoadingState()) {
    on<LoadOrdersEvent>((event, emit) async {
      emit(OrdersLoadingState());
      try {
        final model = await _repository.getList();
        emit(OrdersLoadState(model));
      } catch (e) {
        emit(OrdersErrorState(e.toString()));
      }
    });
  }
}
