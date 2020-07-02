import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/blocs/database/database_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ArticleContentTopBar extends StatefulWidget {
  final Article article;
  ArticleContentTopBar(this.article);

  @override
  _ArticleContentTopBarState createState() => _ArticleContentTopBarState();
}

class _ArticleContentTopBarState extends State<ArticleContentTopBar> {
  bool isBookMarked = false;
  DatabaseBloc dbBloc;
  bool isOpened = false;
  bool isPlaying = false;
  bool isGettingSpeech = false;
  String link = "";
  AssetsAudioPlayer player = AssetsAudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dbBloc = BlocProvider.of<DatabaseBloc>(context);
    //dbBloc.add(GetAllSaveArticle());

    for (var item in (dbBloc.state as DatabaseLoaded).savedArticles) {
      if (widget.article.id == item.id) {
        setState(() {
          isBookMarked = true;
        });
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        // gradient: LinearGradient(
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //     colors: [
        //       Theme.of(context).bottomAppBarColor,
        //       Colors.lightBlueAccent,
        //     ]),
        color: Theme.of(context).backgroundColor,
        //border: Border.(width: 0, color: Theme.of(context).textTheme.bodyText2.color),
        border: Border(
          bottom: BorderSide(
              width: 0, color: Theme.of(context).textTheme.bodyText2.color),
        ),
      ),
      height: 22 * screenHeight / 360,
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4 * screenHeight / 360),
                  child: Icon(
                    CupertinoIcons.back,
                    size: 17 * screenHeight / 360,
                  ))),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              if (!isGettingSpeech) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Đang lấy bài đọc')));
                String payload = "";
                for (var item in widget.article.content) {
                  if (item.type == "text") payload += item.info + " ";
                }
                _getSpeech(payload);
              } else if (link != "" && !isOpened) {
                setState(() {
                  try {
                    if (link == "") return;
                    player
                        .open(
                      Audio.network(link),
                    )
                        .then((value) {
                      player.stop();
                      isOpened = true;
                    });
                  } catch (e) {
                    print(e);
                  }
                });
              }
              if (isOpened) {
                try {
                  setState(() {
                    player.playOrPause();
                    isPlaying = !isPlaying;
                  });
                } catch (e) {
                  print(e);
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 4 * screenWidth / 360, 4 * screenHeight / 360),
              child: Icon(
                isPlaying
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
                size: 17 * screenHeight / 360,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bookMarkArticle();
              });
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 4 * screenWidth / 360, 4 * screenHeight / 360),
              child: Icon(
                isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                size: 17 * screenHeight / 360,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bookMarkArticle() async {
    // SavedArticleData savedData;
    // dbBloc.database
    //     .getOneSaveArticle(widget.article.id)
    //     .then((value) => savedData = value);
    bool existed = false;
    for (var item in (dbBloc.state as DatabaseLoaded).savedArticles) {
      if (widget.article.id == item.id) existed = true;
      break;
    }
    if (existed) {
      isBookMarked = false;
      dbBloc.add(DeleteSaveArticle(widget.article));
    } else {
      //Set Bookmark
      // String articleString =
      //     "${widget.article.id.toString()}~${widget.article.title}~${widget.article.firstImage}~${widget.article.description}~${widget.article.location}~${widget.article.time}";

      isBookMarked = true;
      dbBloc.add(AddSaveArticle(widget.article));
    }
  }

  Future _getSpeech(String payload) async {
    setState(() {
      isGettingSpeech = true;
    });

    final String url = "https://api.fpt.ai/hmi/tts/v5";
    final _headers = {
      'api-key': 'Qo7PUncXm7GwTjkVg7LwtRCIvCwQCetc',
      'speed': '',
      'voice': 'linhsan'
    };

    final response = await http.post(url, headers: _headers, body: payload);
    final _json = json.decode(response.body);
    setState(() {
      link = _json["async"];
    });
  }
}
