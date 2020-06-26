import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trends/ui/screens/bottom_tab_screen.dart';
import 'package:trends/ui/widgets/article_content.dart';
import 'blocs/article/article_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //turn off rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ArticleBloc(),
          ),
        ],
        child: RefreshConfiguration(
          headerTriggerDistance:
              80.0, // header trigger refresh trigger distance
          maxOverScrollExtent:
              100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
          maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
          enableScrollWhenRefreshCompleted:
              true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
          enableLoadingWhenFailed:
              true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
          hideFooterWhenNotFull:
              false, // Disable pull-up to load more functionality when Viewport is less than one screen
          enableBallisticLoad:
              true, // trigger load more by BallisticScrollActivity
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              canvasColor: Color.fromRGBO(255, 254, 229, 1),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 72.0, fontStyle: FontStyle.italic),
                headline6:
                    TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                bodyText2: TextStyle(fontSize: 19, fontFamily: 'Hind'),
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (ctx) => BottomTabScreen(),
              //ArticleContentScreen.routeName: (ctx) => ArticleContentScreen(),
              ArticleContentWidget.routeName: (ctx) => ArticleContentWidget(),
            },
          ),
        ));
  }
}
