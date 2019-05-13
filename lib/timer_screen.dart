import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_findar_v3/main.dart';
import 'package:flutter_findar_v3/music_repo.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

class TimerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimerScreenState();
  }
}

class TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List musicList = MusicRepo().musicList;
  AnimationController controller;
  bool isAnimating = false;
  static var hours = 0;
  static var minutes = 0;
  bool startedTimer = false;
  bool initalizedTimer = true;
  Duration duration;

  String get timerString {
    duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    duration = Duration(hours: hours, minutes: minutes);
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    isAnimating = controller.isAnimating;
    controller.addListener(() {
      if (controller.status == AnimationStatus.dismissed) {
        setState(() {
          isAnimating = false;
        });
        HomeState().pauseSound();
      }
    });
  }

  displayScreen(bool isTimerRunning) {
    if (startedTimer)
      return timerScreen();
    else
      return timerSelectionScreen();
  }

  @override
  void dispose() {
    controller.dispose();
    HomeState.isTimerRunning = false;
    super.dispose();
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
                            setState(() {
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
                            setState(() {
                              isAnimating = true;
                              Home.isMusicPlaying = true;
                              HomeState().playSound();
                            });
                          }
                        },
                      )
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
              icon: Icon(Icons.help_outline,color: Colors.white,),
              onPressed: () {
                final snackBar = SnackBar(content: Text("Leaving this page will turn off the timer"),
                  action: SnackBarAction(label: "OK", onPressed: () {}),);
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
                    hours = duration.inHours;
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
                      if (duration.inSeconds != 0) {
                        setState(() {
                          startedTimer = true;
                          initalizedTimer = true;
                          hours = duration.inHours;
                          minutes = duration.inMinutes;
                          controller.duration =
                              Duration(hours: hours, minutes: minutes);
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
