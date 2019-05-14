import 'package:flutter_findar_v3/music.dart';

class MusicRepo {
  static String defaultText = "Default Text";
  List allMusic = [
    Music("Dreaming", "assets/l2_3.mp3", "assets/dreaming.jpg",defaultText),
    Music("Fountain Bubbling", "assets/l1_1.mp3","assets/fountain_bubbling.jpg",defaultText),
    Music("Harmony", "assets/l2_1.mp3", "assets/harmony1.jpg", defaultText),
    Music("Gentle Lake", "assets/l1_2.mp3", "assets/gentle_lake.jpg",defaultText),
    Music("Ocean Waves", "assets/l1_3.mp3", "assets/ocean_waves.jpg",defaultText),
    Music("Tranquility", "assets/l2_2.mp3", "assets/tranquility.jpg",defaultText),
  ];

  List get musicList => allMusic;
}