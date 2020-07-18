import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/blocs/theme/theme_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //BlocProvider.of<ThemeBloc>(context).add(LoadTheme());
    _waitFor(Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splash.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future _waitFor(Duration duration) async {
    await new Future.delayed(duration);
    BlocProvider.of<ThemeBloc>(context).add(LoadTheme());
  }
}
