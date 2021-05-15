import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_list/tabs/widget/common_list_widget.dart';

class UrlAudioListWidget extends StatefulWidget {
  final AssetsAudioPlayer assetsAudioPlayer;
  final List<Audio> audios;

  UrlAudioListWidget(this.assetsAudioPlayer, this.audios);

  @override
  _UrlAudioListWidgetState createState() => _UrlAudioListWidgetState();
}

class _UrlAudioListWidgetState extends State<UrlAudioListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonListWidget(
        audios: widget.audios,
        assetsAudioPlayer: widget.assetsAudioPlayer,
      ),
    );
  }
}
