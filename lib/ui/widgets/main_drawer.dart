import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  bool isFastReadMode;
  @override
  void initState() {
    super.initState();
    isDarkMode =
        (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded).isDarkMode;
    isFastReadMode = (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded)
        .isFastReadMode;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        child: Column(children: <Widget>[
          Container(
            height: 20 * screenHeight / 360,
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
                _buildToggleButton('isDarkMode'),
              ],
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
                        Icons.library_books,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Chế độ đọc nhanh",
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 10 * screenHeight / 360,
                      ),
                    ),
                  ],
                ),
                _buildToggleButton('isFastReadingMode'),
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

  setIsFastReadModePref(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFastReadMode', value);
  }

  Widget _buildToggleButton(String type) {
    if (type == 'isDarkMode') {
      return Platform.isAndroid
          ? Switch(
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
              })
          : Transform.scale(
              scale: 0.65,
              child: CupertinoSwitch(
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
            );
    } else if (type == 'isFastReadingMode') {
      return Platform.isAndroid
          ? Switch(
              value: isFastReadMode,
              onChanged: (newValue) {
                {
                  setState(() {
                    isFastReadMode = newValue;
                    setIsFastReadModePref(isFastReadMode);
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChanged(isFastReadMode: newValue));
                  });
                }
              })
          : Transform.scale(
              scale: 0.65,
              child: CupertinoSwitch(
                  value: isFastReadMode,
                  onChanged: (newValue) {
                    {
                      setState(() {
                        isFastReadMode = newValue;
                        setIsFastReadModePref(isFastReadMode);
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ThemeChanged(isFastReadMode: newValue));
                      });
                    }
                  }),
            );
    } else
      return Container();
  }
}
