import 'package:flutter/material.dart';
import 'package:upstrom/utilities/constants.dart';
import 'package:upstrom/services/weather.dart';
import 'package:upstrom/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int? temperature;
  String? weathericon;
  String? cityname;
  String? In;
  String? message;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        weathericon = 'Error';
        message = 'Unable to get weather data';
        cityname = '';
        In = '';
        return;
      }
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherdata['weather'][0]['id'];
      In = 'in';
      weathericon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(temperature!);
      cityname = weatherdata['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        var weatherData =
                            await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      },
                      icon: const Icon(
                        Icons.near_me,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () async{
                        var typename = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if(typename!=null){
                          var weatherdata = await weatherModel.getcityweather(typename);
                          updateUI(weatherdata);
                        }
                      },
                      icon: const Icon(
                        Icons.location_city,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "$message $In $cityname!",
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
