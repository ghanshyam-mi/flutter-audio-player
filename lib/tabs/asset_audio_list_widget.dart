import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_list/tabs/widget/common_list_widget.dart';

class AssetAudioListWidget extends StatefulWidget {
  final AssetsAudioPlayer assetsAudioPlayer;
  final List<Audio> audios;

  AssetAudioListWidget(this.assetsAudioPlayer, this.audios);

  @override
  _AssetAudioListWidgetState createState() => _AssetAudioListWidgetState();
}

class _AssetAudioListWidgetState extends State<AssetAudioListWidget> {
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
