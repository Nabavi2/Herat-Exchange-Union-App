import 'dart:convert';
import 'dart:io';

import 'package:exchanger/config/localization/localization.dart';
import 'package:exchanger/staticCard.dart';
import 'package:exchanger/widgets/vip.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';

class GoldScreen extends StatefulWidget {
  @override
  _GoldScreenState createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> {

  List<List<Widget>> golds = [];
  List<String> titles = [];
  List<String> dates = [];

  int dataIndex = 0;

  Future<List<dynamic>> _getData() async {
    Uri url = Uri.parse('https://heratexchangeunion.com/wp-json/wp/v2/gold_rate');
    Response response = await get(
        url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data[0]['title']);
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  getGoldItems() async{
    var delegate = Localization.of(context);
    var items = await _getData();
    if(items != null) {

      items.forEach((v) {
        titles.add(delegate.translateValue("GoldExchange"),);
        dates.add(v['date']);
        items.last != v ? golds.add(
            [
              StaticCurrencyCard(
                curName: delegate.translateValue("OneGoldCoin"),
                curBuy: v['metadata']['buyCoin'][0],
                curSell: v['metadata']['sellCoin'][0],
                image: 'images/coin.png',
              ),
              StaticCurrencyCard(
                curName: delegate.translateValue("Gold18"),
                curBuy: v['metadata']['buyEighteen'][0],
                curSell: v['metadata']['sellEighteen'][0],
                image: 'images/coin.png',
              ),
              StaticCurrencyCard(
                curName: delegate.translateValue("Gold21"),
                curBuy: v['metadata']['buyTweentyOne'][0],
                curSell: v['metadata']['sellTweentyOne'][0],
                image: 'images/coin.png',
              ),
            ]
        ) : null;
      });
    }
    setState(() {

    });
  }

  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-1752138406175532/4162093059'
          : 'ca-app-pub-1752138406175532/5528798001',
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

  final myBanner = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-1752138406175532/1727501404'
          : 'ca-app-pub-1752138406175532/9605991427',
      size: AdSize.fullBanner,
      request: AdRequest(),
      //listener: null,
      listener: BannerAdListener()
  );

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getGoldItems());
    myBanner.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var delegate = Localization.of(context);
    bool isEnglish = delegate.locale == Locale('en', 'US');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: golds.isEmpty ? Center(child: CircularProgressIndicator()) : Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.40,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Card(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            SizedBox(height: 15.0,),
                            Column(
                              textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                              children: [
                                Text(
                                  "<< " +
                                      titles[dataIndex]
                                      +
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
                                  dates[dataIndex]+" "+
                                      delegate.translateValue("ChangeRateDate"),
                                  textAlign: TextAlign.center,
                                  textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                ) :
                                Text(
                                  delegate.translateValue("ChangeRateDate")+" "+
                                      (dates[dataIndex]).replaceAll("T", " "),
                                  textAlign: TextAlign.center,
                                  textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                ),
                              ],
                            ),
                            Column(
                              children: golds[dataIndex].map((e) => e).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(width:2, color:Colors.blue),
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            if(dataIndex < golds.length - 1) {
                              showInterstitialAd();
                              setState(() {
                                dataIndex++;
                              });
                              print(dataIndex);
                            }
                          },
                          child: SizedBox(
                            width: 100.0,
                            child: Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.arrow_back_ios_rounded, size: 16.0, color: Colors.blue,),
                                Text(delegate.translateValue("Next"), style: TextStyle(color: Colors.blue),),
                                SizedBox(width: 5.0,),
                              ],
                            )),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(width:2, color:Colors.blue),
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            if(dataIndex > 0) {
                              showInterstitialAd();
                              setState(() {
                                dataIndex--;
                              });
                              print(dataIndex);
                            }
                          },
                          child: SizedBox(
                            width: 100.0,
                            child: Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 5.0,),
                                Text(delegate.translateValue("Previous"), style: TextStyle(color: Colors.blue)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 16.0, color: Colors.blue,),
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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