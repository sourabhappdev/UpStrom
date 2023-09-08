import 'dart:convert';
import 'package:http/http.dart' as http;


class NetworkHelper{

  NetworkHelper(this.urlN);

  final String urlN;

  Future getData() async{

    String url = urlN;

    final uri = Uri.parse(url);

    http.Response response = await http.get(uri);


    if(response.statusCode==200){
      String data = response.body;

      return jsonDecode(data);

    }
    else{
      print(response.statusCode);

    }

  }

}