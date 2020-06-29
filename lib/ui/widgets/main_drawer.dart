import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/theme/theme_bloc.dart';
import 'package:trends/utils/custom_icons.dart';
import 'package:trends/utils/pref_utils.dart';

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
            alignment: Alignment.center,
            color: Theme.of(context).bottomAppBarColor,
            child: Text(
              "Cài đặt", textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22 * screenWidth / 360,),
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

  Widget _buildToggleButton(String type) {
    if (type == 'isDarkMode') {
      return Platform.isAndroid
          ? Switch(
              value: isDarkMode,
              onChanged: (newValue) {
                {
                  setState(() {
                    isDarkMode = newValue;
                    PrefUtils.setIsDarkModePref(isDarkMode);
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
                        PrefUtils.setIsDarkModePref(isDarkMode);
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
                    PrefUtils.setIsFastReadModePref(isFastReadMode);
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
                        PrefUtils.setIsFastReadModePref(isFastReadMode);
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
