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
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    onPlayerStateChanged = audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.COMPLETED) {
        changeMusicIndex(_currentIndex + 1);
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
      _currentIndex = 0;
    } else if (_currentIndex < 0) {
      _currentIndex = _currentMusics.length - 1;
    }
    _currentMusic = _currentMusics[_currentIndex];
    await audioPlayer.play(_currentMusic.link);
    setState(() {});
  }

  void _handleTabSelection() {}

  @override
  void dispose() {
    _tabController.dispose();
    audioPlayer.dispose();
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
                child: Text("Việt nam"),
              ),
              Tab(
                child: Text("US-UK"),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: Stack(
        children: <Widget>[
          TabBarView(
            children: [
              BlocProvider(
                create: (BuildContext context) {
                  return MusicBloc('vn');
                },
                child: MusicTab(
                  onPressPlay: (List<Music> musics, int index) async {
                    _currentIndex = index;
                    _currentMusics = musics;
                    _currentMusic = _currentMusics[index];
                    _isPlaying = true;
                    audioPlayerSave.stop();
                    audioPlayer.play(_currentMusic.link);
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
                    audioPlayer.play(_currentMusic.link);
                    setState(() {});
                  },
                ),
              ),
            ],
            controller: _tabController,
          ),
          if (_currentMusic != null)
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  final Map<String, Object> mapArguments = <String, Object>{
                    'musics': _currentMusics,
                    'audioPlayer': audioPlayer,
                    'musicIndex': _currentIndex,
                    'isPlaying': _isPlaying
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
                    isShuffle
                        ? changeMusicIndex(
                            _currentIndex + 1 + new Random().nextInt(5))
                        : changeMusicIndex(_currentIndex + 1);
                  },
                  playCallBack: () async {
                    if (!_isPlaying) {
                      audioPlayerSave.stop();
                      await audioPlayer.play(_currentMusic.link);
                      _isPlaying = true;
                      setState(() {});
                    } else {
                      await audioPlayer.pause();
                      _isPlaying = false;
                      setState(() {});
                    }
                  },
                  previousCallBack: () {
                    isShuffle
                        ? changeMusicIndex(
                            _currentIndex - 1 - new Random().nextInt(5))
                        : changeMusicIndex(_currentIndex - 1);
                  },
                ),
              ),
            )
          else
            const SizedBox()
        ],
      ),
    );
  }
}
