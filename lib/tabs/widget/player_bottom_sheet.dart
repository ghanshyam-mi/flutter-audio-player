import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_list/tabs/widget/player_widget.dart';

class PlayerBottomSheet {
  BuildContext context;
  final List<Audio> audios;
  final AssetsAudioPlayer assetsAudioPlayer;

  PlayerBottomSheet({this.context, this.audios, this.assetsAudioPlayer});

  void modalBottomSheetMenu() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (builder) {
          return PlayerWidget(audios, assetsAudioPlayer);
        });
  }
}
