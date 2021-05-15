import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_list/player/playing_controls.dart';
import 'package:flutter_audio_list/player/position_seek_widget.dart';

class PlayerWidget extends StatefulWidget {
  final List<Audio> audios;
  final AssetsAudioPlayer _assetsAudioPlayer;

  PlayerWidget(this.audios, this._assetsAudioPlayer);

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              widget._assetsAudioPlayer.builderCurrent(
                builder: (BuildContext context, Playing playing) {
                  final myAudio =
                      find(widget.audios, playing.audio.assetAudioPath);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // style: NeumorphicStyle(
                      //   depth: 8,
                      //   surfaceIntensity: 1,
                      //   shape: NeumorphicShape.concave,
                      //   boxShape: NeumorphicBoxShape.circle(),
                      // ),
                      child: myAudio.metas.image?.path == null
                          ? const SizedBox()
                          : myAudio.metas.image?.type == ImageType.network
                              ? Image.network(
                                  myAudio.metas.image.path,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                )
                              : Icon(Icons.audiotrack),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          widget._assetsAudioPlayer.builderCurrent(
              builder: (context, Playing playing) {
            return Column(
              children: <Widget>[
                widget._assetsAudioPlayer.builderLoopMode(
                  builder: (context, loopMode) {
                    return PlayerBuilder.isPlaying(
                        player: widget._assetsAudioPlayer,
                        builder: (context, isPlaying) {
                          return PlayingControls(
                            loopMode: loopMode,
                            isPlaying: isPlaying,
                            isPlaylist: true,
                            onStop: () {
                              // widget._assetsAudioPlayer.stop();
                              // setState(() {
                              // });
                            },
                            toggleLoop: () {
                              widget._assetsAudioPlayer.toggleLoop();
                            },
                            onPlay: () {
                              widget._assetsAudioPlayer.playOrPause();
                            },
                            onNext: () {
                              //_assetsAudioPlayer.forward(Duration(seconds: 10));
                              widget._assetsAudioPlayer.next(
                                  /*keepLoopMode: false*/);
                            },
                            onPrevious: () {
                              widget._assetsAudioPlayer.previous(
                                  /*keepLoopMode: false*/);
                            },
                          );
                        });
                  },
                ),
                widget._assetsAudioPlayer.builderRealtimePlayingInfos(
                    builder: (context, RealtimePlayingInfos infos) {
                  if (infos == null) {
                    return SizedBox();
                  }
                  //print('infos: $infos');
                  return Column(
                    children: [
                      PositionSeekWidget(
                        currentPosition: infos.currentPosition,
                        duration: infos.duration,
                        seekTo: (to) {
                          widget._assetsAudioPlayer.seek(to);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style:TextButton.styleFrom(backgroundColor: Colors.grey.withOpacity(0.3)),
                            onPressed: () {
                              widget._assetsAudioPlayer
                                  .seekBy(Duration(seconds: -10));
                            },
                            child: Text('-10',style: TextStyle(color: Colors.black),),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          TextButton(
                            style:TextButton.styleFrom(backgroundColor: Colors.grey.withOpacity(0.3)),
                            onPressed: () {
                              widget._assetsAudioPlayer
                                  .seekBy(Duration(seconds: 10));
                            },

                            child: Text('+10',style: TextStyle(color: Colors.black),),
                          ),
                        ],
                      )
                    ],
                  );
                }),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }
}
