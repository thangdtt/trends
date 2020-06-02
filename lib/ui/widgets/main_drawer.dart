import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            "Drawer testing",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white70),
          ),
        ),
        SizedBox(height: 20),
        buildListTile("Saved", Icons.bookmark, (){
          Navigator.of(context).pushReplacementNamed('/');
        },),
        buildListTile("Filter", Icons.settings, () {
          //Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
        }),
      ]),
    );
  }
}
