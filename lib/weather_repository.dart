import 'dart:convert';

import 'package:weather_app/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<WeatherModel> getWeather(String city) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=a0d7d224b1443923e06f75a8af696a39&units=metric'),
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
