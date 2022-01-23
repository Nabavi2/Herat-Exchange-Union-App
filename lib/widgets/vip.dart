import 'package:flutter/material.dart';

class VipItem extends StatelessWidget {
  final String fromCurImage;
  final String toCurImage;
  final String title;
  final String buy;
  final String sell;

  const VipItem({Key key, this.fromCurImage, this.toCurImage, this.title, this.buy, this.sell}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 20.0,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Image.asset(
                    fromCurImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_rounded, color: Colors.blue,),
              Container(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Image.asset(
                    toCurImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24.0,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'خرید',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24.0,
              ),
            ),
            Icon(Icons.arrow_downward_rounded, color: Colors.red,)
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            buy,
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'فروش',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24.0,
              ),
            ),
            Icon(Icons.arrow_upward_rounded, color: Colors.blue,)
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            sell,
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
        ),
      ],
    );
  }
}
