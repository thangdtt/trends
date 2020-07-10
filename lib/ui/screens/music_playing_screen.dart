import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedMusic/saved_music_bloc.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/ui/widgets/music/custom_icon_button.dart';
import 'package:trends/ui/widgets/music/animation_rotation_widget.dart';
import 'package:trends/utils/custom_icons.dart';
import 'package:trends/utils/player.dart';

class MusicPlayingScreen extends StatefulWidget {
  static const routeName = '/music-playing';

  const MusicPlayingScreen(
      {Key key, this.musics, this.audioPlayer, this.musicIndex, this.isPlaying})
      : super(key: key);

  @override
  _MusicPlayingScreenState createState() => _MusicPlayingScreenState();
  final List<Music> musics;
  final AudioPlayer audioPlayer;
  final int musicIndex;
  final bool isPlaying;
}

class _MusicPlayingScreenState extends State<MusicPlayingScreen> {
  double _second = 0;
  int _musicIndex;
  List<Music> _musics;
  double _totalTime = 1;
  AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isFavorite = false;
  StreamSubscription _onPlayerCompletion;
  StreamSubscription _onDurationChanged;
  StreamSubscription _onAudioPositionChanged;
  StreamSubscription _onPlayerStateChanged;
  Duration _duration;
  Duration _position;
  SavedMusicBloc _savedMusicBloc;
  bool _isDownloading = false;
  double _downloadPercentage = 0.0;
  String _downloadMessage = "";
  bool _isShuffle = false;

