import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/data/models/music.dart';

class QualityChoice extends StatefulWidget {
  const QualityChoice({
    Key key,
    this.music,
    this.initValue,
    this.onChangedValue,
  }) : super(key: key);

  @override
  _QualityChoiceState createState() => _QualityChoiceState();
  final Music music;
  final initValue;
  final Function(String value) onChangedValue;
}

class _QualityChoiceState extends State<QualityChoice> {
  String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initValue;
  }

  void onChangedValue(String value) {
    setState(() {
      _value = value;
    });
    widget.onChangedValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
            Text(
              widget.music.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              widget.music.composer,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white30,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
          ] +
          widget.music.qualities
              .map(
                (String quality) => Radio(
                  value: quality,
                  groupValue: _value,
                  onChanged: onChangedValue,
                ),
              )
              .toList(),
    );
  }
}
