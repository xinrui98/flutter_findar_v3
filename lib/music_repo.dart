import 'package:flutter_findar_v3/music.dart';

class MusicRepo {
  static String defaultText = "Default Text";
  List allMusic = [
    Music("Dreaming", "assets/dreaming.mp3", "assets/dreaming.jpg",defaultText),
    Music("Fountain Bubbling", "assets/fountain_bubbling.mp3","assets/fountain_bubbling1.jpg",defaultText),
    Music("Harmony", "assets/harmony.mp3", "assets/harmony.jpg", defaultText),
    Music("Gentle Lake", "assets/gentle_lake.mp3", "assets/gentle_lake.jpg",defaultText),
    Music("Ocean Waves", "assets/ocean_waves.mp3", "assets/ocean_waves.jpg",defaultText),
    Music("Tranquility", "assets/tranquility.mp3", "assets/tranquility.jpg",defaultText),
    Music("Clouds", "assets/clouds_in_the_sky.mp3", "assets/clouds.jpg",defaultText),
    Music("Force Of Nature", "assets/force_of_nature.mp3", "assets/force_of_nature.jpg",defaultText),
  ];

  List get musicList => allMusic;
}