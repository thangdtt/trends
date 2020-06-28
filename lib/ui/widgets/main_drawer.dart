import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trends/blocs/theme/theme_bloc.dart';
import 'package:trends/utils/custom_icons.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isDarkMode;
  @override
  void initState() {
    super.initState();
    isDarkMode = (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded).isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        child: Column(children: <Widget>[
          Container(
            height: Scaffold.of(context).appBarMaxHeight,
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).bottomAppBarColor,
            child: Text(
              "Drawer testing",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20 * screenWidth / 360,
                  color: Colors.white70),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(
                        CustomIcons.moon,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Chế độ tối",
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 10 * screenHeight / 360,
                      ),
                    ),
                  ],
                ),
                Switch(
                    value: isDarkMode,
                    onChanged: (newValue) {
                      {
                        setState(() {
                          isDarkMode = newValue;
                          setIsDarkModePref(isDarkMode);
                          BlocProvider.of<ThemeBloc>(context)
                              .add(ThemeChanged(isDarkMode: newValue));
                        });
                      }
                    }),
              ],
            ),
          ),

          // buildListTile("Filter", Icons.settings, () {
          //   //Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          // }),
        ]),
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  setIsDarkModePref(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }
}
