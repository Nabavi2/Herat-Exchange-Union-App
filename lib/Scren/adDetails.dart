import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AdDetails extends StatefulWidget {
  final int id;
  final String viewers;
  final String title;
  final String detail;
  final String date;
  final String video;
  final String img;
  final int index;
  AdDetails(
      {this.viewers,
      this.date,
      this.title,
      this.detail,
      this.id,
      this.img,
      this.video,
      this.index});

  @override
  _AdDetailsState createState() => _AdDetailsState();
}

class _AdDetailsState extends State<AdDetails> {
  Future<List<dynamic>> _addViewer() async {
    Uri url = Uri.parse('http://heratexchangeunion.com/wp-json/advertise/v1/post/${widget.id}');
    Response response = await post(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<List<dynamic>> _getViewers() async {
    Uri url = Uri.parse('http://heratexchangeunion.com/wp-json/wp/v2/advertise');
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

  String videoId;
  YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _addViewer();
    if (widget.video != '' && widget.video != null) {
      videoId = YoutubePlayer.convertUrlToId("${widget.video}");
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          hideControls: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'جزئیات تبلیغات',
                ))
          ],
        ),
      ),
      body: FutureBuilder(
        future: _getViewers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: <Widget>[
              widget.video != ''
                  ? YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      bufferIndicator: CircularProgressIndicator(),
                      onReady: () {
                        print('Player is ready.');
                      },
                    )
                  : FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      height: 200.0,
                      placeholder: 'images/image-placeholder.jpg',
                      image: widget.img,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 10.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            snapshot.data[widget.index]['viewer'] ?? 0,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            widget.date.split('T')[0],
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.date_range,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                child: Directionality(
                  child: Text(
                    widget.detail,
                    textAlign: TextAlign.justify,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
