import 'dart:ui';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_findar_v3/music_repo.dart';
import 'package:volume/volume.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> animation;
  AnimationController controller;
  String musicTitle;
  String backgroundImageUri;
  double toolbarIconSize = 25;
  List musicList = MusicRepo().musicList;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  int maxVol, currentVol;

  bool _isMusicPlaying = Home.isMusicPlaying;

  bool _increaseVolumeButtonPressed = false;
  bool _decreaseVolumeButtonPressed = false;
  bool _loopActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    // Make this call in initState() function in the root widgte of your app
    initPlatformState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  bool get _status {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(controller.status);
    if (Home.isMusicPlaying && controller.status == AnimationStatus.forward) {
      controller.fling(velocity: 2.0);
    } else if (Home.isMusicPlaying &&
        controller.status == AnimationStatus.dismissed) {
      controller.fling(velocity: 2.0);
    } else {
      controller.fling(velocity: -2.0);
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage((Home.currentMusic == null)
                  ? musicList[0].imageUri
                  : Home.currentMusic.imageUri),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        DecoratedBox(
            decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0x80000000), Color(0x30000000)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter),
        )),
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 130.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      (Home.currentMusic == null)
                          ? musicList[0].title
                          : Home.currentMusic.title,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 85.0,
                height: 85.0,
                child: RawMaterialButton(
                  onPressed: () {
                    Home.isMusicPlaying = !Home.isMusicPlaying;
                    if (Home.isMusicPlaying == true) {
                      setState(() {
                        HomeState().playSound();
                        _isMusicPlaying = true;
                      });
                    } else if (Home.isMusicPlaying == false) {
                      setState(() {
                        HomeState().pauseSound();
                        _isMusicPlaying = false;
                      });
                    }
//                      setState(() {
//                        Home.isMusicPlaying = !Home.isMusicPlaying;
//                        controller.fling(velocity: _status ? -2.0 : 2.0);
//                        if (Home.isMusicPlaying)
//                          HomeState().playSound();
//                        else
//                          HomeState().pauseSound();
//                      });
                  },
                  elevation: 20.0,
                  shape: CircleBorder(),
                  child: _isMusicPlaying
                      ? new Icon(
                          Icons.pause,
                          size: 55.0,
                        )
                      : new Icon(
                          Icons.play_arrow,
                          size: 55.0,
                        ),
//                    child: Container(
//                        width: 80.0,
//                        height: 80.0,
//                        child: Center(
//                            child: AnimatedIcon(
//                          icon: AnimatedIcons.play_pause,
//                          progress: controller.view,
//                          color: Colors.white,
//                          size: 50,
//                        ))),
                  fillColor: Colors.white54,
                ),
              ),
              Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Listener(
                        onPointerDown: (details) {
                          _increaseVolumeButtonPressed = true;
                          volumeButtonLongPress();
                          print("increase vol button long hold");
                        },
                        onPointerUp: (details) {
                          _increaseVolumeButtonPressed = false;
                          print("increase vol button long hold off");

                        },
                        child: RaisedButton(
                          color: Colors.white54,
                          child: Icon(
                            Icons.volume_up,
                            size: 35.0,
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            Volume.volUp();
                            updateVolumes();
                          },
                        ),
                      ),
                      Listener(
                        onPointerDown: (details) {
                          _decreaseVolumeButtonPressed = true;
                          volumeButtonLongPress();
                          print("decrease vol button long hold");

                        },
                        onPointerUp: (details) {
                          _decreaseVolumeButtonPressed = false;
                          print("decrease vol button long hold off");

                        },
                        child: RaisedButton(
                          color: Colors.white54,
                          child: Icon(
                            Icons.volume_down,
                            size: 35.0,
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            Volume.volDown();
                            updateVolumes();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;

  //Volume Controller Tools
  Future<void> initPlatformState() async {
    // pass any stream as parameter as per requirement
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes({int volume}) async {
    setVol(volume);
    // get Max Volume
    maxVol = await Volume.getMaxVol;
    // get Current Volume
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i);
  }

  void volumeButtonLongPress() async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_increaseVolumeButtonPressed) {
      // do your thing
      setState(() {
        Volume.volUp();
      });

      // wait a bit
      await Future.delayed(Duration(milliseconds: 200));
    }
    while (_decreaseVolumeButtonPressed) {
      // do your thing
      setState(() {
        Volume.volDown();
      });

      // wait a bit
      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
  }
}
