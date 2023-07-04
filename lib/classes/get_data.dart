import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class AllCountries {
  final String flag;
  final String countryName;
  final String link;

  AllCountries({
    required this.countryName,
    required this.flag,
    required this.link,
  });

  late bool isDayTime;
  late String timeNow;
  late String timeZone;

  getData() async {
    String location = link.isEmpty
        ? 'http://worldtimeapi.org/api/ip'
        : "http://worldtimeapi.org/api/timezone/$link";
    Response receivedDataApi = await get(Uri.parse(location));
    Map receivedData = jsonDecode(receivedDataApi.body);

    DateTime dateTime = DateTime.parse(receivedData['utc_datetime']);

    int offset = int.parse(receivedData['utc_offset'].substring(0, 3));

    DateTime time = dateTime.add(Duration(hours: offset));

    if (time.hour > 5 && time.hour < 18) {
      isDayTime = true;
    } else {
      isDayTime = false;
    }

    timeNow = DateFormat('hh:mm a').format(time);

    timeZone = receivedData['timezone'];
  }

  static List<AllCountries> allCountries = [
    AllCountries(
        link: 'Africa/Cairo', countryName: 'Egypt - Cairo', flag: 'egy.png'),
    AllCountries(
        link: 'Asia/Riyadh',
        countryName: 'Saudi Arabia - Riyadh',
        flag: 'sa.png'),
    AllCountries(
        link: 'Asia/Dubai', countryName: 'Emirates - Dubai', flag: 'uae.png'),
    AllCountries(link: 'Asia/Qatar', countryName: 'Qatar', flag: 'qatar.png'),
    AllCountries(
        link: 'Africa/Tunis',
        countryName: 'Tunisia - Tunis',
        flag: 'tunisia.png'),
    AllCountries(
        link: 'Africa/Algiers',
        countryName: 'Algeria - Algiers',
        flag: 'algeria.png'),
    AllCountries(
        link: 'Australia/Sydney',
        countryName: 'Australia - Sydney',
        flag: 'australia.png'),
    AllCountries(
        link: 'America/Toronto',
        countryName: 'Canada - Toronto',
        flag: 'canada.png'),
  ];
}
