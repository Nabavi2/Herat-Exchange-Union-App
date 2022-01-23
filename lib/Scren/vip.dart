import 'dart:convert';
import 'dart:io';

import 'package:exchanger/config/localization/localization.dart';
import 'package:exchanger/staticCard.dart';
import 'package:exchanger/widgets/vip.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';

class VipScreen extends StatefulWidget {
  @override
  _VipScreenState createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {


  List<List<Widget>> vips = [];
  List<String> titles = [];
  List<String> dates = [];

  int dataIndex = 0;
  
  Future<List<dynamic>> _getData() async {
    Uri url = Uri.parse('https://heratexchangeunion.com/wp-json/wp/v2/vip_rate');
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

  getVipItems() async{
    var delegate = Localization.of(context);
    var items = await _getData();
    if(items != null) {
      items.forEach((v) {
        titles.add(delegate.translateValue("VipTitle"),);
        dates.add(v['date']);
        vips.add(
            [
              StaticCurrencyCard(
                curName: delegate.translateValue("Dollar"),
                curBuy: v['metadata']['buyDollar'][0],
                curSell: v['metadata']['sellDollor'][0],
                image: 'images/usa.png',
              ),
              StaticCurrencyCard(
                curName: delegate.translateValue("Yuro"),
                curBuy: v['metadata']['buyYorro'][0],
                curSell: v['metadata']['sellYorro'][0],
                image: 'images/euro.png',
              ),
              StaticCurrencyCard(
                curName: delegate.translateValue("Toman"),
                curBuy: v['metadata']['buyToman'][0],
                curSell: v['metadata']['sellToman'][0],
                image: 'images/toman.png',
              ),
              StaticCurrencyCard(
                curName: delegate.translateValue("Caldar"),
                curBuy: v['metadata']['buyKaldar'][0],
                curSell: v['metadata']['sellKaldar'][0],
                image: 'images/caldar.png',
              ),
              StaticCurrencyCard(
                curName: delegate.translateValue("TomanToUsd"),
                curBuy: v['metadata']['buyTomanInDollar'][0],
                curSell: v['metadata']['sellTomanInDollar'][0],
                image: 'images/usa.png',
              ),
            ]
        );
      });
    }
    setState(() {

    });

  }

  double sizedBoxHeight = 0.0;


  final myBanner = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-1752138406175532/9341078171'
          : 'ca-app-pub-1752138406175532/5996729535',
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
          ? 'ca-app-pub-1752138406175532/1267147038'
          : 'ca-app-pub-1752138406175532/9470260053',
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
    WidgetsBinding.instance.addPostFrameCallback((_) => getVipItems());
    myBanner.load();
    print(vips);
    super.initState();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var delegate = Localization.of(context);
    bool isEnglish = delegate.locale == Locale('en', 'US');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: vips.isEmpty ? Center(child: CircularProgressIndicator()) : Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                height: size.height * 0.60,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
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
                                  (dates[dataIndex]).replaceAll('T', ' '),
                              textAlign: TextAlign.center,
                              textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                            ),
                          ],
                        ),
                        Column(
                          children: vips[dataIndex].map((e) => e).toList(),
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
                        print(vips.length);
                        if(dataIndex < vips.length - 1) {
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