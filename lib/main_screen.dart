import 'dart:ui';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_findar_v3/music_repo.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  Animation<double> animation;
  AnimationController controller;
  String musicTitle;
  String backgroundImageUri;
  double toolbarIconSize = 25;
  List musicList = MusicRepo().musicList;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var sliderValue = 0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(milliseconds: 0));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

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
      controller.fling(velocity:2.0);
    } else if (Home.isMusicPlaying && controller.status == AnimationStatus.dismissed){
      controller.fling(velocity: 2.0);
    } else {
      controller.fling(velocity:-2.0);
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
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
            DecoratedBox(decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0x80000000),
                Color(0x30000000)],
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
                          style: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 54,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            Home.isMusicPlaying = !Home.isMusicPlaying;
                            controller.fling(velocity: _status ? -2.0 : 2.0);
                            if (Home.isMusicPlaying) HomeState().playSound();
                            else HomeState().pauseSound();
                          });
                        },
                        elevation: 20.0,
                        shape: CircleBorder(),
                        child: Container(
                            width: 80.0,
                            height: 80.0,
                            child: Center(child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: controller.view,color: Colors.white,size: 50,))
                        ),
                        fillColor: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
