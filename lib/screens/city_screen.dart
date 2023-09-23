import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upstrom/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityname;
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
                  child: Image.asset('images/error'))),
          imageUrl:
          'https://images.unsplash.com/photo-1527672809634-04ed36500acd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
          imageBuilder:(context, imageProvider) => Container(
           height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.7), BlendMode.dstATop),
                ),
              ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextfieldInputDecoration,
                      onChanged: (value){
                        cityname=value;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context,cityname);
                    },
                    child: Text(
                      'Get Weather',
                      style: kButtonTextStyle,
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
