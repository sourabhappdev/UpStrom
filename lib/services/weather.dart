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


  String getMessage(int cond) {
    if (cond <300) {
      return 'Postpone your travel or trip or activity till end of thunderstorm!';
    } else if (cond < 500) {
      return 'Go out and let the little drops of rain wash all your sorrows and worries!';
    }else if (cond < 600) {
      return 'Monsoon Make the love more Romantic..!!';
    }else if (cond < 700) {
      return 'Be like snow — cold but beautiful.!!';
    } else if (cond < 800) {
      return 'Love is a fog that burns with the first daylight of reality.';
    } else if (cond == 800) {
      return 'Smell the sea and feel the sky, Let your soul and spirit fly.';
    } else if (cond < 900) {
      return 'Don\'t forget,Beautiful sunsets need cloudy Skies';
    } else {
      return 'Smell the sea and feel the sky, Let your soul and spirit fly.';
    }
  }
}