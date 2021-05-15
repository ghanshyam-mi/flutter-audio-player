import 'package:flutter/material.dart';

import 'tabs/audio_list_tab_widget.dart';

class FlutterAudioListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AudioListTabsWidget(),
    );
  }
}
