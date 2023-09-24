
import 'package:flutter/material.dart';
import 'package:upstrom/screens/location_screen.dart';

import '../services/weather.dart';

class Splash extends StatefulWidget {

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override

  void initState() {
    super.initState();
    getlocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/weather.gif'),
          const Text('UpStrom',
            style: TextStyle(
                color: Colors.deepPurpleAccent,
              fontSize: 35,
              fontFamily: 'Spartan MB',
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('A Weather App',
              style: TextStyle(
                letterSpacing: 1.3,
                color: Colors.grey,
                fontFamily: 'Spartan MB',
                fontSize: 25,
              ),),

        ],
      ),
    );
  }


void getlocationData() async {
  var weatherData = await WeatherModel().getLocationWeather();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return LocationScreen(
      locationWeather: weatherData,
    );
  }));
}



}