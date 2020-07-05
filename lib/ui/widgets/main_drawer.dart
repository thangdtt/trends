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

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isDarkMode;
  bool isFastReadMode;
  bool filterChange;
  Map<categoryEnum, bool> currentFilter;

  @override
  void initState() {
    super.initState();
    filterChange = false;
    isDarkMode =
        (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded).isDarkMode;
    isFastReadMode = (BlocProvider.of<ThemeBloc>(context).state as ThemeLoaded)
        .isFastReadMode;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        if (state is ThemeLoaded) {
          currentFilter = state.tabFilter;
        }
        if (currentFilter == null) {
          return Container();
        }
        return Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 23 * screenHeight / 360,
                      width: double.infinity,
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
                    Divider(endIndent: 0,indent: 0,height: 1,thickness: 0.5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                child: Icon(
                                  CustomIcons.moon,
                                  size: 20 * screenWidth / 360,
                                ),
                              ),
                              Text(
                                "Chế độ tối",
                                style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 20 * screenWidth / 360,
                                ),
                              ),
                            ],
                          ),
                          _buildToggleButton('isDarkMode'),
                        ],
                      ),
                    ),
                    Divider(endIndent: 0,indent: 0,height: 1,thickness: 0.5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                child: Icon(
                                  Icons.library_books,
                                  size: 20 * screenWidth / 360,
                                ),
                              ),
                              Text(
                                "Chế độ đọc nhanh",
                                style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 20 * screenWidth / 360,
                                ),
                              ),
                            ],
                          ),
                          _buildToggleButton('isFastReadingMode'),
                        ],
                      ),
                    ),
                    Divider(endIndent: 0,indent: 0,height: 1,thickness: 0.5,),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<HistoryBloc>(context)
                            .add(GetHistoryArticles());
                        Navigator.of(context)
                            .pushNamed(ReadHistoryScreen.routeName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 0, 10, 0),
                              child: Icon(
                                Icons.history,
                                size: 20 * screenWidth / 360,
                              ),
                            ),
                            Text(
                              "Lịch sử bài đã xem",
                              style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize: 20 * screenWidth / 360,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                    ),
                    Divider(endIndent: 0,indent: 0,height: 1,thickness: 0.5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 10),
                      child: GestureDetector(
                        onTap: () => buildDialog()
                            .then((value) => PrefUtils.setFptApiPref(value)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                  child: Icon(
                                    Icons.insert_link,
                                    size: 20 * screenWidth / 360,
                                  ),
                                ),
                                Text(
                                  "Đổi key FPT Api",
                                  style: TextStyle(
                                    fontFamily: 'RobotoCondensed',
                                    fontSize: 20 * screenWidth / 360,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(endIndent: 0,indent: 0,height: 1,thickness: 0.5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: ExpansionTile(
                        title: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(
                              Icons.filter_list,
                              size: 20 * screenWidth / 360,
                            ),
                          ),
                          Text(
                            "Lọc",
                            style: TextStyle(
                                fontSize: 20 * screenWidth / 360,
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                        children: _buildFilterButtons(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
                    fontSize: 20 * MediaQuery.of(context).size.width / 360,
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
            value: currentFilter[category],
            onChanged: (newValue) {
              {
                setState(() {
                  filterChange = true;
                  currentFilter[category] = newValue;
                  PrefUtils.setFilterPref(tabFilterToList(currentFilter));
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged());
                });
              }
            })
        : Transform.scale(
            scale: 0.85,
            child: CupertinoSwitch(
                value: currentFilter[category],
                onChanged: (newValue) {
                  {
                    setState(() {
                      filterChange = true;
                      currentFilter[category] = newValue;
                      PrefUtils.setFilterPref(tabFilterToList(currentFilter));
                    });
                  }
                }),
          );
  }

  // Future<bool> _willPopHandler() {
  //   if (filterChange) {
  //     return showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text("Khởi động lại app ?"),
  //             content: Text("Lọc chuyên mục yêu cầu khởi động lại app"),
  //             actions: <Widget>[
  //               FlatButton(
  //                   child: Text('Không'),
  //                   onPressed: () {
  //                     setState(() {
  //                       for (var key in currentFilter.keys)
  //                         currentFilter[key] = currentFilter[key];
  //                       filterChange = false;
  //                       PrefUtils.setFilterPref(tabFilterToList(currentFilter));
  //                     });
  //                     Navigator.of(context).pop(false);
  //                   }),
  //               FlatButton(
  //                   child: Text('Có'),
  //                   onPressed: () {
  //                     Phoenix.rebirth(context);
  //                     Navigator.of(context).pop(true);
  //                   }),
  //             ],
  //           );
  //         });
  //   }
  //   Navigator.of(context).pop(true);
  // }

  TextEditingController apiController = new TextEditingController();

  Future<String> buildDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Nhập API key mới"),
            content: TextField(
              controller: apiController,
            ),
            actions: <Widget>[
              RaisedButton(
                elevation: 5,
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(apiController.text);
                },
              ),
            ],
          );
        });
  }
}
