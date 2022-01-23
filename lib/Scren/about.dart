//core
import 'package:exchanger/config/localization/localization.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
//packages
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  String about = '''
    اتحادیه صرافان ولایت هرات که از سال‌های قبل در خدمت هموطنان عزیز قرار دارد قبلا تحت نام صنف صرافان فعالیت داشته است که در سال 1388 اولین جواز انجمن صرافان هرات ثبت وزارت عدلیه دولت اسلامی افغانستان گردیده است . 
در سال 1392 بعد از انتخاب الحاج بهاألدین ( رحیمی ) به حیث رئیس اتحادیه صرافان ولایت هرات به اکثریت آراء با  ایجاد چندین انجمن صرافی در ولسوالی های غوریان ، شندند و کهسان انجمن صرافان هرات به اتحادیه صرافان ولایت هرات ارتفاع یافت و بتاریخ 24/12/1392,  مطابق جواز نمبر 1227 صادره وزارت عدلیه دولت اسلامی افغانستان  اتحادیه صرافان ایجاد گردیده است و این از نتیجه زحمات و فعالیت های شبانه روزی هیأت رهبری و اعضای اتحادیه صرافان در راس شخص رییس اتحادیه صرافان ولایت هرات میباشد. 
در حال حاضر به تعداد 440 نفر صراف که جواز فعالیت صرافی و خدمات پولی را از بانک مرکزی دولت اسلامی افغانستان بدست دارند و تحت رهبری واحد با اتحاد و یکپارچگی در مارکت های اسعاری (خراسان و پاساژ رازی ) فعالیت صرافی و اجرای حواله جات خدمات پولی داشته در خدمت همشهریان عزیز قرار دارند. 
جهت اخذ معلومات بیشتر ما ، میتوانید به ویب سایت (اتحادیه صرافان ولایت هرات ) مراجعه فرمائید.
  ''';

  String aboutEn = '''The Money Changers 'Union of Herat Province, which has been serving its dear compatriots for many years, has previously operated under the name of Money Changers' Guild.
In 1392, after the election of Alhaj Bahauddin (Rahimi) as the chairman of the money changers 'union of Herat province, a majority of votes were cast by establishing several money changers' associations in Ghorian districts. 1392, in accordance with the license number 1227 issued by the Ministry of Justice of the Islamic Republic of Afghanistan, the money changers' union has been established and this is the result of the efforts of the leadership and members of the money changers' union headed by the head of the money changers' union of Herat province. Currently, there are 440 money changers who are licensed to exchange and monetary services from the Central Bank of the Islamic Republic of Afghanistan and under the leadership of the unit with unity and integration in foreign exchange markets (Khorasan and Razi Passage) exchange activities and remittances They are at the service of dear fellow citizens. For more information, you can refer to the website (Herat Money Exchange Association).
  ''';
  @override
  Widget build(BuildContext context) {
    var delegate = Localization.of(context);
    bool isEnglish = delegate.locale == Locale('en', 'US');

    Widget companySicialMediaItem(String title, String url, String icon) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        child: InkWell(
          onTap: () async {
            // const url = 'https://tutiatech.com';
            if (Platform.isAndroid) {
              await launch(url);
            } else if (Platform.isIOS) {
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                print('Could not launch $url');
              }
            }
          },
          child: Card(
            // color: Colors.grey.shade200,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Text(
                    "$title",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Image.asset(
                  '$icon',
                  scale: 1.1,
                ),
              ],
            ),
          ),
        ),
      );
    }

    List<Map> socialMedia = [
      {
        "title": isEnglish ? "Herat Exchange Union Website" : "وب سایت اتحادیه صرافان ولایت هرات",
        "url": "http://heratexchangeunion.com",
        "icon": "images/web.png"
      },
      {
        "title": isEnglish ? "Herat Exchange Union" : "اتحادیه صرافان ولایت هرات",
        "url":
            "https://www.facebook.com/Herat-Exchange-Union-HEU-716703725102514/",
        "icon": "images/face.png"
      },
      {
        "title": isEnglish ? "Herat Exchange Union Sport Club" :"باشگاه ورزشی اتحادیه صرافان ولایت هرات",
        "url": "https://www.facebook.com/profile.php?id=100007644765429/",
        "icon": "images/face.png"
      },
      {
        "title": isEnglish ? "Herat Exchange Union Contact Number" : "شماره تماس اتحادیه صرافان ولایت هرات",
        "url": "tel:0787959799",
        "icon": "images/call.png"
      },
      {
        "title": isEnglish ? "Herat Exchange Union" : "باشگاه ورزشی اتحادیه صرافان ولایت هرات",
        "url": "https://t.me/HEXUclubsport",
        "icon": "images/tel.png"
      },
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: new Image.asset(
                  'images/sarf.jpg',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    isEnglish ? aboutEn : about,
                    textAlign: isEnglish ? TextAlign.left : TextAlign.right,
                    style: TextStyle(
                        fontSize: isEnglish ? 18.0 : 16.0,
                        ),
                    textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                  )),
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return companySicialMediaItem(socialMedia[index]["title"],
                      socialMedia[index]["url"], socialMedia[index]["icon"]);
                },
                itemCount: socialMedia.length,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
