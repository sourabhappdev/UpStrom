import '../services/location..dart';
import 'package:upstrom/services/networking.dart';


const apiKey = '76e576fcf6a4e6c088500d7b6f0d2898';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getcityweather(String cityname) async{

    var url = '$openWeatherMapURL?q=$cityname&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  Future<dynamic> getLocationWeather() async{

    Location location = Location();
    await location.getcurrentlocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;



  }




  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case it rain';
    }
  }
}