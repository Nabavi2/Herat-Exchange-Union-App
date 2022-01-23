import 'dart:convert';
import 'dart:io';

import 'package:exchanger/config/localization/admob_services.dart';
import 'package:exchanger/config/localization/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';

class CalCulate extends StatefulWidget {
  CalCulate();

  @override
  CalCulateState createState() => CalCulateState();
}

class CalCulateState extends State<CalCulate> {



  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2),
    );
  }

  Future<List<dynamic>> _getData() async {
    Uri url = Uri.parse('http://heratexchangeunion.com/wp-json/wp/v2/momentexchange');
      Response response =
      await get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print(response.statusCode);
        return null;
      }
  }

  bool calculating = false;
  String output = '';
  String buyOutput = '';


  void _calculate(var delegate) async {
    var data = await _getData().whenComplete((){
      setState(() {
        calculating = false;
      });
    });


    if(input != 0 && input != null) {
      if (value == 1) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDollar'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Usd")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDollar'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Usd")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 2) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellDollar'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Usd")}';
          buyTotal = input / double.parse(data[0]['metadata']['BuyDollar'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Usd")}';
        });
      }
      if (value == 3) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellYuro'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Euro")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyYuro'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Euro")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 4) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellYuro'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Euro")}';
          buyTotal = input / double.parse(data[0]['metadata']['BuyYuro'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Euro")}';
        });
      }
      if (value == 5) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Sellpuond'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Pound")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['Buypuond'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Pound")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 6) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['Sellpuond'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Pound")}';
          buyTotal = input / double.parse(data[0]['metadata']['Buypuond'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Pound")}';
        });
      }
      if (value == 7) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['sellToman'][0]) / 1000;
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("IraninanToman")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyToman'][0]) / 1000;
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("IraninanToman")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 8) {
        setState(() {
          total = input * 1000 / double.parse(data[0]['metadata']['sellToman'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("IraninanToman")}';
          buyTotal = input * 1000 / double.parse(data[0]['metadata']['BuyToman'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("IraninanToman")}';
        });
      }
      if (value == 9) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Sellcaldar'][0]) / 1000;
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("PakistaniCaldar")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['Buycaldar'][0]) / 1000;
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("PakistaniCaldar")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 10) {
        setState(() {
          total = input * 1000 / double.parse(data[0]['metadata']['Sellcaldar'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("PakistaniCaldar")}';
          buyTotal = input * 1000 / double.parse(data[0]['metadata']['Buycaldar'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("PakistaniCaldar")}';
        });
      }
      if (value == 11) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellRopya'][0]) / 1000;
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Rupees")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyRopya'][0]) / 1000;
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Rupees")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 12) {
        setState(() {
          total = input * 1000 / double.parse(data[0]['metadata']['SellRopya'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Rupees")}';
          buyTotal = input * 1000 / double.parse(data[0]['metadata']['BuyRopya'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Rupees")}';
        });
      }
      if (value == 13) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDeham'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("UaeDerham")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDeham'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("UaeDerham")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 14) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellDeham'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("UaeDerham")}';
          buyTotal = input / double.parse(data[0]['metadata']['BuyDeham'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("UaeDerham")}';
        });
      }
      if (value == 15) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellReal'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("SaudiReal")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyReal'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("SaudiReal")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 16) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellReal'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("SaudiReal")}';
          buyTotal = input / double.parse(data[0]['metadata']['BuyReal'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("SaudiReal")}';
        });
      }
      if (value == 17) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellFrank'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("DenmarkFrank")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyFrank'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("DenmarkFrank")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 18) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellFrank'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("DenmarkFrank")}';
          buyTotal = input / double.parse(data[0]['metadata']['BuyFrank'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("DenmarkFrank")}';
        });
      }
      if (value == 19) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Selldollarcanada'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Cad")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['Buydollarcanada'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Cad")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 20) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['Selldollarcanada'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Cad")}';
          buyTotal = input / double.parse(data[0]['metadata']['Buydollarcanada'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Cad")}';
        });
      }
      if (value == 21) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellastrDollar'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Aud")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyastrDollar'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Aud")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 22) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['SellastrDollar'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Aud")}';
          buyTotal = input / double.parse(data[0]['metadata']['BuyastrDollar'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Aud")}';
        });
      }
      if (value == 23) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['Sellcrone'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("NorwayCrone")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
          buyTotal = input * double.parse(data[0]['metadata']['Buycrone'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("NorwayCrone")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Afn")}';
        });
      }
      if (value == 24) {
        setState(() {
          total = input / double.parse(data[0]['metadata']['Sellcrone'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Afn")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("NorwayCrone")}';
          buyTotal = input / double.parse(data[0]['metadata']['Buycrone'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Afn")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("NorwayCrone")}';
        });
      }
      if (value == 25) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDatoTo'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Usd")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("IraninanToman")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDatoTo'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Usd")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("IraninanToman")}';
        });
      }
      if (value == 26) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellCaToDo'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Usd")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("PakistaniCaldar")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyCaToDo'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Usd")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("PakistaniCaldar")}';
        });
      }
      if (value == 27) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SellDoToDar'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Usd")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("UaeDerham")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuyDoToDar'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Usd")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("UaeDerham")}';
        });
      }
      if (value == 28) {
        setState(() {
          total = input * double.parse(data[0]['metadata']['SelldorToYu'][0]);
          output = ' ${delegate.translateValue("Buy")}: $input ${delegate.translateValue("Usd")} = ${total.toStringAsFixed(3)} ${delegate.translateValue("Euro")}';
          buyTotal = input * double.parse(data[0]['metadata']['BuydorToYu'][0]);
          buyOutput = ' ${delegate.translateValue("Sell")}: $input ${delegate.translateValue("Usd")} = ${buyTotal.toStringAsFixed(3)} ${delegate.translateValue("Euro")}';
        });
      }
    }
  }

  int value = 1;
  double total = 0;
  double buyTotal = 0;
  double input = 0;

  TextEditingController controller = TextEditingController();

  final myBanner = BannerAd(
    adUnitId: Platform.isAndroid
        ? 'ca-app-pub-1752138406175532/6146910956'
        : 'ca-app-pub-1752138406175532/6407793074',
    size: AdSize.fullBanner,
    request: AdRequest(),
    //listener: null,
    listener: BannerAdListener()
  );

  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-1752138406175532/9428708080'
          : 'ca-app-pub-1752138406175532/2085404688',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;

          _interstitialAd.show();
          _interstitialAd = null;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= 3) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      _createInterstitialAd();
    }
  }

  @override
  void initState() {
    myBanner.load();
    super.initState();
  }


  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    var size = MediaQuery.of(context).size;
    var delegate = Localization.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Column(
            // align the text to the left instead of centered
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.1,
              ),
              Card(
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    items: [
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/usa.png', width: 35, height: 35,),
                                Text(delegate.translateValue("DollarToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToDollar")),
                                Image.asset('images/usa.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/euro.png', width: 35, height: 35,),
                                Text(delegate.translateValue("EuroToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToEuro")),
                                Image.asset('images/euro.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/pound.png', width: 35, height: 35,),
                                Text(delegate.translateValue("PoundToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToPound")),
                                Image.asset('images/pound.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/toman.png', width: 35, height: 35,),
                                Text(delegate.translateValue("TomanToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToToman")),
                                Image.asset('images/toman.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/caldar.png', width: 35, height: 35,),
                                Text(delegate.translateValue("CaldarToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 9,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToCaldar")),
                                Image.asset('images/caldar.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/rupees.png', width: 35, height: 35,),
                                Text(delegate.translateValue("RupeesToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 11,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToRupees")),
                                Image.asset('images/rupees.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 12,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/darham.png', width: 35, height: 35,),
                                Text(delegate.translateValue("DerhamToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 13,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToDerham")),
                                Image.asset('images/darham.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 14,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/riyal.png', width: 35, height: 35,),
                                Text(delegate.translateValue("RealToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 15,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToReal")),
                                Image.asset('images/riyal.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 16,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/frank.png', width: 35, height: 35,),
                                Text(delegate.translateValue("FrankToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 17,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToFrank")),
                                Image.asset('images/frank.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 18,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/canada.png', width: 35, height: 35,),
                                Text(delegate.translateValue("CadToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 19,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToCad")),
                                Image.asset('images/canada.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 20,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/australia.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AudToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 21,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToAud")),
                                Image.asset('images/australia.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 22,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/crone.png', width: 35, height: 35,),
                                Text(delegate.translateValue("CroneToAfn")),
                                Image.asset('images/afg.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 23,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/afg.png', width: 35, height: 35,),
                                Text(delegate.translateValue("AfnToCrone")),
                                Image.asset('images/crone.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 24,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/usa.png', width: 35, height: 35,),
                                Text(delegate.translateValue("DollarToToman")),
                                Image.asset('images/toman.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 25,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/usa.png', width: 35, height: 35,),
                                Text(delegate.translateValue("DollarToCaldar")),
                                Image.asset('images/caldar.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 26,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/usa.png', width: 35, height: 35,),
                                Text(delegate.translateValue("DollarToDerham")),
                                Image.asset('images/darham.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 27,
                        ),
                        DropdownMenuItem(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: <Widget>[
                                Image.asset('images/usa.png', width: 35, height: 35,),
                                Text(delegate.translateValue("DollarToYuro")),
                                Image.asset('images/euro.png', width: 35, height: 35,)
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          value: 28,
                        ),
                    ],
                    onChanged: (newValue){
                      setState(() {
                        value = newValue;
                        output = '';
                        buyOutput = '';
                      });
                    },
                    value: value,
                  ),
                ),
              ),
              Card(
                child: Column(

                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  helperText: delegate.translateValue("EnterAmount")),
                              style: Theme.of(context).textTheme.bodyText1,
                              keyboardType: TextInputType.number,
                              controller: controller,
                              onChanged: (value) {
                                input = double.parse(value);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: RaisedButton(
                            shape: StadiumBorder(),
                              color: Colors.blueAccent,
                              onPressed: () {
                                showInterstitialAd();
                                setState(() {
                                  calculating = true;
                                });
                                _calculate(delegate);
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              elevation: 3.5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                child: Text(delegate.translateValue("Calculate"),
                                    style: TextStyle(fontSize: 15)),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Center(
                        child: calculating == true ? CircularProgressIndicator() : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(output, style: TextStyle(fontSize: 16),),
                            Text(buyOutput, style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.1,
              child: AdWidget(
                ad: myBanner,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
