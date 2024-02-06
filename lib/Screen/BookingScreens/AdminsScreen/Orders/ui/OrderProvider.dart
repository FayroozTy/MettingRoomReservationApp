import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/OrderRepository.dart';
import 'OrdersPage.dart';


class OrdersProvider extends StatelessWidget {
  const OrdersProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OrdersRepository(),

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home:  OrdersListScreen(),

      ),
    );
  }
}
