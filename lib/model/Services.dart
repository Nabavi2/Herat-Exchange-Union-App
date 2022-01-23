import 'dart:convert';

import 'model.dart';
import 'package:http/http.dart' as http;

class Services {
  static Uri url =
      Uri.parse("http://heratexchangeunion.com/wp-json/wp/v2/exchanger");

  static Future<List<Exchange>> getData() async {
    try {
      final response = await http.get(url);
      if(response.statusCode==200){
       // final parsed=json.decode(response.body).cast<Map<String,dynamic>>();
    List<Exchange>list=parseMeta(response.body);

       // print(response.body.toLowerCase());

        return list;
      }else{
        throw Exception ("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Exchange> parseMeta(String body) {

    final parsed=json.decode(body).cast<Map<String,dynamic>>();

    return parsed.map<Exchange>((json)=>Exchange.fromMap(json)).toList();
  }
}
