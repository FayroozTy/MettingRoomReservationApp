import 'dart:convert';

import 'package:reservation_app/Screen/BookingScreens/AdminsScreen/Orders/Models/OrdersModel.dart';

import '../../../../../Utli/Constatns.dart';
import '../../../../../Utli/network/network_service.dart';



class OrdersRepository {

  final String _baseUrl =BaseURL  + '/api/Booking/BookingFullList';


  Future <List<OrdersModel>> getList() async {

    print(_baseUrl);
    final response = await NetworkService.sendRequest(

        requestType: RequestType.get, url: _baseUrl);
    print(response?.body);

    return  (jsonDecode(response!.body) as List<dynamic>)
        .map((e) => OrdersModel.fromJson(e))
        .toList();;


    // return NetworkHelper.filterResponse(
    //     callBack: (json) => (response?.body as List).map((x) => PumpingSchedule.fromJson(x))
    //         .toList(),
    //     response: response,
    //     onFailureCallBackWithMessage: (errorType, msg) =>
    //         throw Exception('An Error has happened. $errorType - $msg'));
  }
}
