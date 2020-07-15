import 'package:flutter/material.dart';
import 'package:trends/data/models/music.dart';

class MusicPlaying extends StatefulWidget {
  const MusicPlaying({
    Key key,
    this.music,
    this.playCallBack,
    this.isPlaying,
    this.nextCallBack,
    this.previousCallBack,
  }) : super(key: key);

  @override
  _MusicPlayingState createState() => _MusicPlayingState();
  final Music music;
  final bool isPlaying;
  final Function() playCallBack;
  final Function() nextCallBack;
  final Function() previousCallBack;
}

class _MusicPlayingState extends State<MusicPlaying>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double aspectWidth = screenWidth / 360;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.1, color: Colors.grey)),
        color: Theme.of(context).backgroundColor,
      ),
      height: 65 * aspectWidth,
      width: screenWidth,
      child: Row(
        children: <Widget>[
          SizedBox(width: 6 * aspectWidth),
          ClipRRect(
            borderRadius: BorderRadius.circular(300.0),
            child: Container(
              height: 50 * aspectWidth,
              width: 50 * aspectWidth,
              child: Align(
                alignment: Alignment.center,
                widthFactor: 0.4,
                heightFactor: 1.0,
                child: Image.network(widget.music.image),
              ),
            ),
          ),
          SizedBox(
            width: 10 * aspectWidth,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.music.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15 * screenWidth / 360,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  widget.music.singer,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15 * screenWidth / 360,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5 * aspectWidth,
          ),
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {
              if (widget.previousCallBack != null) {
                widget.previousCallBack();
              }
            },
          ),
          IconButton(
            icon: Icon(widget.isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (widget.playCallBack != null) {
                widget.playCallBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {
              if (widget.nextCallBack != null) {
                widget.nextCallBack();
              }
            },
          ),
        ],
      ),
    );
  }
}
