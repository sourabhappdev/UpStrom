import 'package:flutter/material.dart';
import 'package:upstrom/utilities/constants.dart';
import 'package:upstrom/services/weather.dart';
import 'package:upstrom/screens/city_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      print(weatherdata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CachedNetworkImage(
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.asset('images/error'),
        imageUrl: 'https://images.unsplash.com/photo-1682685797088-283404e24b9d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        imageBuilder:(context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider,
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7), BlendMode.dstATop),
            ),
          ),

          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: IconButton(
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
                  padding: EdgeInsets.only(left: 15.0,top: 50),
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
      ),
    );
  }
}
