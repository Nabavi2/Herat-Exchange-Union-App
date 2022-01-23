import 'package:flutter/material.dart';

import 'config/localization/localization.dart';

class CurrencyCard extends StatelessWidget {
  final String curName;
  final String date;
  final String curBuy;
  final String curSell;
  final String perBuy;
  final String perSell;
  final String image;
  CurrencyCard(
      {this.curName,
      this.date,
      this.curBuy,
      this.curSell,
      this.perBuy,
      this.perSell,
      this.image});

  @override
  Widget build(BuildContext context) {
    var delegate = Localization.of(context);
    bool isEnglish = delegate.locale == Locale('en', 'US');
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 10),
      child: Column(
        // align the text to the left instead of centered
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
        children: <Widget>[
          Column(
              // elevation: 3,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: isEnglish ? TextDirection.rtl : TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Expanded(
                      //   flex: 2,
                      //   child: SizedBox(
                      //     width: 10,
                      //   ),
                      // ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                          child: Row(
                            children: [
                              Text(curSell),
                              Icon(
                                Icons.arrow_upward,
                                size: 15,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(curBuy),
                              Icon(
                                Icons.arrow_downward,
                                size: 15,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 8),
                          child: Text(
                            curName,
                            textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 5.0, right: 15.0),
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(50.0),
                            child: Image.asset(
                              image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ]),
        ],
      ),
    );
  }
}
