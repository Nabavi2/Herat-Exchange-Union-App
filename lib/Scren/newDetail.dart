import 'dart:convert';

import 'package:exchanger/config/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';

class NewsDetail extends StatelessWidget {
  final int index;
  NewsDetail({this.index});

  Future<List<dynamic>> _getData() async {
    Uri url = Uri.parse('http://heratexchangeunion.com/wp-json/wp/v2/posts?categories=27');
    Response response = await get(
        url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var delegate = Localization.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            delegate.translateValue("NewsDetails"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'IranSans',
              fontSize: 14.0,
              color: Color(0xFF585858),
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<dynamic> data = snapshot.data;
              if (data.length > 0) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Html(
                            data: snapshot.data[index]['content']['rendered']),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                        child: Container(
                          child: Center(
                              child: Text('هیچ اطلاعاتی موجود نمیباشد!')),
                          height: MediaQuery.of(context).size.height / 1.4,
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Center(
                      child: Container(
                        child:
                            Center(child: Text('هیچ اطلاعاتی موجود نمیباشد!')),
                        height: MediaQuery.of(context).size.height / 1.4,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
