import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/model.dart';

class DataService {
  Future<Weather> fetchData(String cityName) async {
    try {
      //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
      final queryParameters = {
        'q': cityName,
        'appId': '537a5023e4794023d92bf44a802a2b70',
        'units': 'metric',
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data weather');
      }
    } catch (e) {
      rethrow;
    }
  }
}
