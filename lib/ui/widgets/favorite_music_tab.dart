import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/savedMusic/saved_music_bloc.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/ui/widgets/music/music_widget.dart';

class FavoriteMusicTab extends StatefulWidget {
  @override
  _FavoriteMusicTabState createState() => _FavoriteMusicTabState();
}

class _FavoriteMusicTabState extends State<FavoriteMusicTab> {
  SavedMusicBloc _savedMusicBloc;

  @override
  void initState() {
    super.initState();
    _savedMusicBloc = BlocProvider.of<SavedMusicBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                
              ),
            ),
          ),
        );
      },
      itemCount: musics.length,
    );
  }
}
