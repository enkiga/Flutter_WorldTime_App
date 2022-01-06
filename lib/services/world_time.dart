import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for UI
  late String time; //time in the location
  late String flag; //url to asset flag icon
  late String url; //location url for API endpoint
  late bool isDaytime; //true or false is daytime

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //Make the request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //Get Properties from Data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //Create DateTime Object

      DateTime now = DateTime.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));

      //Set Time Property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get Time Data';
    }
  }
}
