import 'dart:async';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_findar_v3/main.dart';
import 'package:flutter_findar_v3/music_repo.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:media_notification/media_notification.dart';

class TimerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimerScreenState();
  }
}
//add WigetsBindingObserver to TimerScreenState;
//initstate
//dispose
//didChangeAppLifecycleState

class TimerScreenState extends State<TimerScreen>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver {
  List musicList = MusicRepo().musicList;
  AnimationController controller;
  bool isAnimating = false;

//  static var hours = 0;
  static var minutes = 0;
  bool startedTimer = false;
  bool initalizedTimer = true;
  Duration duration;
  String status = 'hidden';
  bool isTimerButtonPlaying;

  var timerPauseInBackground;

  int getCurrentMusicPosition() {
    for (int i = 0; i < musicList.length; i++) {
      if (Home.currentMusic != null) {
        if (Home.currentMusic.title == musicList[i].title) {
          return i;
        }
      } else {
        return 0;
      }
    }
  }

  String get timerString {
    duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    //to run activity in background
    WidgetsBinding.instance.addObserver(this);

    duration = Duration(minutes: minutes);
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    isAnimating = controller.isAnimating;
    controller.addListener(() {
      if (controller.status == AnimationStatus.dismissed) {
        setState(() {
          isAnimating = false;
          //hides music control notification bar after opening app
//          hideMusicNotificationBar();
          //toggles to PLAY button, when timer and sound is paused
          togglePlayPauseNotificationBar(
              "Findar SleepCare",
              (Home.currentMusic == null)
                  ? musicList[0].title
                  : Home.currentMusic.title);
        });
        HomeState().pauseSound();
        Home.isMusicPlaying = false;
      }
//      else{
//        showMusicNotificationBar("Findar SleepCare",
//            (Home.currentMusic == null)
//                ? musicList[0].title
//                : Home.currentMusic.title);
//      }
    });

    MediaNotification.setListener('pause', () {
      setState(() {
        status = 'pause';
        HomeState().pauseSound();
        Home.isMusicPlaying = false;

//        if (controller.isAnimating) {
//          controller.stop();
//          setState(() {
//            isAnimating = false;
//            HomeState.isTimerRunning = false;
//            HomeState().pauseSound();
//            Home.isMusicPlaying = false;
//          });
//        }
      });
    });

    MediaNotification.setListener('play', () {
      setState(() {
        status = 'play';
        HomeState().playSound();
        Home.isMusicPlaying = true;
//        if(!controller.isAnimating) {
//          controller.reverse(
//              from: controller.value == 0.0
//                  ? 1.0
//                  : controller.value);
//          isAnimating = true;
//        }
      });
    });

    MediaNotification.setListener('next', () {
      setState(() {
        status = 'next';
        if (getCurrentMusicPosition() < musicList.length - 1) {
          Home.currentMusic = musicList[getCurrentMusicPosition() + 1];
        } else {
          Home.currentMusic = musicList[0];
        }
        HomeState().stopSound();
        HomeState().playSound();
        Home.isMusicPlaying = true;
        showMusicNotificationBar(
            "Findar SleepCare",
            (Home.currentMusic == null)
                ? musicList[0].title
                : Home.currentMusic.title);
      });
    });

    MediaNotification.setListener('prev', () {
      setState(() {
        status = 'prev';
        if (getCurrentMusicPosition() > 0) {
          Home.currentMusic = musicList[getCurrentMusicPosition() - 1];
        } else {
          Home.currentMusic = musicList[musicList.length - 1];
        }
        HomeState().stopSound();
        HomeState().playSound();
        Home.isMusicPlaying = true;
        showMusicNotificationBar(
            "Findar SleepCare",
            (Home.currentMusic == null)
                ? musicList[0].title
                : Home.currentMusic.title);
      });
    });

    MediaNotification.setListener('select', () {});
  }

  Future<void> hideMusicNotificationBar() async {
    try {
      await MediaNotification.hide();
      setState(() => status = 'hidden');
    } on PlatformException {}
  }

