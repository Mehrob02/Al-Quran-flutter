import 'package:dio/dio.dart';

Future<Map<String, dynamic>> fetchPrayerTimes(String city, String country) async {
  final apiUrl = 'http://api.aladhan.com/v1/calendarByCity?city=$city&country=$country';

  try {
    final response = await Dio().get(apiUrl);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return response.data;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load prayer times');
    }
  } catch (e) {
    throw Exception('Failed to load prayer times: $e');
  }
}