  @override
  void dispose() {
    super.dispose();
    _isShuffle = isShuffle;
    _onPlayerCompletion?.cancel();
    _onDurationChanged?.cancel();
    _onAudioPositionChanged?.cancel();
    _onPlayerStateChanged?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _savedMusicBloc = BlocProvider.of<SavedMusicBloc>(context);

    _musics = widget.musics;

    _audioPlayer = widget.audioPlayer;

    _musicIndex = widget.musicIndex;

    try {
      for (var item in (_savedMusicBloc.state as SavedMusicLoaded).musics) {
        if (_musics[_musicIndex].id == item.id) {
          setState(() {
            _isFavorite = true;
          });
          break;
        }
      }
    } catch (e) {
      print(e);
    }

    _isPlaying = widget.isPlaying;
    _onPlayerCompletion = _audioPlayer.onPlayerCompletion.listen((event) {
      _position = _duration;
      changeMusicIndex(_musicIndex + 1);
    });
    _onDurationChanged = _audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
        _totalTime = event.inMilliseconds.toDouble();
      });
    });
    _onAudioPositionChanged =
        _audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        _position = event;
        _second = event.inMilliseconds.toDouble();
      });
    });
    _audioPlayer.onPlayerStateChanged;
    _onPlayerStateChanged = _audioPlayer.onPlayerStateChanged.listen((event) {
      switch (event) {
        case AudioPlayerState.STOPPED:
          _isPlaying = false;
          break;
        case AudioPlayerState.PLAYING:
          _isPlaying = true;
          break;
        case AudioPlayerState.PAUSED:
          _isPlaying = false;
          break;
        case AudioPlayerState.COMPLETED:
          _isPlaying = false;
          break;
      }
      setState(() {});
    });
  }

  Future<void> changeMusicIndex(int index) async {
    _musicIndex = index;
    if (_musicIndex > _musics.length - 1) {
      _musicIndex = 0;
    } else if (_musicIndex < 0) {
      _musicIndex = _musics.length - 1;
    }
    setState(() {
      _position = null;
    });
    await _audioPlayer.play(_musics[_musicIndex].link);
  }

  String _formatDuration(Duration duration) {
    final List<String> durationSplit =
        (duration?.toString()?.split('.')?.first ?? '').split(':');
    return durationSplit[1] + ':' + durationSplit[2];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double aspectWidth = screenWidth / 360;
    final double aspectHeight = screenHeight / 760;
    return WillPopScope(
      onWillPop: () async {
        final Map<String, Object> mapArguments = <String, Object>{
          'musicIndex': _musicIndex,
          'isPlaying': _isPlaying
        };
        Navigator.of(context).pop(mapArguments);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_musics[_musicIndex].image),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20 * aspectWidth,
                        right: 20 * aspectWidth,
                        top: 20 * aspectHeight),
                    child: Row(
                      children: <Widget>[
                        CustomIconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          iconSize: 25 * aspectWidth,
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            final Map<String, Object> mapArguments =
                                <String, Object>{
                              'musicIndex': _musicIndex,
                              'isPlaying': _isPlaying
                            };
                            Navigator.of(context).pop(mapArguments);
                          },
                        ),
                        SizedBox(
                          width: 10 * aspectWidth,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _musics[_musicIndex].name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                _musics[_musicIndex].singer,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10 * aspectWidth,
                        ),
                        CustomIconButton(
                          tooltip: "Hẹn giờ tắt nhạc",
                          icon: Icon(
                            Icons.alarm,
                            color: Colors.white,
                          ),
                          iconSize: 25 * aspectWidth,
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            buildDialog();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20 * aspectHeight,
                  ),
                  AnimationRotationWidget(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300.0),
                      child: Container(
                        height: 320 * aspectWidth,
                        width: 320 * aspectWidth,
                        child: Align(
                          alignment: Alignment.center,
                          widthFactor: 0.4,
                          heightFactor: 1.0,
                          child: Image.network(_musics[_musicIndex].image),
                        ),
                      ),
                    ),
                    play: _isPlaying,
                  ),
                  SizedBox(
                    height: 20 * aspectHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 40 * aspectWidth, right: 40 * aspectWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          iconSize: 30 * aspectWidth,
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          tooltip: "Tải nhạc",
                          iconSize: 30 * aspectWidth,
                          onPressed: () {
                            _downloadMusic(_musics[_musicIndex].link,
                                _musics[_musicIndex].name);
                          },
                          icon: Icon(
                            Icons.file_download,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          tooltip: "Chia sẻ nhạc",
                          iconSize: 30 * aspectWidth,
                          onPressed: () {
                            Share.share(
                                "${_musics[_musicIndex].name} - ${_musics[_musicIndex].singer}\nlink: ${_musics[_musicIndex].link}",
                                subject:
                                    "${_musics[_musicIndex].name} - ${_musics[_musicIndex].singer}");
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          tooltip: "Yêu thích",
                          iconSize: 30 * aspectWidth,
                          onPressed: () {
                            setState(() {
                              _favoriteHandler();
                            });
                          },
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20 * aspectWidth, right: 20 * aspectWidth),
                    child: Row(
                      children: <Widget>[
                        Text(
                          _position != null
                              ? _formatDuration(_position)
                              : '00:00',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Slider(
                            value: (_position != null &&
                                    _duration != null &&
                                    _position.inMilliseconds > 0 &&
                                    _position.inMilliseconds <
                                        _duration.inMilliseconds)
                                ? _position.inMilliseconds /
                                    _duration.inMilliseconds
                                : 0.0,
                            onChanged: (double value) async {
                              final double position =
                                  value * _duration.inMilliseconds;
                              _audioPlayer.seek(
                                  Duration(milliseconds: position.round()));
                            },
                          ),
                        ),
                        Text(
                          _duration != null
                              ? _formatDuration(_duration)
                              : '00:00',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20 * aspectWidth, right: 20 * aspectWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          iconSize: 28 * aspectWidth,
                          onPressed: () {
                            _isShuffle = !_isShuffle;
                            isShuffle = !isShuffle;
                            setState(() {});
                          },
                          icon: Icon(
                            CustomIcons.shuffle,
                            color: isShuffle
                                ? Theme.of(context).splashColor
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          iconSize: 35 * aspectWidth,
                          onPressed: () {
                            isShuffle
                                ? changeMusicIndex(
                                    _musicIndex - 1 - new Random().nextInt(5))
                                : changeMusicIndex(_musicIndex - 1);
                          },
                          icon: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          iconSize: 70 * aspectWidth,
                          onPressed: () {
                            if (_isPlaying) {
                              _audioPlayer.pause();
                            } else {
                              _audioPlayer.resume();
                            }
                          },
                          icon: Icon(
                            _isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            size: 70 * aspectWidth,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          iconSize: 35 * aspectWidth,
                          onPressed: () {
                            isShuffle
                                ? changeMusicIndex(
                                    _musicIndex + 1 + new Random().nextInt(5))
                                : changeMusicIndex(_musicIndex + 1);
                          },
                          icon: Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          iconSize: 35 * aspectWidth,
                          onPressed: () {},
                          icon: Icon(
                            Icons.repeat,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20 * aspectHeight,
                  ),
                  if (_isDownloading)
                    Text(
                      _downloadMessage,
                      style: TextStyle(
                          color: Colors.white, fontSize: 12 * aspectWidth),
                    ),
                  if (_isDownloading)
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 50 * aspectWidth,
                          vertical: 5 * aspectWidth),
                      child: LinearProgressIndicator(
                        value: _downloadPercentage / 100,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _favoriteHandler() async {
    bool existed = false;
    try {
      for (var item in (_savedMusicBloc.state as SavedMusicLoaded).musics) {
        if (_musics[_musicIndex].id == item.id) {
          existed = true;
          break;
        }
      }
    } catch (e) {
      print(e);
    }

    if (existed) {
      _isFavorite = false;
      _savedMusicBloc.add(DeleteSaveMusic(widget.musics[_musicIndex]));
    } else {
      _isFavorite = true;
      _savedMusicBloc.add(AddSaveMusic(widget.musics[_musicIndex]));
    }
  }

  Future<void> _downloadMusic(String link, String fileName) async {
    Dio dio = new Dio();
    try {
      setState(() {
        _isDownloading = true;
      });
      var dir = await getExternalStorageDirectory();
      await dio.download(
        link,
        "${dir.path}/$fileName.mp3",
        onReceiveProgress: (count, total) {
          var percentage = count / total * 100;
          setState(() {
            _downloadPercentage = percentage;
            _downloadMessage = "Đang tải ${percentage.floor()}%";
          });
          if (count >= total) {
            _isDownloading = false;
            _downloadMessage = "";
            _downloadPercentage = 0;
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String> buildDialog() async {
    Duration changeValue;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: autoTurnMusicOff
                ? Text("Cách giờ tắt nhạc ${turnfOffTime.inMinutes} phút")
                : Text("Hẹn giờ tắt nhạc"),
            content: Container(
              height: MediaQuery.of(context).size.height / 5,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: turnfOffTime,
                onTimerDurationChanged: (value) {
                  changeValue = value;
                },
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                elevation: 5,
                child: Text("Huỷ hẹn giờ"),
                onPressed: () {
                  cancelTimer();
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                elevation: 5,
                child: Text("Đóng"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                elevation: 5,
                child: Text("OK"),
                onPressed: () {
                  if (autoTurnMusicOff) cancelTimer();
                  turnfOffTime = changeValue;
                  startTimer();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
