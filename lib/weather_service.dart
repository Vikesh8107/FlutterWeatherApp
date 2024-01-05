import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String apiKey = 'ae1bb8f843dc46269ea204531240401';

  Future<dynamic> getWeather(String location) async {
    var url = Uri.parse('http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$location&days=7');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
