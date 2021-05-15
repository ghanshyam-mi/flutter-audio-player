import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../asset_audio_player_icons.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final bool isPlaylist;
  final Function() onPrevious;
  final Function() onPlay;
  final Function() onNext;
  final Function() toggleLoop;
  final Function() onStop;

  PlayingControls({
    @required this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    @required this.onPlay,
    this.onNext,
    this.onStop,
  });

  Widget _loopIcon(BuildContext context) {
    final iconSize = 34.0;
    if (loopMode == LoopMode.none) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.grey,
      );
    } else if (loopMode == LoopMode.playlist) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.black,
      );
    } else {
      //single
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.loop,
            size: iconSize,
            color: Colors.black,
          ),
          Center(
            child: Text(
              '1',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            if (toggleLoop != null) toggleLoop();
          },
          child: _loopIcon(context),
        ),
        SizedBox(
          width: 12,
        ),
        ClipOval(
          child: Material(
            color: Colors.grey.withOpacity(.4), // button color
            child: InkWell(
              child:SizedBox(width: 65, height: 65,child: Icon(AssetAudioPlayerIcons.to_start)),
              onTap: isPlaylist ? onPrevious : null,
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        SizedBox(
          height: 90,
          width: 90,
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple.shade400,
            onPressed: onPlay,
            child: Icon(
              isPlaying
                  ? AssetAudioPlayerIcons.pause
                  : AssetAudioPlayerIcons.play,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        ClipOval(
          child: Material(
            color: Colors.grey.withOpacity(.4), // button color
            child: InkWell(
              child:SizedBox(width: 65, height: 65,child: Icon(AssetAudioPlayerIcons.to_end)),
              onTap: isPlaylist ? onNext : null,
            ),
          ),
        ),
        SizedBox(
          width: 45,
        ),
        // if (onStop != null)
        //   NeumorphicButton(
        //     style: NeumorphicStyle(
        //       boxShape: NeumorphicBoxShape.circle(),
        //     ),
        //     padding: EdgeInsets.all(16),
        //     onPressed: onStop,
        //     child: Icon(
        //       AssetAudioPlayerIcons.stop,
        //       size: 32,
        //     ),
        //   ),
      ],
    );
  }
}
