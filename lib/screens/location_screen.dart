import 'package:flutter/material.dart';
import 'package:upstrom/utilities/constants.dart';
import 'package:upstrom/services/weather.dart';
import 'package:upstrom/screens/city_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int? temperature;
  String? cityname;
  String? In;
  String? message;
  String? description;
  var wind;
  int? minTemp;
  int? maxTemp;
  int? humidity;
  int? pressure;
  String url = clearskye;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  String setimage(int condition) {
    if (condition >= 200 && condition < 300) {
      return thunderstorm;
    } else if (condition >= 300 && condition < 500) {
      return drizzle;
    } else if (condition >= 500 && condition < 600) {
      return rain;
    } else if (condition >= 600 && condition < 700) {
      return snow;
    } else if (condition >= 700 && condition < 800) {
      return mist;
    } else if (condition == 800) {
      return clearskye;
    } else if (condition > 800) {
      return cloud;
    } else {
      return sand;
    }
  }

  void updateUI(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        minTemp = 0;
        maxTemp = 0;
        description = 'Error';
        message = 'Unable to get weather data';
        cityname = '';
        In = '';
        wind = 0;
        humidity = 0;
        pressure=0;
        return;
      }
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherdata['weather'][0]['id'];
      In = 'in';
      description = weatherdata['weather'][0]['description'];
      description = description?.toUpperCase();
      wind = weatherdata['wind']['speed'];
      temp = weatherdata['main']['temp_min'];
      minTemp = temp.toInt();
      temp = weatherdata['main']['temp_max'];
      humidity = weatherdata['main']['humidity'];
      pressure = weatherdata['main']['pressure'];
      maxTemp = temp.toInt();
      message = weatherModel.getMessage(condition!);
      cityname = weatherdata['name'];
      url = setimage(condition);
      print(weatherdata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CachedNetworkImage(
          placeholder: (context, url) => Center(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset('images/error.png'))),
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.7), BlendMode.dstATop),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          onPressed: () async {
                            var typename = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CityScreen();
                                },
                              ),
                            );
                            if (typename != null) {
                              var weatherdata =
                                  await weatherModel.getcityweather(typename);
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
                    padding: const EdgeInsets.only(left: 15, top: 30),
                    child: Text(
                      cityname!,
                      style: kTempTextStyle2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: RichText(
                      text: TextSpan(
                        text: '$temperature°',
                        style: kTempTextStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text: '$description',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('$maxTemp°-$minTemp°',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: RichText(
                      text: TextSpan(
                        text: 'Wind:- ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' $wind m/s',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: RichText(
                      text: TextSpan(
                        text: 'Humidity:- ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' $humidity%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: RichText(
                      text: TextSpan(
                        text: 'Pressure:- ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' $pressure hPa',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 40),
                    child: Container(
                      child: Text(
                        "$message",
                        textAlign: TextAlign.left,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
