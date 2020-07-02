import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trends/blocs/theme/theme_bloc.dart';
import 'package:trends/blocs/history/history_bloc.dart';
import 'package:trends/utils/custom_icons.dart';
import 'package:trends/utils/pref_utils.dart';
import 'package:trends/utils/utils_class.dart';
import 'package:trends/ui/screens/read_history_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isDarkMode;
  bool isFastReadMode;
  bool filterChange;
  Map<categoryEnum, bool> currentFilter;

  Key _key = Key("this");
  @override
  void initState() {
    super.initState();
    filterChange = false;
    isDarkMode =
        (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded).isDarkMode;
    isFastReadMode = (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded)
        .isFastReadMode;
    currentFilter = {
      categoryEnum.TinNong: false,
      categoryEnum.TinMoi: false,
      categoryEnum.ThoiSu: false,
      categoryEnum.TheGioi: false,
      categoryEnum.KinhDoanh: false,
      categoryEnum.GiaiTri: false,
      categoryEnum.TheThao: false,
      categoryEnum.PhapLuat: false,
      categoryEnum.GiaoDuc: false,
      categoryEnum.SucKhoe: false,
      categoryEnum.DoiSong: false,
      categoryEnum.DuLich: false,
      categoryEnum.KhoaHoc: false,
      categoryEnum.SoHoa: false,
      categoryEnum.Xe: false,
    };
    for (var key in tabFilter.keys) currentFilter[key] = tabFilter[key];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Dismissible(
      key: _key,
      confirmDismiss: (direction) {
        return _willPopHandler();
      },
      direction: DismissDirection.endToStart,
      // onDismissed: (direction) {
      //   Navigator.of(context).pop();
      // },

      child: WillPopScope(
        onWillPop: _willPopHandler,
        child: Drawer(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 20 * screenHeight / 360,
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Cài đặt",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22 * screenWidth / 360,
                      ),
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
                              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                              child: Icon(
                                CustomIcons.moon,
                                size: 12 * screenHeight / 360,
                              ),
                            ),
                            Text(
                              "Chế độ tối",
                              style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize: 12 * screenHeight / 360,
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
                              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                              child: Icon(
                                Icons.library_books,
                                size: 12 * screenHeight / 360,
                              ),
                            ),
                            Text(
                              "Chế độ đọc nhanh",
                              style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize: 12 * screenHeight / 360,
                              ),
                            ),
                          ],
                        ),
                        _buildToggleButton('isFastReadingMode'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ExpansionTile(
                      title: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Icon(
                            Icons.filter_list,
                            size: 12 * screenHeight / 360,
                          ),
                        ),
                        Text(
                          "Lọc",
                          style: TextStyle(
                              fontSize: 12 * screenHeight / 360,
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                      children: _buildFilterButtons(),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<HistoryBloc>(context).add(GetHistoryArticles());
                      Navigator.of(context).pushNamed(ReadHistoryScreen.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                            child: Icon(
                              Icons.history,
                              size: 12 * screenHeight / 360,
                            ),
                          ),
                          Text(
                            "Lịch sử bài đã xem",
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 12 * screenHeight / 360,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
              scale: 0.85,
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
              scale: 0.85,
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

  List<Widget> _buildFilterButtons() {
    List<Widget> list = List();
    categoryEnum.values.forEach((value) {
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  mapCategoryNames[value],
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 12 * MediaQuery.of(context).size.height / 360,
                  ),
                ),
              ],
            ),
            _buildFilterButton(value),
          ],
        ),
      ));
    });
    return list;
  }

  Widget _buildFilterButton(categoryEnum category) {
    return Platform.isAndroid
        ? Switch(
            value: tabFilter[category],
            onChanged: (newValue) {
              {
                setState(() {
                  filterChange = true;
                  tabFilter[category] = newValue;
                  PrefUtils.setFilterPref(tabFilterToList());
                });
              }
            })
        : Transform.scale(
            scale: 0.85,
            child: CupertinoSwitch(
                value: tabFilter[category],
                onChanged: (newValue) {
                  {
                    setState(() {
                      filterChange = true;
                      tabFilter[category] = newValue;
                      PrefUtils.setFilterPref(tabFilterToList());
                    });
                  }
                }),
          );
  }

  Future<bool> _willPopHandler() {
    if (filterChange) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Khởi động lại app ?"),
              content: Text("Lọc chuyên mục yêu cầu khởi động lại app"),
              actions: <Widget>[
                FlatButton(
                    child: Text('Không'),
                    onPressed: () {
                      setState(() {
                        for (var key in currentFilter.keys)
                          tabFilter[key] = currentFilter[key];
                        filterChange = false;
                        PrefUtils.setFilterPref(tabFilterToList());
                      });
                      Navigator.of(context).pop(false);
                    }),
                FlatButton(
                    child: Text('Có'),
                    onPressed: () {
                      Phoenix.rebirth(context);
                      Navigator.of(context).pop(true);
                    }),
              ],
            );
          });
    }
    Navigator.of(context).pop(true);
  }
}
