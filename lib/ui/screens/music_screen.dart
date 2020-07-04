import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/music/music_bloc.dart';
import 'package:trends/ui/widgets/music/music_tab.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> categories = <String>['vn', 'us-uk'];
  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId("music");
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {}

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
                child: Text("VN"),
              ),
              Tab(
                child: Text("US-UK"),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: TabBarView(
        children: [
          BlocProvider(
            create: (BuildContext context) {
              return MusicBloc('vn');
            },
            child: MusicTab(
              category: 'vn',
            ),
          ),
          BlocProvider(
            create: (BuildContext context) {
              return MusicBloc('us-uk');
            },
            child: MusicTab(
              category: 'us-uk',
            ),
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
