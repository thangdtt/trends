import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/music/music_bloc.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/ui/screens/music_playing_screen.dart';
import 'package:trends/ui/widgets/music/music_playing.dart';
import 'package:trends/ui/widgets/music/music_tab.dart';
import 'package:trends/utils/player.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> categories = <String>['vn', 'us-uk'];
  bool _isPlaying = false;
  List<Music> _currentMusics;
  Music _currentMusic;
  int _currentIndex = 0;
  StreamSubscription onPlayerStateChanged;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 7, vsync: this);
    _tabController.addListener(_handleTabSelection);
    onPlayerStateChanged = audioPlayerMain.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.COMPLETED) {
        random = new Random().nextInt(5);
        if (isShuffle) {
          if (isRepeatOne) {
            changeMusicIndex(currentMusicIndex);
          } else {
            currentMusicIndex += 1 + random;
            changeMusicIndex(currentMusicIndex);
          }
        } else {
          if (isRepeatOne) {
            changeMusicIndex(currentMusicIndex);
          } else {
            currentMusicIndex++;
            changeMusicIndex(currentMusicIndex);
          }
        }
      }
      if (event == AudioPlayerState.STOPPED) {
        _isPlaying = false;
        setState(() {});
      }
    });
  }

  Future<void> changeMusicIndex(int index) async {
    _currentIndex = index;
    if (_currentIndex > _currentMusics.length - 1) {
      currentMusicIndex = 0;
      _currentIndex = 0;
    } else if (_currentIndex < 0) {
      currentMusicIndex = _currentMusics.length - 1;
      _currentIndex = _currentMusics.length - 1;
    }
    _currentMusic = _currentMusics[_currentIndex];
    await audioPlayerMain.play(_currentMusic.link);
    setState(() {});
  }

  void _handleTabSelection() {}

  @override
  void dispose() {
    _tabController.dispose();
    onPlayerStateChanged?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text("Việt Nam"),
              ),
              Tab(
                child: Text("US-UK"),
              ),
              Tab(
                child: Text("Nhạc Hoa"),
              ),
              Tab(
                child: Text("Nhạc Hàn"),
              ),
              Tab(
                child: Text("Nhạc Nhật"),
              ),
              Tab(
                child: Text("Nhạc Pháp"),
              ),
              Tab(
                child: Text("Nước khác"),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  children: [
                    BlocProvider(
                      create: (BuildContext context) {
                        return MusicBloc('vn');
                      },
                      child: MusicTab(
                        onPressPlay: (List<Music> musics, int index) async {
                          _currentIndex = index;
                          currentMusicIndex = _currentIndex;
                          _currentMusics = musics;
                          _currentMusic = _currentMusics[index];
                          _isPlaying = true;
                          audioPlayerSave.stop();
                          audioPlayerMain.play(_currentMusic.link);
                          setState(() {});
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return MusicBloc('us-uk');
                      },
                      child: MusicTab(
                        onPressPlay: (List<Music> musics, int index) async {
                          _currentIndex = index;
                          _currentMusics = musics;
                          _currentMusic = _currentMusics[index];
                          _isPlaying = true;
                          audioPlayerSave.stop();
                          audioPlayerMain.play(_currentMusic.link);
                          setState(() {});
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return MusicBloc('cn');
                      },
                      child: MusicTab(
                        onPressPlay: (List<Music> musics, int index) async {
                          _currentIndex = index;
                          _currentMusics = musics;
                          _currentMusic = _currentMusics[index];
                          _isPlaying = true;
                          audioPlayerSave.stop();
                          audioPlayerMain.play(_currentMusic.link);
                          setState(() {});
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return MusicBloc('kr');
                      },
                      child: MusicTab(
                        onPressPlay: (List<Music> musics, int index) async {
                          _currentIndex = index;
                          _currentMusics = musics;
                          _currentMusic = _currentMusics[index];
                          _isPlaying = true;
                          audioPlayerSave.stop();
                          audioPlayerMain.play(_currentMusic.link);
                          setState(() {});
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return MusicBloc('jp');
                      },
                      child: MusicTab(
                        onPressPlay: (List<Music> musics, int index) async {
                          _currentIndex = index;
                          _currentMusics = musics;
                          _currentMusic = _currentMusics[index];
                          _isPlaying = true;
                          audioPlayerSave.stop();
                          audioPlayerMain.play(_currentMusic.link);
                          setState(() {});
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return MusicBloc('fr');
                      },
                      child: MusicTab(
                        onPressPlay: (List<Music> musics, int index) async {
                          _currentIndex = index;
                          _currentMusics = musics;
                          _currentMusic = _currentMusics[index];
                          _isPlaying = true;
                          audioPlayerSave.stop();
                          audioPlayerMain.play(_currentMusic.link);
                          setState(() {});
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return MusicBloc('other');
                      },
                      child: MusicTab(
                        onPressPlay: (List<Music> musics, int index) async {
                          _currentIndex = index;
                          _currentMusics = musics;
                          _currentMusic = _currentMusics[index];
                          _isPlaying = true;
                          audioPlayerSave.stop();
                          audioPlayerMain.play(_currentMusic.link);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
              if (_currentMusic != null)
                GestureDetector(
                  onTap: () async {
                    final Map<String, Object> mapArguments = <String, Object>{
                      'musics': _currentMusics,
                      'audioPlayer': audioPlayerMain,
                      'musicIndex': _currentIndex,
                      'isPlaying': _isPlaying,
                    };
                    final Map<String, dynamic> mapResult =
                        await Navigator.of(context).pushNamed(
                            MusicPlayingScreen.routeName,
                            arguments: mapArguments) as Map<String, dynamic>;
                    if (mapResult != null) {
                      setState(() {
                        _currentIndex = mapResult['musicIndex'];
                        _currentMusic = _currentMusics[_currentIndex];
                        _isPlaying = mapResult['isPlaying'];
                      });
                    }
                  },
                  child: MusicPlaying(
                    isPlaying: _isPlaying,
                    music: _currentMusic,
                    nextCallBack: () {
                      if (isShuffle) {
                        random = new Random().nextInt(5);
                        currentMusicIndex += 1 + random;
                        changeMusicIndex(currentMusicIndex);
                      } else {
                        currentMusicIndex++;
                        changeMusicIndex(currentMusicIndex);
                      }
                    },
                    playCallBack: () async {
                      if (!_isPlaying) {
                        audioPlayerSave.stop();
                        await audioPlayerMain.play(_currentMusic.link);
                        _isPlaying = true;
                        setState(() {});
                      } else {
                        await audioPlayerMain.pause();
                        _isPlaying = false;
                        setState(() {});
                      }
                    },
                    previousCallBack: () {
                      if (isShuffle) {
                        random = new Random().nextInt(5);
                        currentMusicIndex -= 1 + random;
                        changeMusicIndex(currentMusicIndex);
                      } else {
                        currentMusicIndex--;
                        changeMusicIndex(currentMusicIndex);
                      }
                    },
                  ),
                )
              else
                const SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
