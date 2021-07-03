import '../services/location.dart';
import '../services/networking.dart';


const apiKey = '9eaa1177ef441f4d51a8a8236a191344';
const openWeatherMap = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(url: '$openWeatherMap?'
        'q=$cityName&appid=$apiKey&units=metric');

    return await networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    LocationService location = LocationService(); // ../services/location.dart
    await location.getCurrentPosition();

    NetworkHelper networkHelper = NetworkHelper(url: '$openWeatherMap?'
        'lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&'
        'units=metric');

    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
