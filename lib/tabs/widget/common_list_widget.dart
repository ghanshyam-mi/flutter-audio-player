import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_list/player/songs_selector.dart';

class CommonListWidget extends StatefulWidget {
  final List<Audio> audios;
  final AssetsAudioPlayer assetsAudioPlayer;

  CommonListWidget({this.audios, this.assetsAudioPlayer});

  @override
  _CommonListWidgetState createState() =>
      _CommonListWidgetState(assetsAudioPlayer);
}

class _CommonListWidgetState extends State<CommonListWidget> {
  AssetsAudioPlayer _assetsAudioPlayer;

  _CommonListWidgetState(this._assetsAudioPlayer);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _assetsAudioPlayer.builderCurrent(
                  builder: (BuildContext context, Playing playing) {
                return SongsSelector(
                  audios: widget.audios,
                  onPlaylistSelected: (myAudios) {
                    _assetsAudioPlayer.open(
                      Playlist(audios: myAudios),
                      showNotification: true,
                      headPhoneStrategy:
                          HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                      audioFocusStrategy: AudioFocusStrategy.request(
                          resumeAfterInterruption: true,
                      ),
                    );
                  },
                  onSelected: (myAudio) async {
                    try {
                        await _assetsAudioPlayer.open(
                          myAudio,
                          autoStart: true,
                          showNotification: true,
                          playInBackground: PlayInBackground.enabled,
                          audioFocusStrategy: AudioFocusStrategy.request(
                              resumeAfterInterruption: true,
                              resumeOthersPlayersAfterDone: true),
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          notificationSettings: NotificationSettings(),
                        );
                    } catch (e) {
                      print(e);
                    }
                  },
                  playing: playing,
                );
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
