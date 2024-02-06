part of 'Orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class LoadOrdersEvent extends OrdersEvent {
  @override
  List<Object?> get props => [];
}
