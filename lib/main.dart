import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:exchanger/Scren/gold.dart';
import 'package:exchanger/config/localization/admob_services.dart';
import 'package:exchanger/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:exchanger/config/localization/localization.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import './Scren/custom_dialog.dart' as customDialog;

//Screens
import './Scren/about.dart';
import './Scren/news.dart';
import 'Scren/Static.dart';
import 'Scren/vip.dart';
import 'Scren/account.dart';
import 'Scren/first.dart';
import './drawer.dart';
//widgets
import './custom_icons_icons.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  AdmobService.initialize();
  runApp(RestartWidget(child: MyApp()));
}


class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isEnglish = true;
  Future<void> _getLanguage() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    setState(() {
      isEnglish = prefs.getBool('isEnglish') ?? true;
    });
    setLocale(isEnglish ? Locale('en', 'US') : Locale('fa', 'IR'));
  }

  Locale _locale = Locale('en', 'Us');
  LocalizationDelegate localization;
  @override
  void initState() {
    localization  = LocalizationDelegate();
    _getLanguage();
    super.initState();
  }
  void setLocale(Locale locale) {

    localization.load(locale);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اتحادیه صرافان',
      home: UpgradeAlert(child: SplashScreen()),
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: isEnglish ? 'AlumniSans' : 'IranSans',
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 2,
          centerTitle: true,
          textTheme: TextTheme().copyWith(
            headline6: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: isEnglish ? 24 : 16,
              fontFamily: isEnglish ? 'AlumniSans' : "IranSans",
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      supportedLocales: [
          Locale('en', 'US'),
          Locale('fa', 'IR'),
        ],
        locale: _locale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          Localization.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
    );
  }
}

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: MainWidget(),
          ),
          SideBar(),
        ],
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  static void setLocale(BuildContext context, int index) {
    MainWidgetState state = context.findAncestorStateOfType<MainWidgetState>();
    state.changeNavItem(index);
  }
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  changeNavItem(int index) {
    print("################# $index");
    // setState(() {
    //   currentTab = index;
    //   currentScreen = screens[index];
    // });
  }
  Future<List<dynamic>> _getData({String date}) async {
    Uri url = Uri.parse('https://tutiatech.com/wp-json/wp/v2/advertise');
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _showAd(image, link) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: customDialog.AlertDialog(
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              title: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.all(2.0),
                  icon: Icon(
                    Icons.close,
                    size: 18.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              content: Container(
                width: double.infinity,
                height: double.infinity,
                child: InkWell(
                  child: Image(
                    image: image,
                    fit: BoxFit.fitWidth,
                  ),
                  onTap: () async {
                    await launch(link);
                  },
                ),
              ),
            ),
          );
        });
  }

  bool isOffline = false;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isOffline = false;
      });
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isOffline = false;
      });
      return false;
    }
    setState(() {
      isOffline = true;
    });
    return true;
  }

  Timer timer;
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => _getData().then((res) {
              print("this is length of images = " + res.length.toString());
              Random rnd;
              int min = 0;
              int max = res.length;
              rnd = new Random();
              var r = min + rnd.nextInt(max - min);
              String link = Html(data: res[0]['excerpt']['rendered']).data;
              String removeAllHtmlTags(String htmlText) {
                RegExp exp =
                    RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

                return htmlText.replaceAll(exp, '');
              }

              String linkData = removeAllHtmlTags(link);
              var _image = NetworkImage(Uri.encodeFull(
                  res[r]['better_featured_image']['source_url']));
              _image.resolve(ImageConfiguration()).addListener(
                ImageStreamListener(
                  (info, call) {
                    _showAd(_image, linkData);
                    // do something
                  },
                ),
              );
            }));
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => check());
  }

  int currentTab = 0;
  final List<Widget> screens = [
    VipScreen(),
    ListData(),
    StaticDta(),
    GoldScreen(),
    CalCulate(),
    NewsScreen(),
    About(),
  ];

  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  Widget currentScreen = VipScreen();

  final PageStorageBucket bucket = PageStorageBucket();

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext ctx) {
    var delegate = Localization.of(ctx);
    bool isEnglish = delegate.locale == Locale('en', 'US');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return isOffline == true
        ? Directionality(
            textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.network_check,
                      size: 76.0,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      delegate.translateValue("Connection_lost"),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffffffff),
              leading: Container(),
              elevation: 1,
              title: Text(
                delegate.translateValue("Title"),
                style: TextStyle(
                  color: Color(0xFF585858),
                  fontSize: 14,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: PageStorage(child: currentScreen, bucket: bucket),
            bottomNavigationBar: bmnav.BottomNav(
              index: currentTab,
              labelStyle: bmnav.LabelStyle(visible: true),
              onTap: (i) {
                setState(() {
                  currentTab = i;
                  currentScreen = screens[i];
                });
              },
              items: [
                bmnav.BottomNavItem(Icons.stars,
                    label: delegate.translateValue('Vip')),
                bmnav.BottomNavItem(CustomIcons.hourglass,
                    label: delegate.translateValue("MomentaryRate")),
                bmnav.BottomNavItem(CustomIcons.calendar_with_day_off,
                    label: delegate.translateValue("DailyRate")),
                bmnav.BottomNavItem(Icons.monetization_on,
                    label: delegate.translateValue('Gold')),
                bmnav.BottomNavItem(CustomIcons.exchange, label: delegate.translateValue("CurrencyExchange")),
                bmnav.BottomNavItem(Icons.notifications, label: delegate.translateValue("News")),
                bmnav.BottomNavItem(Icons.info, label: delegate.translateValue("AboutUs")),
              ],
            ),
          );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 2400),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SideBarLayout(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset("images/splashScreen.jpg", fit: BoxFit.fitHeight);
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'تنظیمات', icon: Icons.settings),
];
