import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trends/blocs/music/music_bloc.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/ui/widgets/music/music_widget.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MusicTab extends StatefulWidget {
  const MusicTab({Key key, this.category}) : super(key: key);

  @override
  _MusicTabState createState() => _MusicTabState();
  final String category;
}

class _MusicTabState extends State<MusicTab>
    with AutomaticKeepAliveClientMixin<MusicTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Music> _currentMusics;
  List<Audio>  _audios;

  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId("music");

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MusicBloc>(context).add(FetchMusics());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: BlocConsumer<MusicBloc, MusicState>(
          listener: (context, state) {
            if (state is MusicRefreshed) {
              _refreshController.refreshCompleted();
            }
          },
          builder: (context, state) {
            if (state is MusicInitial) {
              return buildInitialInput();
            } else if (state is MusicLoading) {
              return buildLoadingInput();
            } else if (state is MusicLoaded) {
              _currentMusics = state.musics;
              _audios = state.audios;
              return buildLoadedInput(_currentMusics);
            } else if (state is MusicRefreshing) {
              return buildLoadedInput(_currentMusics);
            } else if (state is MusicRefreshed) {
              _currentMusics = state.musics;
              return buildLoadedInput(_currentMusics);
            } else {
              return buildErrorInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Container(
      color: Colors.green,
    );
  }

  Widget buildLoadingInput() {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          backgroundColor: Colors.cyan,
          strokeWidth: 5,
        ),
      ),
    );
  }

  Widget buildErrorInput() {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          "ERROR !!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildLoadedInput(List<Music> musics) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = SizedBox();
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Tải thêm không thành công !");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("Buông để tải thêm");
          } else {
            body = Text("Không còn nội dụng để tải");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          return MusicWidget(
            music: musics[i],
            callback: () {
//              Navigator.of(context).pushNamed('', arguments: musics[i]);
              _assetsAudioPlayer.open(
                Playlist(audios: _audios),
                showNotification: true,
              );

            },
          );
        },
        itemCount: musics.length,
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    BlocProvider.of<MusicBloc>(context).add(RefreshMusics());
    //await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  void _onLoading() async {
    //await Future.delayed(Duration(milliseconds: 2000));

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  @override
  bool get wantKeepAlive => true;
}
