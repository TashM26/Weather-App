import 'dart:convert';
import 'dart:io';

import 'package:weather_app/domain/weather_json/coords.dart';
import 'package:weather_app/domain/weather_json/weather_data.dart';

import '../../data/api_key/api_key.dart';

class WeatherApi {
  static Future<Coords?> getCoords(String cityName) async {
    Uri url = Uri(
      scheme: 'https',
      host: ApiKey.host,
      path: 'data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'appid': ApiKey.apiKey,
        'lang': 'ru',
      },
    );
    try {
      final data = await _jsonRequest(url);
      final coords = Coords.fromJson(data);
      return coords;
    } catch (e) {
      print(e);
    }
  }

  static Future<WeatherData?> getWeather(Coords? coords) async {
    if (coords != null) {
      Uri url = Uri(
        scheme: 'https',
        host: ApiKey.host,
        path: 'data/2.5/onecall',
        queryParameters: {
          'appid': ApiKey.apiKey,
          'lang': 'ru',
          'lon': coords.lon.toString(),
          'lat': coords.lat.toString(),
          'exclude': 'hourly,minutely',
        },
      );
      final data = await _jsonRequest(url);
      final weatherData = WeatherData.fromJson(data);

      return weatherData;
    }
  }

  static Future<Map<String, dynamic>> _jsonRequest(Uri url) async {
    try {
      final client = HttpClient();
      final request = await client.getUrl(url);
      final response = await request.close();
      final json = await response.transform(utf8.decoder).toList();
      final jsonString = json.join();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      client.close();
      return data;
    } catch (e) {
      print(e);
    }

    return {};
  }
}
