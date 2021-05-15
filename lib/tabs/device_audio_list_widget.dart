import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_list/tabs/widget/common_list_widget.dart';

class DeviceAudioListWidget extends StatefulWidget {
  final AssetsAudioPlayer assetsAudioPlayer;
  final List<Audio> audios;

  DeviceAudioListWidget(this.assetsAudioPlayer, this.audios);

  @override
  _DeviceAudioListWidgetState createState() => _DeviceAudioListWidgetState();
}

class _DeviceAudioListWidgetState extends State<DeviceAudioListWidget> {
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
