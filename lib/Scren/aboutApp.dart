import 'package:exchanger/config/localization/localization.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var delegate = Localization.of(context);
    bool isEnglish = delegate.locale == Locale('en', 'US');
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        width: double.infinity,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Text(
                'نرخ اسعار صرافان ولایت هرات\nHerat Exchange Rate',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
              ),
              Text(
                "Ver 1.0.0",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              item(
                  en: 'This mobile application has been designed and launched in order to provide accurate and timely exchange rates in the exchange market of Herat province for our people who uses smartphones ( Andeoid / IOS )',
                  fa: 'این اپلیکشن موبایل به منظور ارائه دقیق و بموقع نرخ اسعار در بازار صرافی های ولایت هرات طراحی و راه اندازی گردیده است که نرخ انواع اسعار خارجی را مطابق به تحولات بازار هم ثابت و هم لحظه ای در خدمت هموطنان عزیز که موبایل های هوشمند (Android & iOS) دارند قرار دهد.',
                  isEnglish: isEnglish,
                  size: 14.0
              ),
              SizedBox(
                height: 10.0,
              ),
              item(
                en: 'Mobile Application Sections:',
                fa: 'بخش های این اپلیکشن موبایل:',
                isEnglish: isEnglish,
                size: 16.0
              ),
              SizedBox(
                height: 10.0,
              ),
              item(
                en: '1- Daily Rate',
                fa: '۱- نرخ روزانه ثابت',
                isEnglish: isEnglish,
                size: 16.0
              ),
              item(
                en: ' Which changes once a day and is used by government departments, courts and news media.',
                fa: '   که روز یکبار تغییر میکند و مورد استفاده ادارات دولتی، محاکمات عدلی و قضائی و رسانه های خبری قرار می گیرد.',
                isEnglish: isEnglish,
                size: 14.0
              ),
              item(
                en: "2- Momentary Rate",
                fa: '۲- نرخ اسعار لحظه ای',
                isEnglish: isEnglish,
                size: 16.0
              ),
              item(
                en: ' In this section, reputable trading companies, traders and marketers can be informed about foreign exchange rates moment by moment.',
                fa: '   در این بخش شرکت های محترم تجارتی، معامله داران و بازاریان می توانند لحظه به لحظه از نرخ اسعار خارجی اطلاع حاصل نمایند.',
                isEnglish: isEnglish,
                size: 14.0
              ),
              item(
                en: '3- Currency Exchange',
                fa: '۳- تبادله اسعار',
                isEnglish: isEnglish,
                size: 16.0
              ),
              item(
                en: ' In this section, clients can automatically exchange their desired currencies at the current rate.',
                fa: '   در این بخش مراجعین می توانند بطور خود کار طبق نرخ لحظه ای، اسعار مورد نظر خودش را تبادله نمایند.',
                isEnglish: isEnglish,
                size: 14.0
              ),
              item(
                en: '4- News',
                fa: '۴- اطلاعیه ها',
                isEnglish: isEnglish,
                size: 16.0
              ),
              item(
                en: ' In this section, important and necessary announcements are published by the president of the money changers\' union.',
                fa: '   در این بخش اطلاعیه های مهم و ضروری از طرف ریاست اتحادیه صرافان منتشر میگردد.',
                isEnglish: isEnglish,
                size: 14.0
              ),
              item(
                en: '5- About the Herat Exchange Union',
                fa: '۵- درباره اتحادیه صرافان ولایت هرات',
                isEnglish: isEnglish,
                size: 16.0
              ),
              item(
                en: ' This section reflects the organization, activities, achievements, charitable donations, cultural, sports, gallery ... on reputable sites (website, Facebook, Telegram channels, WhatsApp, etc.) about the Money Exchange Union of the province Herat.',
                fa: '   این بخش انعکاس  دهنده، تشکیلات، فعالیت ها، دستاورد ها، کمک های خیریه، بخش فرهنگی، ورزشی، گالری ... در سایت های معتبر ( وب سایت، فیسبوک، کانال های تلگرام، واتساپ و ...) درباره اتحادیه صرافان ولایت هرات میباشد.',
                isEnglish: isEnglish,
                size: 14.0
              ),
              item(
                en: '5- Send Feedback',
                fa: '۶- ارسال پیشنهادات و نظرات',
                isEnglish: isEnglish,
                size: 16.0
              ),
              item(
                en: ' All dear friends can send us their comments and suggestions to provide better services through this application; Thank you for your help in providing us with better services',
                fa: 'همه دوستان عزیز میتوانند نظرات وپیشنهادات خویش را برای ارایه بهتر خدمات ،از طریق این اپلیکشن به ما ارسال نمایند؛ ازینکه بانظرات خود، ما را در ارائه خدمات بهتری یاری می فرمائید سپاسگزاریم',
                isEnglish: isEnglish
              ),
              SizedBox(
                height: 35.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item({bool isEnglish, String en, String fa, double size}) {
    return Text(
      isEnglish
          ? en
          : fa,
      textAlign: TextAlign.justify,
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      style: TextStyle(fontSize: size),
    );
  }
}
