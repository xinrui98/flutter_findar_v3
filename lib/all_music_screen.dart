import 'package:flutter/material.dart';
import 'package:flutter_findar_v3/main.dart';
import 'dart:ui';

import 'package:flutter_findar_v3/music_repo.dart';
class AllMusicScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllMusicScreenState();
  }
}

class AllMusicScreenState extends State<AllMusicScreen> with SingleTickerProviderStateMixin{
  List musicList = MusicRepo().musicList;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,
        duration: Duration(seconds: 1));
    this.animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var itemHeight = (size.height - 24) /2.7;
    var itemWidth = size.width/2;
    controller.forward();
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
            filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
            child: DecoratedBox(decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0x50000000),
                Color(0xA0000000)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight),
            )),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                Stack(
                    children: <Widget> [Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Music Therapy", style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w200),),
                      ],
                    ),
                    ]
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                    child: GridView.count(crossAxisCount: 2,
                      childAspectRatio: itemWidth/itemHeight,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      children: List.generate(musicList.length, (index) {
                        return Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
                              child: Stack(
                                  children: <Widget> [Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0)
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 4,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200.withOpacity(0.3),
                                            image: DecorationImage(
                                              image: AssetImage(musicList[index].imageUri),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        DecoratedBox(decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [Color(0x00000000),
                                            Color(0x50000000)],
                                              begin: FractionalOffset.topCenter,
                                              end: FractionalOffset.bottomCenter),
                                        )
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [Color(0xA0000000),
                                                Color(0xA0000000)],
                                                  begin: FractionalOffset.topCenter,
                                                  end: FractionalOffset.bottomCenter),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Container(
                                                            child: Text(musicList[index].title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              Home.currentMusic = musicList[index];
                                              HomeState().stopSound();
                                              HomeState().playSound();
                                              Home.isMusicPlaying = true;
                                            });
                                          },
                                        ),
                                        color: Colors.transparent,
                                        type: MaterialType.card,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    )
                                  ]
                              ),
                            )
                        );
                      },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 58,)
              ],
            ),
          )
        ],
      ),
    );
  }
}