# Weather Forecast App

## Overview

This Flutter project is a simple weather forecast application that utilizes a mock REST API to fetch and display weather data for the present day and the next 5 days. The app is designed to showcase basic Flutter development skills, including API integration, error handling, and UI implementation.

## Requirements

To run this project, ensure that you have Flutter installed on your machine. If not, you can follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install) to set up your development environment.

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/forecast_app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd forecast_app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Implementation Details

### API Integration

The app uses the http package to simulate API requests. The API endpoint is a mock service that provides weather data for the specified location.

```dart
// Example API request using http package
Future<WeatherData> fetchWeatherData(String location) async {
  final response = await http.get(Uri.parse('https://api.mockweather.com/$location'));

  if (response.statusCode == 200) {
    // Parse and return weather data
    return WeatherData.fromJson(json.decode(response.body));
  } else {
    // Handle error
    throw Exception('Failed to load weather data');
  }
}
```

### UI Design

The UI displays weather details for the present day and the next 5 days. It includes temperature, condition, humidity, and other relevant information. A loading indicator is shown while fetching data, and error messages are displayed for unsuccessful API requests or invalid responses.

### Project Structure

```
/lib
  ├── main.dart
  ├── models
  │    └── weather_data.dart
  ├── services
  │    └── api_service.dart
  ├── screens
  │    └── weather_screen.dart
  └── widgets
       └── weather_card.dart
```

- `main.dart`: Entry point of the Flutter app.
- `models/weather_data.dart`: Data model for storing weather information.
- `services/api_service.dart`: Service for handling API requests.
- `screens/weather_screen.dart`: Main screen displaying weather information.
- `widgets/weather_card.dart`: Reusable widget for displaying weather details.

## Additional Notes

- Ensure that your device/emulator has internet access to fetch weather data.
- This app is developed for educational purposes and uses a mock API for demonstration.

Feel free to explore and modify the code according to your preferences or add additional features as needed. If you encounter any issues or have questions, please don't hesitate to reach out.
