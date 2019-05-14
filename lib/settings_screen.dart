import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'assets/more_screen.jpg',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new Center(
            child: new ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Card(
                  child: new ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MoreUserGuidanceSoundTherapy()));
                      },
                      leading: new Icon(Icons.live_help),
                      title: new Text(
                        "User Guidance",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )),
                ),
                Card(
                  child: new ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreDisclaimer()));
                      },
                      leading: new Icon(Icons.warning),
                      title: new Text(
                        "Disclaimer",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )),
                ),
                Card(
                  child: new ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreAbout()));
                      },
                      leading: new Icon(Icons.info),
                      title: new Text(
                        "About",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MoreUserGuidanceSoundTherapy extends StatelessWidget {
  String _moreUserGuidanceSoundTherapyDescription =
      '''All sound tracks can be listened to alternatively, for example, from one to the other. The listening time per day is accumulated for at least 30 minutes or longer. Preferably, listen to them before going to sleep. 

If you miss a day or two, it doesn’t matter. However, in this case, it is better to add extra 2 days to the timetable. It is improtant to be as consistent as possible. You have to listen to at least once every day or once every other day for at least 21 days.

Sit down and lie down in a comfortable way to relax your body and mind, and choose a moment that you can have a quite environment during the day, free from distractions, such as noise from neighbors, snoring from your roommates etc. Make sure your mobile phone off or in a silent mode. 

Before playing, you have to turn your attention to the subject of listening, meaning that you have opened a door for these professional sounds with subliminal messages to enter your brain, allowing them to work for your health and wellness towards a better state. Be confident in the end result, not worry about whether you can hear subliminal messages. When you focus on the ultimate goal, your body and subconscious can be stimulated effectively. You can imagine the best result from this sound therapy program, which will give you the greatest confidence and chance of success. 

Start iSS: Equipment (the listening device), adjust the volume to a comfortable level and listen.  Be patient and consistent until the desirable result is achieved. Breathe deeply before and/or during listening, and allow your mind to receive “self-care” and enjoy listening to sound tracks with subliminal messages imbedded, towards a better state.

''';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("User Guidance"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new Stack(
          children: <Widget>[
            Center(
              child: new Image.asset(
                'assets/learn_description.jpg',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            new ListView(
              children: <Widget>[
                new ListTile(
                  subtitle: new Text(
                    _moreUserGuidanceSoundTherapyDescription,
                    style: TextStyle(color: Colors.black, fontSize: 19.0),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class MoreDisclaimer extends StatelessWidget {
  String _moreDisclaimer =
      '''This app consists of sound tracks, which are created by the professionals in integrative medicine and neuroscience. It is made for your sleep care. However, it is not a substitute for a doctor’s treatment in a hospital or clinic, but an option for improving your sleep. It is strongly recommended to use this app together with iSS: Equipment, rather than others.
''';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Disclaimer"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new Stack(
          children: <Widget>[
            Center(
              child: new Image.asset(
                'assets/learn_description2.jpg',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            new ListView(
              children: <Widget>[
                new ListTile(
                  subtitle: new Text(
                    _moreDisclaimer,
                    style: TextStyle(color: Colors.black, fontSize: 19.0),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class MoreAbout extends StatelessWidget {
  String _moreDisclaimer =
      '''Findar is committed to creating an innovative yet healthy way of listening for consumers. We are a high-tech company based in Singapore, engaged in research and development of breakthrough audio technologies and manufacturing of advanced electro-acoustic transducers and a series of innovation products for your entertainment, health and wellness.
''';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("About"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new Stack(
          children: <Widget>[
            Center(
              child: new Image.asset(
                'assets/learn_description3.jpg',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            new ListView(
              children: <Widget>[
                new ListTile(
                  subtitle: new Text(
                    _moreDisclaimer,
                    style: TextStyle(color: Colors.black, fontSize: 19.0),
                  ),
                ),
                new Center(
                  child: new RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'www.findar-tech.com',
                          style: new TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 35.0),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'http://findar-tech.com/index.html');
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

}
