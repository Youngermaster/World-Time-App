import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  String location, time, flag, url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response);
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = _convertTime(dateTime, offset);

      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('[ERROR] -> $e')
      time = 'could not get that data';
    }
  }

  DateTime _convertTime(String dateTime, String offset) {
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    return now;
  }
}