  Future<void> showMusicNotificationBar(title, author) async {
    try {
      await MediaNotification.show(title: title, author: author);
      setState(() => status = 'play');
    } on PlatformException {}
  }

  Future<void> togglePlayPauseNotificationBar(title, author) async {
    try {
      await MediaNotification.togglePlayPauseButton(
          title: title, author: author);
      setState(() => status = 'toggling');
    } on PlatformException {}
  }

  displayScreen(bool isTimerRunning) {
    if (startedTimer)
      return timerScreen();
    else
      return timerSelectionScreen();
  }

  @override
  void dispose() {
    //to run activity in background
    WidgetsBinding.instance.removeObserver(this);

    controller.dispose();
    HomeState.isTimerRunning = false;
    super.dispose();
  }

  //hard code way of ending sound in the background
  //replace with pauseSoundInBackgroundUsingTimer(Duration timeLeft)
//  Future pauseSoundInBackground(Duration timeLeft) async{
//    print("in pauseSoundInBackground function");
//    print("time left = $timeLeft");
//    await new Future.delayed(new Duration(seconds: timeLeft.inSeconds), (){
//      HomeState().pauseSound();
//      Home.isMusicPlaying = false;
//    });
//  }

  pauseSoundInBackgroundUsingTimer(Duration timeLeft) {
    return Timer(Duration(seconds: timeLeft.inSeconds), () {
      HomeState().pauseSound();
      Home.isMusicPlaying = false;
      //toggles to PLAY button, when timer and sound is paused
      togglePlayPauseNotificationBar(
          "Findar SleepCare",
          (Home.currentMusic == null)
              ? musicList[0].title
              : Home.currentMusic.title);
    });
    // and later, before the timer goes off...
//    t.cancel();
  }

