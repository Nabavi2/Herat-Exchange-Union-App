import 'dart:async';

import 'package:exchanger/Scren/gold.dart';
import 'package:exchanger/Scren/vip.dart';
import 'package:exchanger/config/localization/localization.dart';
import 'package:exchanger/main.dart';
import 'package:exchanger/restart_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
//Screens
import './Scren/about.dart';
import './Scren/news.dart';
import 'Scren/Static.dart';
import './Scren/aboutTotia.dart';
import './Scren/feedback_screen.dart';
import 'Scren/aboutApp.dart';
import 'Scren/account.dart';
import 'Scren/first.dart';

// import '../bloc.navigation_bloc/navigation_bloc.dart';
// import './widgets/menu_item.dart';
import './Custom_icons_icons.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    _getLanguage();
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  Future<void> _setLanguage(bool isEnglish) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isEnglish', isEnglish);

  }
  bool isEnglish = true;
  Future<void> _getLanguage() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    setState(() {
      isEnglish = prefs.getBool('isEnglish') ?? true;
    });
    print(isEnglish);
  }


  changeLanguage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEnglish ? "Change Language" : "تغییر زبان"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async{
                  print('af');
                  await _setLanguage(false);
                  await _getLanguage();
                  RestartWidget.restartApp(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: isEnglish ? Border.all() : Border.all(
                          color: Colors.blue,
                          width: 2.0
                      )
                  ),
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'images/afg.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async{
                  await _setLanguage(true);
                  await _getLanguage();
                  RestartWidget.restartApp(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: isEnglish ? Border.all(
                      color: Colors.blue,
                      width: 2.0
                    ) : Border.all()
                  ),
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(50.0),
                    child: Image.asset(
                      'images/usa.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(isEnglish ? "Cancel" : "لغو")
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var delegate = Localization.of(context);
    bool isEnglish = delegate.locale == Locale('en', 'US');
    print('${delegate.locale}');
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          right: isEnglish ? isSideBarOpenedAsync.data ? 0 : size.width - 40 : isSideBarOpenedAsync.data ? 0 : -size.width,
          left: isEnglish ? isSideBarOpenedAsync.data ? 0 : -size.width : isSideBarOpenedAsync.data ? 0 : size.width - 40 ,
          child: Row(
            textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
            children: <Widget>[
              RotatedBox(
                quarterTurns: isEnglish ? 0 : 2,
                child: Align(
                  alignment: Alignment(0, isEnglish ? -1.0 : 1.0),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 36,
                        height: 110,
                        color: Color(0xff1780c2),
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    // border: Border(
                    //     left: BorderSide(
                    //   // width: 5,
                    //   color: Color(0xffffffff),
                    // )),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            // Important: Remove any padding from the ListView.
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              DrawerHeader(
                                child: Text(''),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  image: DecorationImage(
                                    image: AssetImage("images/banner.jpg"),
                                    fit: BoxFit.cover,
                                    scale: 1.1,
                                  ),
                                ),
                              ),
                              // Column(
                              //   crossAxisAlignment:
                              //       CrossAxisAlignment.end,
                              //   children: [
                              //     Text(
                              //       "نرخ اسعار صرافان هرات",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //     Text(
                              //       "Herat Exchange Union",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Container(
                              //   margin: EdgeInsets.only(left: 25),
                              //   width: 50,
                              //   height: 50,
                              //   child: ClipRRect(
                              //     borderRadius:
                              //         BorderRadius.circular(100),
                              //     child: Image.asset("images/Logo.jpg"),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       right: 30, left: 30, top: 10, bottom: 20),
                              //   child: Divider(),
                              // ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("DrawerVip"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          Icons.stars,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Scaffold(
                                            bottomNavigationBar: Container(
                                              color: Colors.grey,
                                              height: 10.0,
                                            ),
                                            appBar: AppBar(
                                              title: Text(
                                                delegate.translateValue("DrawerVip"),
                                                style: TextStyle(
                                                  color: Color(0xFF585858),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            body: VipScreen(),
                                          ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("DrawerMomentaryRate"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          CustomIcons.hourglass,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Scaffold(
                                        appBar: AppBar(
                                          title: Text(
                                            delegate.translateValue("DrawerMomentaryRate"),
                                            style: TextStyle(
                                              color: Color(0xFF585858),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        body: ListData(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("DrawerDailyRate"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          CustomIcons.calendar_with_day_off,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Scaffold(
                                        appBar: AppBar(
                                          title: Text(
                                            delegate.translateValue("DrawerDailyRate"),
                                            style: TextStyle(
                                              color: Color(0xFF585858),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        body: StaticDta(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("DrawerGold"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          Icons.monetization_on,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Scaffold(
                                            bottomNavigationBar: Container(
                                              color: Colors.grey,
                                              height: 10.0,
                                            ),
                                            appBar: AppBar(
                                              title: Text(
                                                delegate.translateValue("DrawerGold"),
                                                style: TextStyle(
                                                  color: Color(0xFF585858),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            body: GoldScreen(),
                                          ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("CurrencyExchange"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          CustomIcons.exchange,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Scaffold(
                                            appBar: AppBar(
                                              title: Text(
                                                delegate.translateValue("CurrencyExchange"),
                                                style: TextStyle(
                                                  color: Color(0xFF585858),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            body: CalCulate(),
                                          )));
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("News"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          CustomIcons.notifications,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Scaffold(
                                        appBar: AppBar(
                                          title: Text(
                                            delegate.translateValue("News"),
                                            style: TextStyle(
                                              color: Color(0xFF585858),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        body: NewsScreen(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30, left: 30, top: 10, bottom: 20),
                                child: Divider(),
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("AboutHEU"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          Icons.info,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Directionality(
                                            textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                            child: Scaffold(
                                              appBar: AppBar(
                                                title: Text(
                                                  delegate.translateValue("AboutHEU"),
                                                  style: TextStyle(
                                                    color: Color(0xFF585858),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              body: About(),
                                            ),
                                          )));
                                },
                              ),
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // Temporarily commented {
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ListTile(
                              //   dense: true,
                              //   title: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                              //     children: <Widget>[
                              //       Row(
                              //         textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                              //         children: <Widget>[
                              //           Text(
                              //             delegate.translateValue("AboutCompany"),
                              //             textDirection: TextDirection.rtl,
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               color: Colors.black,
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             width: 10.0,
                              //           ),
                              //           Icon(
                              //             Icons.info,
                              //             color: Colors.grey,
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              //   onTap: () {
                              //     Navigator.of(context).push(MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             Directionality(
                              //               textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                              //               child: Scaffold(
                              //                 appBar: AppBar(
                              //                   title: Text(
                              //                     delegate.translateValue("AboutCompany"),
                              //                     style: TextStyle(
                              //                       color: Color(0xFF585858),
                              //                       fontSize: 14,
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 body: AboutTotia(),
                              //               ),
                              //             )));
                              //   },
                              // ),
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // Temporarily commented }
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              // ####################################################################
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("AboutApp"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.info,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Directionality(
                                        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            centerTitle: true,
                                            title: Text(
                                              delegate.translateValue("AboutApp"),
                                              style: TextStyle(
                                                color: Color(0xFF585858),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          body: AboutApp(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("Feedback"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.question_answer,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            title: Text(
                                              delegate.translateValue("Feedback"),
                                              style: TextStyle(
                                                color: Color(0xFF585858),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          body: FeedBack(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                  children: <Widget>[
                                    Row(
                                      textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                                      children: <Widget>[
                                        Text(
                                          delegate.translateValue("Language"),
                                          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.language,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    // Icon(
                                    //   Icons.arrow_left,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                                onTap: () {
                                  changeLanguage();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.black;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
