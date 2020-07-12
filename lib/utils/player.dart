import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

AudioPlayer speechPlayer = AudioPlayer(playerId: 'news');
AudioPlayer audioPlayer = AudioPlayer(playerId: 'music');
AudioPlayer audioPlayerSave = AudioPlayer(playerId: 'save');
Duration turnfOffTime = Duration(seconds: 0);
bool autoTurnMusicOff = false;
bool isRepeatOne = false;
int random;
int currentMusicIndex = 0;
bool isShuffle = false;

Timer timer;

void startTimer() {
  autoTurnMusicOff = true;
  timer = Timer.periodic(Duration(seconds: 1), _handleTimeOut);
}

void _handleTimeOut(timer) {
  try {
    if (turnfOffTime.inSeconds > 0)
      turnfOffTime = turnfOffTime - Duration(seconds: 1);
    else {
      audioPlayer.pause();
      autoTurnMusicOff = false;
      turnfOffTime = Duration(seconds: 0);
      timer.cancel();
    }
  } catch (e) {
    print(e.toString());
    autoTurnMusicOff = false;
      turnfOffTime = Duration(seconds: 0);
  }
}

void cancelTimer() {
  timer.cancel();
  autoTurnMusicOff = false;
  turnfOffTime = Duration(seconds: 0);
}
