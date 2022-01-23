import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class AboutTotia extends StatefulWidget {
  @override
  _AboutTotiaState createState() => _AboutTotiaState();
}

class _AboutTotiaState extends State<AboutTotia> {

  Future<List<dynamic>> _getData() async {
    print('kamran');
  Uri url = Uri.parse('https://tutiatech.com/wp-json/wp/v2/aboutusbanner');
  print(url);
    http.Response response =
        await http.get(url);

    print(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  var data;
  List<Widget> images = [
    ClipRect(
      clipper: null,
      child: Image(
        fit: BoxFit.fill,
        height: 200.0,
        image: AssetImage('images/image-placeholder.jpg'),
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  String abo =
      'شرکت خدمات تکنالوژی طوطیا باداشتن جواز فعالیت از وزارت تجارت و صنعت کشور به منظور ارائه خدمات میزبانی وب ، ثبت دامین ، توسعه نرم افزار ، طراحی وتوسعه وب سایت ، ساخت برنامه های موبایل ، گرافیک دیزاین، راه اندازی شبکه وسخت افزار، تهیه وتولید نرم افزارهای (حسابداری ، مدیریتی،آموزشی ...) وهمچنان مشاوره در زمینه تکنالوژی معلوماتی با ارائه راحل های یکپارچه ،مقرون به صرفه وموثر برای تحقق اهداف مشتریانش فعالیت میکند.';

  Widget companyServicesItem(String title, String link) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: InkWell(
        onTap: () async {
          if (Platform.isAndroid) {
            await launch(link);
          } else if (Platform.isIOS) {
            if (await canLaunch(link)) {
              await launch(link);
            } else {
              print('Could not launch $link');
            }
          }
        },
        child: Container(
          height: 50.0,
          child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            // color: Colors.grey.shade200,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map> companyServicesList = [
    {
      'title': "طراحی و توسعه انواع وب سایت",
      "link":
          "https://tutiatech.com/main-service/%d8%b7%d8%b1%d8%a7%d8%ad%db%8c-%d9%88-%d8%af%db%8c%d8%b2%d8%a7%db%8c%d9%86-%d9%88%d8%a8-%d8%b3%d8%a7%db%8c%d8%aa/"
    },
    {
      "title": "طراحی و توسعه انواع دیتابیس",
      "link":
          "https://tutiatech.com/main-service/%d8%b7%d8%b1%d8%a7%d8%ad%db%8c-%d8%b3%d8%a7%db%8c%d8%aa/"
    },
    {
      "title": "طراحی و توسعه انواع دیتابیس",
      "link":
          "https://tutiatech.com/main-service/%d8%b7%d8%b1%d8%a7%d8%ad%db%8c-%d9%81%d8%b1%d9%88%d8%b4%da%af%d8%a7%d9%87-%d8%a7%db%8c%d9%86%d8%aa%d8%b1%d9%86%d8%aa%db%8c/"
    },
    {
      "title": "SEO سئو وب سایت",
      "link":
          "https://tutiatech.com/main-service/seo-%db%8c%d8%a7-%d8%b3%d8%a6%d9%88-%d9%88%d8%a8-%d8%b3%d8%a7%db%8c%d8%aa/"
    },
    {
      "title": "گرافیک دیزاین (طراحی و تبلیغات ویدیویی)",
      "link":
          "https://tutiatech.com/main-service/%da%af%d8%b1%d8%a7%d9%81%db%8c%da%a9-%d8%af%db%8c%d8%b2%d8%a7%db%8c%d9%86/"
    },
    {
      "title": "بازاریابی انترنیتی (گوگل و صفحات اجتماعی)",
      "link":
          "https://tutiatech.com/main-service/%d8%a2%d9%86%d9%84%d8%a7%db%8c%d9%86-%d9%85%d8%a7%d8%b1%da%a9%d8%aa%db%8c%d9%86%da%af/"
    },
    {
      "title": "نصب و راه اندازی شبکه",
      "link":
          "https://tutiatech.com/main-service/%d9%86%d8%b5%d8%a8-%d9%88-%d8%b1%d8%a7%d9%87-%d8%a7%d9%86%d8%af%d8%a7%d8%b2%db%8c-%d8%b4%d8%a8%da%a9%d9%87/"
    },
  ];

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
      "title": "وب سایت شرکت خدمات تکنالوژی طوطیا",
      "url": "https://tutiatech.com",
      "icon": "images/web.png"
    },
    {
      "title": "فیسبوک شرکت خدمات تکنالوژی طوطیا",
      "url": "https://www.facebook.com/TutiaTech",
      "icon": "images/face.png"
    },
    {
      "title": "شماره تماس شرکت خدمات تکنالوژی طوطیا",
      "url": "tel:0787545425",
      "icon": "images/call.png"
    },
    {
      "title": "تلگرام شرکت خدمات تکنالوژی طوطیا",
      "url": "https://t.me/Tutia_Tech",
      "icon": "images/tel.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 220.0,
                      width: double.infinity,
                      child: FutureBuilder(
                        future: _getData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> data = snapshot.data;
                            return Swiper(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ClipRect(
                                  clipper: null,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.fill,
                                    placeholder:
                                        'images/image-placeholderAbout.jpg',
                                    image:
                                        'https://i2.wp.com/tutiatech.com/wp-content/uploads/${data[index]['better_featured_image']['media_details']['file']}',
                                  ),
                                );
                              },
                              pagination: SwiperPagination(),
                              control: SwiperControl(
                                size: 18.0,
                              ),
                              controller: SwiperController(),
                            );
                          } else {
                            return Swiper(
                              itemCount: images.length,
                              itemBuilder: (BuildContext context, int index) {
                                return images[index];
                              },
                              pagination: SwiperPagination(),
                              autoplay: true,
                              control: SwiperControl(
                                size: 18.0,
                              ),
                              controller: SwiperController(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          abo,
                          textAlign: TextAlign.justify,
                          // textDirection: TextDirection.rtl,
                          // style: TextStyle(fontSize: 16.0),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'جهت اخذ معلومات بیشتر و یا ثبت سفارش تان، میتوانید به لینک های ذیل مراجعه فرمائید:',
                          textAlign: TextAlign.justify,
                          // textDirection: TextDirection.rtl,
                          // style: TextStyle(fontSize: 16.0),s
                        )),
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return companyServicesItem(
                            companyServicesList[index]["title"],
                            companyServicesList[index]["link"]);
                      },
                      itemCount: companyServicesList.length,
                    ),
                  ),
                  Divider(),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return companySicialMediaItem(
                            socialMedia[index]["title"],
                            socialMedia[index]["url"],
                            socialMedia[index]["icon"]);
                      },
                      itemCount: socialMedia.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
