import 'dart:convert';


import '../../../../../Model/user/BookingFullListForRoom.dart';
import '../../../../../Utli/Constatns.dart';
import '../../../../../Utli/network/network_service.dart';
import '../ui/BookingListPage.dart';




class bookingListForRoomRepository {







  final String _baseUrl =BaseURL  + '/api/Booking/BookingFullListForRoom/1';


  Future <List<BookingFullListForRoom>> getList() async {

    print(_baseUrl);
    final response = await NetworkService.sendRequest(

        requestType: RequestType.get, url: _baseUrl);
    print(response?.body);

    return  (jsonDecode(response!.body) as List<dynamic>)
        .map((e) => BookingFullListForRoom.fromJson(e))
        .toList();;


    // return NetworkHelper.filterResponse(
    //     callBack: (json) => (response?.body as List).map((x) => PumpingSchedule.fromJson(x))
    //         .toList(),
    //     response: response,
    //     onFailureCallBackWithMessage: (errorType, msg) =>
    //         throw Exception('An Error has happened. $errorType - $msg'));
  }
}
