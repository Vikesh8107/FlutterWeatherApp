import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final WeatherService _weatherService = WeatherService();
  String _location = 'London';
  dynamic _weatherData;

  get value => null;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  _fetchWeatherData() async {
    var weatherData = await _weatherService.getWeather(_location);
    setState(() {
      _weatherData = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Location',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _location = value;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _fetchWeatherData();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius as needed
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10), // Adjust the padding as needed
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                          width: 4), // Adjust the width as needed for spacing
                      Text(
                        'Search',
                        style: TextStyle(
                            fontSize: 16), // Adjust the font size as needed
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _weatherData == null
              ? CircularProgressIndicator()
              : Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 20), // Add desired padding value
                    child: ListView.builder(
                      itemCount: _weatherData['forecast']['forecastday'].length,
                      itemBuilder: (context, index) {
                        var day =
                            _weatherData['forecast']['forecastday'][index];
                        return index == 0
                            ? _buildBigCard(day)
                            : _buildSmallCard(day);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildBigCard(dynamic day) {
    bool isPresentDay =
        day['date'] == _weatherData['forecast']['forecastday'][0]['date'];

    return Card(
      color: isPresentDay
          ? Color.fromARGB(255, 140, 203, 233)
          : Color.fromARGB(255, 230, 180, 239),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Text(
            day['date'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 35),
          Text(
            '${day['day']['condition']['text']}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '${day['day']['maxtemp_c']}°C',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(dynamic day) {
    bool isPresentDay =
        day['date'] == _weatherData['forecast']['forecastday'][0]['date'];

    return Card(
      color:
          isPresentDay ? Colors.lightBlue : Color.fromARGB(255, 233, 165, 245),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                '${day['day']['condition']['text']}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 244, 143, 54),
            ),
            child: Center(
              child: Text(
                '${day['day']['maxtemp_c']}°C',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 8), // Add some spacing between temperature and date
          Text(
            day['date'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
