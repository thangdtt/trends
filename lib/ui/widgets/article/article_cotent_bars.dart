import 'dart:convert';
import 'dart:io';

import 'package:share/share.dart';
import 'package:trends/utils/custom_icons.dart';
import 'package:trends/utils/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/blocs/savedArticle/savedArticle_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:trends/utils/pref_utils.dart';

class ArticleContentTopBar extends StatefulWidget {
  final Article article;
  ArticleContentTopBar(this.article);

  @override
  _ArticleContentTopBarState createState() => _ArticleContentTopBarState();
}

class _ArticleContentTopBarState extends State<ArticleContentTopBar> {
  //AudioPlayer speechPlayer = AudioPlayer();

  bool isBookMarked = false;
  SavedArticleBloc _savedArticleBloc;
  bool isOpened = false;
  bool isPlaying = false;
  bool isGettingSpeech = false;
  String link = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _savedArticleBloc = BlocProvider.of<SavedArticleBloc>(context);

    try {
      for (var item in (_savedArticleBloc.state as SavedArticleLoaded).savedArticles) {
        if (widget.article.id == item.id) {
          setState(() {
            isBookMarked = true;
          });
          break;
        }
      }
    } catch (e) {
      print(e);
    }

    speechPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
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
                  padding: EdgeInsets.fromLTRB(
                      10 * screenWidth / 360, 0, 0, 4 * screenHeight / 360),
                  child: Icon(
                    Platform.isAndroid
                        ? CustomIcons.arrow_left
                        : CupertinoIcons.back,
                    size: 30 * screenWidth / 360,
                  ))),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              if (!isGettingSpeech) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Đang lấy bài đọc'),
                  duration: (Duration(seconds: 1)),
                ));
                String payload = "";
                payload += widget.article.title + "\n";
                payload += widget.article.description + "\n";
                for (var item in widget.article.content) {
                  if (item.type == "text") payload += item.info + " ";
                }
                _getSpeech(payload).then((value) {
                  play(value);
                });
              } else if (link != "" && isOpened) {
                try {
                  if (isPlaying) {
                    speechPlayer.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    speechPlayer.resume();
                    setState(() {
                      isPlaying = true;
                    });
                  }
                } catch (e) {
                  print(e.toString());
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 4 * screenWidth / 360, 4 * screenHeight / 360),
              child: Icon(
                _buildReadNewsIcon(),
                size: 30 * screenWidth / 360,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Share.share(widget.article.link);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(4 * screenWidth / 360, 0,
                  4 * screenWidth / 360, 4 * screenHeight / 360),
              child: Icon(
                Platform.isAndroid ? Icons.share : CupertinoIcons.share,
                size: 30 * screenWidth / 360,
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
              padding: EdgeInsets.fromLTRB(4 * screenWidth / 360, 0,
                  4 * screenWidth / 360, 3 * screenHeight / 360),
              child: Icon(
                _buildBookMarkIcon(),
                size: 30 * screenWidth / 360,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bookMarkArticle() async {
    bool existed = false;
    try {
      for (var item in (_savedArticleBloc.state as SavedArticleLoaded).savedArticles) {
        if (widget.article.id == item.id) {
          existed = true;
          break;
        }
      }
    } catch (e) {
      print(e);
    }

    if (existed) {
      isBookMarked = false;
      _savedArticleBloc.add(DeleteSaveArticle(widget.article));
    } else {
      isBookMarked = true;
      _savedArticleBloc.add(AddSaveArticle(widget.article));
    }
  }

  Future<String> _getSpeech(String payload) async {
    setState(() {
      isGettingSpeech = true;
    });

    final String url = "https://api.fpt.ai/hmi/tts/v5";
    final apiKey = await PrefUtils.getFptApiPref();
    print("Api: $apiKey\n");
    final _headers = {'api-key': apiKey, 'speed': '', 'voice': 'linhsan'};
    try {
      if (payload.length > 5000) payload = payload.substring(0, 4999);
      final response = await http.post(url, headers: _headers, body: payload);
      final _json = json.decode(response.body);
      link = _json["async"];
      return link;
    } catch (e) {
      print(e.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('API KEY hết hạn'), duration: (Duration(seconds: 1))));
      return link;
    }
  }

  play(String url) async {
    print(url);
    try {
      if (url == null && url == "")
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Không có nội dung'),
            duration: (Duration(seconds: 1))));
      while (true) {
        final response = await http.get(url);
        if (response.statusCode != 404) break;
      }
      int result = await speechPlayer.play(url, isLocal: false);
      if (result == 1) {
        setState(() {
          isOpened = true;
          isPlaying = true;
        });
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Không thể bật audio')));
      }
    } catch (e) {
      print(e);
    }
  }

  IconData _buildReadNewsIcon() {
    return Platform.isAndroid
        ? isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline
        : isPlaying ? CupertinoIcons.pause : CupertinoIcons.play_arrow;
  }

  IconData _buildBookMarkIcon() {
    return Platform.isAndroid
        ? isBookMarked ? Icons.bookmark : Icons.bookmark_border
        : isBookMarked ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark;
  }
}