  //not used. to hide notification bar using future delay way
  Future hideNotificationBarInBackground(int secondsLeft) async {
    print("in hideNotificationBarInBackground function");
    print("time left to hide notification bar = $secondsLeft");
    await new Future.delayed(new Duration(seconds: secondsLeft), () {
      hideMusicNotificationBar();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print("paused state");
        timerPauseInBackground = pauseSoundInBackgroundUsingTimer(duration);
        break;
      case AppLifecycleState.resumed:
        print("resumed");
        timerPauseInBackground.cancel();
        //show playing noti bar after coming back to app from paused state
        if (isTimerButtonPlaying == true) {
          showMusicNotificationBar(
              "Findar SleepCare",
              (Home.currentMusic == null)
                  ? musicList[0].title
                  : Home.currentMusic.title);
        }
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.suspending:
        print("suspending");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    updateKeepAlive();
    print(minutes);
    super.build(context);
    return displayScreen(HomeState.isTimerRunning);
  }

  timerScreen() {
    if (initalizedTimer) controller.value = 1.0;
    initalizedTimer = false;
    setState(() {
      if (controller.isAnimating) {
        controller.reverse();
        isAnimating = true;
        Home.isMusicPlaying = true;
        HomeState().playSound();
      }
    });
    return Container(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
              image: DecorationImage(
                image: AssetImage((Home.currentMusic == null)
                    ? musicList[0].imageUri
                    : Home.currentMusic.imageUri),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: DecoratedBox(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x50000000), Color(0xA0000000)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (Home.currentMusic != null)
                        ? Home.currentMusic.title
                        : musicList[0].title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return CustomPaint(
                                    painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.white,
                                  color: Colors.greenAccent,
                                ));
                              },
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Time Left",
                                  style: TextStyle(color: Colors.white),
                                ),
                                AnimatedBuilder(
                                    animation: controller,
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Text(
                                        timerString,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 100,
                                            fontWeight: FontWeight.w100),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //prev sound
                      RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            if (getCurrentMusicPosition() > 0) {
                              Home.currentMusic =
                              musicList[getCurrentMusicPosition() - 1];
                            } else {
                              Home.currentMusic = musicList[musicList.length - 1];
                            }
                            HomeState().stopSound();
                            HomeState().playSound();
                            Home.isMusicPlaying = true;
                            showMusicNotificationBar(
                                "Findar SleepCare",
                                (Home.currentMusic == null)
                                    ? musicList[0].title
                                    : Home.currentMusic.title);
                          });
                        },
                        elevation: 20.0,
                        shape: CircleBorder(),
                        child: new Icon(
                          Icons.skip_previous,
                          size: 40.0,
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
                      FloatingActionButton(
                        backgroundColor: Colors.green,
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return Icon(
                              isAnimating ? Icons.pause : Icons.play_arrow,
                            );
                          },
                        ),
                        onPressed: () {
                          print(controller.isAnimating);
                          if (controller.isAnimating) {
                            controller.stop();
                            isTimerButtonPlaying = false;
                            setState(() {
                              //hide music control notification bar when paused timer
//                              hideMusicNotificationBar();
                              //toggles to PLAY button, when sound is paused
                              togglePlayPauseNotificationBar(
                                  "Findar SleepCare",
                                  (Home.currentMusic == null)
                                      ? musicList[0].title
                                      : Home.currentMusic.title);
                              isAnimating = false;
                              HomeState.isTimerRunning = false;
                              HomeState().pauseSound();
                              Home.isMusicPlaying = false;
                            });
                          } else {
                            controller.reverse(
                                from: controller.value == 0.0
                                    ? 1.0
                                    : controller.value);
                            isTimerButtonPlaying = true;
                            setState(() {
                              //for music controller noti bar
                              showMusicNotificationBar(
                                  "Findar SleepCare",
                                  (Home.currentMusic == null)
                                      ? musicList[0].title
                                      : Home.currentMusic.title);
                              isAnimating = true;
                              Home.isMusicPlaying = true;
                              HomeState().playSound();
                            });
                          }
                        },
                      ),
                      //next sound
                      RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            if (getCurrentMusicPosition() < musicList.length - 1) {
                              Home.currentMusic =
                              musicList[getCurrentMusicPosition() + 1];
                            } else {
                              Home.currentMusic = musicList[0];
                            }
                            HomeState().stopSound();
                            HomeState().playSound();
                            Home.isMusicPlaying = true;
                            showMusicNotificationBar(
                                "Findar SleepCare",
                                (Home.currentMusic == null)
                                    ? musicList[0].title
                                    : Home.currentMusic.title);
                          });
                        },
                        elevation: 20.0,
                        shape: CircleBorder(),
                        child: new Icon(
                          Icons.skip_next,
                          size: 40.0,
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 56,
                )
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 16,
            child: IconButton(
              icon: Icon(
                Icons.warning,
                color: Colors.white,
              ),
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text("Leaving this page will turn off the timer"),
                  action: SnackBarAction(label: "OK", onPressed: () {}),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
            ),
          )
        ],
      ),
    );
  }

  timerSelectionScreen() {
    return Container(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
              image: DecorationImage(
                image: AssetImage((Home.currentMusic == null)
                    ? musicList[0].imageUri
                    : Home.currentMusic.imageUri),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: DecoratedBox(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x50000000), Color(0xA0000000)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight),
            )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DurationPicker(
                onChange: (val) {
                  setState(() {
                    duration = val;
//                    hours = duration.inHours;
                    minutes = duration.inMinutes;
                  });
                },
                duration: duration,
                snapToMins: 1.0,
                width: 400,
                height: 400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.arrow_forward),
                    backgroundColor: Colors.green,
                    onPressed: () {
                      //show select time snackbar when user did not select a time
                      if (duration.inSeconds == 0) {
                        final snackBar = SnackBar(
                          content: Text("Please select a time"),
                          action: SnackBarAction(label: "OK", onPressed: () {}),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                      else if (duration.inSeconds != 0) {
                        //show do not leave timer screen warning snackbar
                        final snackBar = SnackBar(
                          content:
                              Text("Leaving this page will turn off the timer"),
                          action: SnackBarAction(label: "OK", onPressed: () {}),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);

                        setState(() {
                          startedTimer = true;
                          initalizedTimer = true;
//                          hours = duration.inHours;
                          minutes = duration.inMinutes;
                          controller.duration = Duration(minutes: minutes);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 54,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
