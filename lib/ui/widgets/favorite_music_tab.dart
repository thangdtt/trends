import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedMusic/saved_music_bloc.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/ui/screens/music_playing_screen.dart';
import 'package:trends/ui/widgets/music/music_widget.dart';
import 'package:trends/utils/player.dart';

import 'music/music_playing.dart';

class FavoriteMusicTab extends StatefulWidget {
  @override
  _FavoriteMusicTabState createState() => _FavoriteMusicTabState();
}

class _FavoriteMusicTabState extends State<FavoriteMusicTab>
    with AutomaticKeepAliveClientMixin {
  SavedMusicBloc _savedMusicBloc;
  bool _isPlaying = false;
  List<Music> _currentMusics;
  Music _currentMusic;
  int _currentIndex = 0;
  StreamSubscription onPlayerStateChanged;

  @override
  void initState() {
    super.initState();
    _savedMusicBloc = BlocProvider.of<SavedMusicBloc>(context);
    if (audioPlayerSave.state == AudioPlayerState.PLAYING) _isPlaying = true;
    onPlayerStateChanged = audioPlayerSave.onPlayerStateChanged.listen((event) {
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

  @override
  void dispose() {
    onPlayerStateChanged?.cancel();
    super.dispose();
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
    await audioPlayerSave.play(_currentMusic.link);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
                  child: Container(
            child: BlocBuilder<SavedMusicBloc, SavedMusicState>(
              bloc: _savedMusicBloc,
              builder: (context, state) {
                if (state is SavedMusicInitial) {
                  return Container();
                } else if (state is SavedMusicLoading) {
                  return Center(child: Text("Đang tải"));
                } else if (state is SavedMusicLoaded) {
                  if (state.musics.isEmpty)
                    return Center(child: Text("Không có bài hát được lưu!"));
                  else
                    return buildLoadedInput(state.musics, context);
                } else
                  return Center(child: Text("Xảy ra lỗi"));
              },
            ),
          ),
        ),
        if (_currentMusic != null)
          GestureDetector(
            onTap: () async {
              final Map<String, Object> mapArguments = <String, Object>{
                'musics': _currentMusics,
                'audioPlayer': audioPlayerSave,
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
                  audioPlayerMain.stop();
                  await audioPlayerSave.play(_currentMusic.link);
                  _isPlaying = true;
                  setState(() {});
                } else {
                  await audioPlayerSave.pause();
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
    );
  }

  Widget buildLoadedInput(List<Music> musics, BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return Container(
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              _savedMusicBloc.add(DeleteSaveMusic(musics[i]));
            },
            background: Container(
              color: Colors.red[400],
              child: Container(
                  margin: const EdgeInsets.all(30), child: Icon(Icons.delete)),
              alignment: AlignmentDirectional.centerEnd,
            ),
            direction: DismissDirection.endToStart,
            child: Container(
              padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: MusicWidget(
                  music: musics[i],
                  callback: () async {
                    _currentIndex = i;
                    _currentMusics = musics;
                    _currentMusic = _currentMusics[i];
                    _isPlaying = true;
                    audioPlayerMain.stop();
                    audioPlayerSave.play(_currentMusic.link);
                    setState(() {});
                  }),
            ),
          ),
        );
      },
      itemCount: musics.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
