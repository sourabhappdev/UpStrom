import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upstrom/screens/location_screen.dart';
import 'package:upstrom/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocationData();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading Please Wait',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          const SpinKitDoubleBounce(
            color: Colors.black,
            size: 100,
          ),
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
