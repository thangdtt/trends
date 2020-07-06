import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trends/blocs/database/database_bloc.dart';
import 'package:trends/blocs/history/history_bloc.dart';
import 'package:trends/blocs/searchArticle/searcharticle_bloc.dart';
import 'package:trends/blocs/suggestArticle/suggestArticle_bloc.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';
import 'package:trends/data/models/article.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/ui/screens/bottom_tab_screen.dart';
import 'package:trends/ui/screens/music_playing_screen.dart';
import 'package:trends/ui/screens/read_history_screen.dart';
import 'package:trends/ui/screens/splash_screen.dart';
import 'package:trends/ui/widgets/article_content.dart';
import 'package:trends/utils/utils_class.dart';

import 'blocs/article/article_bloc.dart';

void main() {
  runApp(
    Phoenix(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //turn off rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (BuildContext context) => ArticleBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider<SearcharticleBloc>(
          create: (BuildContext context) => SearcharticleBloc(),
        ),
        BlocProvider<DatabaseBloc>(
          create: (BuildContext context) => DatabaseBloc(),
        ),
        BlocProvider<SuggestArticleBloc>(
          create: (BuildContext context) => SuggestArticleBloc(),
        ),
        BlocProvider<HistoryBloc>(
          create: (BuildContext context) => HistoryBloc(),
        ),
      ],
      child: RefreshConfiguration(
        headerTriggerDistance: 80.0,
        maxOverScrollExtent: 100,
        maxUnderScrollExtent: 0,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        hideFooterWhenNotFull: false,
        enableBallisticLoad: true,
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          if (state is ThemeLoading || state is ThemeInitial)
            return MaterialApp(
              home: SplashScreen(),
            );
          else if (state is ThemeLoaded)
            return _buildWithTheme(context, state.themeData);
          else
            return Container();
        }),
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeData theme) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      initialRoute: '/',
      home: BottomTabScreen(),
      onGenerateRoute: (settings) {
        final name = settings.name;
        switch (name) {
          case MusicPlayingScreen.routeName:
            Map<String, dynamic> arguments = settings.arguments;
            final List<Music> musics = arguments['musics'];
            final int musicIndex = arguments['musicIndex'];
            final AudioPlayer audioPlayer = arguments['audioPlayer'];
            final bool isPlaying = arguments['isPlaying'];
            final int second = arguments['second'];
            final int duration = arguments['duration'];
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MusicPlayingScreen(
                      audioPlayer: audioPlayer,
                      musicIndex: musicIndex,
                      musics: musics,
                      isPlaying: isPlaying,
                      second: second,
                      duration: duration,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                settings: RouteSettings(name: name, arguments: arguments));
            break;
          case ArticleContentWidget.routeName:
            Map<String, dynamic> arguments = settings.arguments;
            Article article = arguments['article'];
            categoryEnum catEnum = arguments['catEnum'];
            return MaterialPageRoute(
                builder: (context) {
                  return ArticleContentWidget(
                    article: article,
                    catEnum: catEnum,
                  );
                },
                settings: RouteSettings(name: name, arguments: arguments));
          case ReadHistoryScreen.routeName:
            return MaterialPageRoute(
                builder: (context) {
                  return ReadHistoryScreen();
                },
                settings: RouteSettings(name: name));
        }
        return MaterialPageRoute(
            builder: (context) {
              return BottomTabScreen();
            },
            settings: RouteSettings(name: name));
      },
//      routes: {
//        //'/': (ctx) => BottomTabScreen(),
//        ArticleContentWidget.routeName: (ctx) => ArticleContentWidget(),
//        ReadHistoryScreen.routeName: (ctx) => ReadHistoryScreen(),
//        MusicPlayingScreen.routeName: (ctx) => MusicPlayingScreen(),
//      },
    );
  }
}
