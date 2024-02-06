part of 'Orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class OrdersLoadingState extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrdersErrorState extends OrdersState {
  final String message;

  const OrdersErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class OrdersLoadState extends OrdersState {
  final List<OrdersModel> model;

  const OrdersLoadState(this.model);

  @override
  List<Object?> get props => [model];
}
