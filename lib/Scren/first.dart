import 'dart:async';
import 'dart:convert';

import 'package:exchanger/config/localization/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart' as intl;

// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../card.dart';

class ListData extends StatefulWidget {
  ListData({
    Key key,
  }) : super(key: key);
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  StreamController _dataController;

  Future<List<dynamic>> _getData({String date}) async {
    if (date == null || date == '') {
      Uri url = Uri.parse('http://heratexchangeunion.com/wp-json/wp/v2/momentexchange');
      Response response = await get(
          url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print(response.statusCode);
        return null;
      }
    } else {
      String newDate = date.split(' ')[0];
      Uri url = Uri.parse('http://heratexchangeunion.com/wp-json/wp/v2/momentexchange?after=${newDate}T00:00:00&before=${newDate}T23:59:60');
      Response response = await get(
          url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        controller.jumpTo(2.0);
        listSize = 1;
        lastOne = false;
        return data;
      } else {
        print(response.statusCode);
        return null;
      }
    }
  }

  loadData({String date}) async {
    _getData(date: date).then((res) {
      _dataController.add(res);
    });
  }

  ScrollController controller;
  int listSize = 1;
  bool lastOne = false;
  void _scrollListener() {
    if (controller.position.extentAfter < 1) {
      if (lastOne != true) {
        setState(() {
          listSize += 1;
        });
      } else if (lastOne == true) {
        return null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _dataController = StreamController();
    loadData();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var delegate = Localization.of(context);
    bool isEnglish = delegate.locale == Locale('en', 'US');
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 30),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2000, 1, 1),
                          maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        loadData(date: date.toString());
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: isEnglish ? 0 : 12, left: isEnglish ? 12 : 0,),
                      child:
                          Icon(Icons.date_range, color: Colors.grey, size: 23),
                    )),
                //sizebox
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      delegate.translateValue("Sell"),
                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: isEnglish ? 0 : 30, left: isEnglish ? 30 : 0,),
                  child: Text(
                    delegate.translateValue("Buy"),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ), ////sizebox
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      delegate.translateValue("Currency"),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    delegate.translateValue("Country"),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ), //country name
              ],
            ),
          ),
        ),
      ),
//      body: _myListView(context),
      body: RefreshIndicator(
        onRefresh: () => loadData(),
        child: StreamBuilder(
          stream: _dataController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<dynamic> data = snapshot.data;
              if (data.length > 0) {
                return ListView.builder(
                  controller: controller,
                  itemCount: listSize,
                  itemBuilder: (context, i) {
                    if ((data.length - 1) == i) {
                      lastOne = true;
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          margin: EdgeInsets.only(top: 20),
                          // elevation: 3,
                          decoration: BoxDecoration(
                              // border: Border.all(
                              //     width: 1, color: Color(0xFF262AAA)),
                              color: Colors.white,
                              // color: Color(0xFF5053A8),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 1,
                                    offset: Offset(0, 1)),
                              ]),
                          // color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  isEnglish ? " ${intl.DateFormat('EEEE').format(DateTime.parse(snapshot.data[i]['date']))} ${(snapshot.data[i]['date'] as String).split('T')[0]}" : "<< " +
                                      snapshot.data[i]['title']['rendered']
                                          .split("(")[1]
                                          .split(')')[0] +
                                      " >>",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF585858),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                !isEnglish ? Text(
                                  snapshot.data[i]['date']+" "+
                                      delegate.translateValue("ChangeRateDate"),
                                  textAlign: TextAlign.center,
                                  textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                ) :
                                Text(
                                  delegate.translateValue("ChangeRateDate")+" "+
                                      (snapshot.data[i]['date'] as String).replaceAll('T', ' '),
                                  textAlign: TextAlign.center,
                                  textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                ),
                              ],
                            ),
                          ),
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Dollar"),
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDollar'][0],
                          curSell: snapshot.data[i]['metadata']['SellDollar']
                              [0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Yuro"),
                          image: 'images/euro.png',
                          curBuy: snapshot.data[i]['metadata']['BuyYuro'][0],
                          curSell: snapshot.data[i]['metadata']['SellYuro'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Pond"),
                          image: 'images/pound.png',
                          curBuy: snapshot.data[i]['metadata']['Buypuond'][0],
                          curSell: snapshot.data[i]['metadata']['Sellpuond'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Toman"),
                          image: 'images/toman.png',
                          curBuy: snapshot.data[i]['metadata']['BuyToman'][0],
                          curSell: snapshot.data[i]['metadata']['sellToman'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Caldar"),
                          image: 'images/caldar.png',
                          curBuy: snapshot.data[i]['metadata']['Buycaldar'][0],
                          curSell: snapshot.data[i]['metadata']['Sellcaldar']
                              [0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Ropya"),
                          image: 'images/rupees.png',
                          curBuy: snapshot.data[i]['metadata']['BuyRopya'][0],
                          curSell: snapshot.data[i]['metadata']['SellRopya'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Derham"),
                          image: 'images/darham.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDeham'][0],
                          curSell: snapshot.data[i]['metadata']['SellDeham'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Real"),
                          image: 'images/riyal.png',
                          curBuy: snapshot.data[i]['metadata']['BuyReal'][0],
                          curSell: snapshot.data[i]['metadata']['SellReal'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Frank"),
                          image: 'images/frank.png',
                          curBuy: snapshot.data[i]['metadata']['BuyFrank'][0],
                          curSell: snapshot.data[i]['metadata']['SellFrank'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("DollarCanada"),
                          image: 'images/canada.png',
                          curBuy: snapshot.data[i]['metadata']
                              ['Buydollarcanada'][0],
                          curSell: snapshot.data[i]['metadata']
                              ['Selldollarcanada'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("DolllarAust"),
                          image: 'images/australia.png',
                          curBuy: snapshot.data[i]['metadata']['BuyastrDollar']
                              [0],
                          curSell: snapshot.data[i]['metadata']
                              ['SellastrDollar'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("Crone"),
                          image: 'images/crone.png',
                          curBuy: snapshot.data[i]['metadata']['Buycrone'][0],
                          curSell: snapshot.data[i]['metadata']['Sellcrone'][0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("DollarToToman"),
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDatoTo'][0],
                          curSell: snapshot.data[i]['metadata']['SellDatoTo']
                              [0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("DollarToCaldar"),
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyCaToDo'][0],
                          curSell: snapshot.data[i]['metadata']['SellCaToDo']
                              [0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("DollarToDerham"),
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuyDoToDar'][0],
                          curSell: snapshot.data[i]['metadata']['SellDoToDar']
                              [0],
                        ),
                        CurrencyCard(
                          curName: delegate.translateValue("DollarToYuro"),
                          image: 'images/usa.png',
                          curBuy: snapshot.data[i]['metadata']['BuydorToYu'][0],
                          curSell: snapshot.data[i]['metadata']['SelldorToYu']
                              [0],
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                        child: Container(
                          child: Center(
                              child: Text(delegate.translateValue("NoData"))),
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
                            Center(child: Text(delegate.translateValue("NoData"))),
                        height: MediaQuery.of(context).size.height / 1.4,
                      ),
                    ),
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
                            child: Text(delegate.translateValue("NoData"))),
                        height: MediaQuery.of(context).size.height / 1.4,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
