import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_list/permission_helper.dart';
import 'package:flutter_audio_list/tabs/asset_audio_list_widget.dart';
import 'package:flutter_audio_list/tabs/device_audio_list_widget.dart';
import 'package:flutter_audio_list/tabs/url_audio_list_widget.dart';
import 'package:flutter_audio_list/tabs/widget/player_bottom_sheet.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class AudioListTabsWidget extends StatefulWidget {
  @override
  _AudioListTabsWidgetState createState() => _AudioListTabsWidgetState();
}

class _AudioListTabsWidgetState extends State<AudioListTabsWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId('music');
  final List<StreamSubscription> _subscriptions = [];
  List<Widget> list = [
    Tab(child: Text("Asset")),
    Tab(child: Text("Device")),
    Tab(child: Text("Url")),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: list.length, vsync: this);
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
      setState(() {});
      // openPlayer();
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
    _requestPermission();
    openPlayer();
  }

  /// This method will call to request permission.
  void _requestPermission() async {
    await PermissionHelper(
        isDenied: () {
          print("permission denied");
        },
        isGranted: () {
          print("permission granted");
          getFiles();
        },
        isRestricted: () {},
        isPermanentlyDenied: () {
          print("permission Permanently Denied");
        },
        isUndetermined: () {
          print("permission Undetermined");
        }).setStoragePermissionCallBack();
  }

  ///This method will setup player on initial time.
  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  final audios = <Audio>[
    Audio(
      'assets/rock.mp3',
      //playSpeed: 2.0,
      metas: Metas(
        id: 'Rock',
        title: 'Rock',
        artist: 'Florent Champigny',
        album: 'RockAlbum',
        image: MetasImage.network(
            'https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png'),
      ),
    ),
    Audio.network(
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio(
      'assets/2_country.mp3',
      metas: Metas(
        id: 'Country',
        title: 'Country',
        artist: 'Florent Champigny',
        album: 'CountryAlbum',
        image: MetasImage.asset('assets/images/country.jpg'),
      ),
    ),
    Audio(
      'assets/electronic.mp3',
      metas: Metas(
        id: 'Electronics',
        title: 'Electronic',
        artist: 'Florent Champigny',
        album: 'ElectronicAlbum',
        image: MetasImage.network(
            'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
      ),
    ),
    Audio(
      'assets/hiphop.mp3',
      metas: Metas(
        id: 'Hiphop',
        title: 'HipHop',
        artist: 'Florent Champigny',
        album: 'HipHopAlbum',
        image: MetasImage.network(
            'https://beyoudancestudio.ch/wp-content/uploads/2019/01/apprendre-danser.hiphop-1.jpg'),
      ),
    ),
    Audio(
      'assets/pop.mp3',
      metas: Metas(
        id: 'Pop',
        title: 'Pop',
        artist: 'Florent Champigny',
        album: 'PopAlbum',
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio(
      'assets/instrumental.mp3',
      metas: Metas(
        id: 'Instrumental',
        title: 'Instrumental',
        artist: 'Florent Champigny',
        album: 'InstrumentalAlbum',
        image: MetasImage.network(
            'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/12/attachment_68585523.jpg'),
      ),
    ),
  ];
  List<File> files;
  List<Audio> audioList = [];

  /// This method will give locally stored audios.
  void getFiles() async {
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir;
    var fm = FileManager(root: Directory(root)); //
    String dir = (await getExternalStorageDirectory()).path;
    files = await fm.filesTree(excludedPaths: [dir], extensions: ["mp3"]);
    files.forEach((element) {
      audioList.add(Audio.file(
        element.path,
        metas: Metas(
          id: 'Online',
          title: element.path.split('/').last,
          artist: 'NA',
          album: 'NA',
        ),
      ));
    });
    if (audioList.isNotEmpty) {
      audios.addAll(audioList);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF9999FF),
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          bottom: TabBar(
            controller: _controller,
            tabs: list,
          ),
          title: Text('Audio List'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            AssetAudioListWidget(
                _assetsAudioPlayer,
                audios
                    .where((element) => element.audioType == AudioType.asset)
                    .toList()),
            DeviceAudioListWidget(
                _assetsAudioPlayer,
                audios
                    .where((element) => element.audioType == AudioType.file)
                    .toList()),
            UrlAudioListWidget(
                _assetsAudioPlayer,
                audios
                    .where((element) => element.audioType == AudioType.network)
                    .toList())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_library_music_sharp),
          onPressed: () {
            PlayerBottomSheet(
                    context: context,
                    audios: audios,
                    assetsAudioPlayer: _assetsAudioPlayer)
                .modalBottomSheetMenu();
          },
        ),
      ),
    );
  }
}
