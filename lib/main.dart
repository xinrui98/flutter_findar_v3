import 'package:flutter/material.dart';
import 'package:flutter_findar_v3/all_music_screen.dart';
import 'package:flutter_findar_v3/learn_screen.dart';
import 'package:flutter_findar_v3/main_screen.dart';
import 'package:flutter_findar_v3/music.dart';
import 'package:flutter_findar_v3/music_repo.dart';
import 'package:flutter_findar_v3/settings_screen.dart';
import 'package:flutter_findar_v3/sound_manager.dart';
import 'dart:io';
import 'package:flutter_findar_v3/timer_screen.dart';

void main() => runApp(Home());
ThemeData _baseTheme = ThemeData(
  fontFamily: "Roboto",
  canvasColor: Colors.transparent,
);

class Home extends StatefulWidget {
  static bool isMusicPlaying = false;
  static Music currentMusic;

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  AnimationController controller;
  Animation<double> animation;
  SoundManager soundManager = SoundManager();
  static bool isTimerRunning = false;
  String timeLeftOnTimer;
  MainScreen mainScreen;
  TimerScreen timerScreen;
  AllMusicScreen allMusicScreen;
  LearnScreen learnScreen;
  SettingsScreen settingsScreen;
  List pages;
  final PageStorageBucket bucket = PageStorageBucket();

  void playSound() {
    soundManager.playLocal((Home.currentMusic != null)
        ? Home.currentMusic.musicUri.substring(7)
        : MusicRepo().musicList[0].musicUri.substring(7));
  }

  void pauseSound() {
    soundManager.pause();
  }

  void stopSound() {
    soundManager.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    this.animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    mainScreen = MainScreen();
    timerScreen = TimerScreen();
    allMusicScreen = AllMusicScreen();
    learnScreen = LearnScreen();
    settingsScreen = SettingsScreen();
    pages = [
      mainScreen,
      timerScreen,
      allMusicScreen,
      learnScreen,
      settingsScreen
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return MaterialApp(
      theme: _baseTheme,
      debugShowCheckedModeBanner: false,
      home: (Platform.isIOS)
          ? SafeArea(
        child: Scaffold(
          body: Stack(children: <Widget>[
            PageStorage(bucket: bucket, child: pages[selectedIndex]),
          ]),
        ),
      )
          : Scaffold(
        body: Stack(children: <Widget>[
          pages[selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Colors.transparent,
                  primaryColor: Colors.red,
                  textTheme: Theme.of(context).textTheme.copyWith(
                      caption: TextStyle(color: Colors.white70))),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("Home")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.timer), title: Text("Timer")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.music_note), title: Text("Sounds")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard), title: Text("Learn")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.info), title: Text("More"))
                ],
                currentIndex: selectedIndex,
                fixedColor: Colors.white,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
