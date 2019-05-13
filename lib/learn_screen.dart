import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'assets/learn_screen.jpg',
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
                                builder: (context) => LearnOurTechnologies()));
                      },
                      leading: new Icon(Icons.bluetooth_audio),
                      title: new Text(
                        "Our Technologies",
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
                                builder: (context) => LearnRootedInProvenScience()));
                      },
                      leading: new Icon(Icons.school),
                      title: new Text(
                        "Rooted In Proven Science",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )),
                ),
                Card(
                  child: new ListTile(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LearnOurProfessionals()));
                      },
                      leading: new Icon(Icons.people),
                      title: new Text(
                        "Our Professionals",
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

class LearnOurTechnologies extends StatelessWidget {
  String _learnTechnologyDescription = '''Combining the latest advances in psychoacoustics and energy medicine, our brainwave synchronization technology - ‘Brain Enhance’ features the unique sound track, the unique audio equipment and the perfect combination of them. All of these have been carefully engineered and tested to show that they are capable of improving your mind, especially your sleeping, towards a better state.
  
1. Our sound tracks - Brain Wave Subliminals, are exclusively created by Dr. Mariarosa Greco PhD and Giancarlo Tarozzi, using their 20 years of research, expertise and experience in integrative medicine and eauroscience. These tracks are imbued with binaural and/or isochronic rhythms, imbedded with Delta waves as the first step and Theta and/or Epsilon waves as the second and deeper step, together with subliminal messages from Dr. Mariarosa Greco’s voice for even deeper and more effective subconscious re-programming to help you achieve the desired state with greater ease and efficiency. 

2. Our audio equipment - iSS: Equipment is specially developed by a group of talents in vibration and acoustics. It comes from our proprietary bending wave technology, similar to the principal of sound creation through musical instruments, reproduces sound in the purest way with a good grip on high frequencies, a clear midrange and fantastic sense of rhythm to enhance the listener’s perception to details in sound tracks as well as the therapeutic effect.

3. The perfect combination of software (iSS：APP) and hardware (iSS: Equipment) maximizes the therapeutic effect by brainwave synchronization, better than any phone APP that is designed just for a general use. All sound tracks in our APP have been crafted to align with the iSS: Equipment’s frequency response to ensure that messages, tones and beats can be regenerated with super high fidelity and can be perceived by your brain.

''';


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Our Technologies"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new Stack(
          children: <Widget>[
            Center(child: new Image.asset(
              'assets/learn_description.jpg',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),),
            new ListView(
              children: <Widget>[
                new ListTile(
                  subtitle: new Text(
                    _learnTechnologyDescription,
                    style: TextStyle(color: Colors.black, fontSize: 19.0),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
class LearnRootedInProvenScience extends StatelessWidget {
  String _learnRootedInProvenScienceDescription = '''1. Brainwaves and Synchronization
The root of all our thoughts, emotions and behaviors is the communication between neurons within our brains. Brainwaves are thus produced by synchronized electrical pulses from masses of neurons communicating with each other.  In other words, brainwaves are rhythmic or repetitive patterns of neural activity in the central nervous system. 
Extensive scientific research has revealed how all our mind states (relaxation, focus, anxiety, sleep, meditation...) correspond to specific brainwave patterns. Also, due to neuroplasticity (the brain's endless and amazing capacity to change, adapt, and reorganize itself) and tendency of our brains to synchronize with external stimuli, it is possible to use sound to influence your dominant brainwave frequency. This process is known as brainwave synchronization. Scientific research and clinic tests have proved its effectiveness. It works in a way that increases entropy to your brain in a very specific way, relating directly to neuroplasticity.  In this regard, as you listen to sounds with specific rhythms, your brain is being pushed by resonance to produce more alpha, theta, delta, and gamma brainwaves, and to form new neural pathways between the right and left hemispheres.  You can even think of this as exercise for your brain.  As you continue to give your brain this stimulus, it is eventually pushed, through the process of forming new neural pathways, to reorganize (or re-map) itself at a more optimal state. The result of this reorganization is experientially recognized as increased awareness of oneself and one’s subconscious, improved threshold to stress (resulting in emotional mastery), and an improvement in ability, mental function, emotional sensitivity, and creative achievement. For example, when you are very stressed or anxious, your brain will usually be producing an elevated amount of the higher beta brainwave activity. By stimulating your brain with lower alpha frequencies you can reduce the frequency of your dominant brainwave activity, helping to calm your mind and reduce the feeling of stress. 
Brainwave synchronization lets your brain calm down or speed up, depending on your needs. Let’s look at the various brainwave frequencies and states.
Delta () Waves 
0.5Hz-4Hz – Delta waves are very slow and low in frequency.  You produce the most delta activity during your deepest sleep.  It's during the productions of delta waves that your body does most of its healing and regenerating of cells.
Theta (θ) Waves
4Hz to 8Hz – Theta waves are also mainly dominant during sleep, or in a state of deep relaxation or when we are drifting in and out of sleep.
Alpha () Waves
8Hz to 12Hz – When in an alpha state we are usually very relaxed, calm and resting.  Increasing alpha waves can help us reduce stress and anxiety.  It's also a mental state where we can stimulate creativity, visualize and improve our ability to absorb and commit information to memory.
Beta () Waves
12Hz to 40Hz – Beta is faster and more dominant when we are consciously awake during the day.  We are in beta when we are focused, energized and alert.
Gamma () Waves
40Hz+ – Gamma is the fastest in the brainwave range.  It has been connected to mental states of high focus, cognitive enhancement and information processing.
Epsilon () waves
0.5Hz-  Epsilon is the super low frequency, a brainwave pattern even slower that delta. It is purposed to be an extraordinary state of consciousness.

2. Binaural - Monaural – Isochronic - Subliminal
Binaural beats were discovered in 1839 by a German experimenter, H. W. Dove, and first described by Oster in the early 70s. Binaural Beat use a frequency modulation technique, which means that the tone's carrier frequency is slightly modified for each ear, which results in the listener hearing a ‘perceived' beat at the frequency equal to the difference between the two tone frequencies.  To put that more simply, here's an example:
•	A tone of 200Hz is sent to the left ear
•	A tone of 210Hz is sent to the right ear
•	The difference between both frequencies is 10Hz, so the listener perceives a tone beating at a rate of 10 times per second, i.e. 10Hz.
Monaural beats result from the combination of two pure tones that produce a rhythmic beat. While binaural beats are considered an auditory illusion that elicits what might be described as a form of cognitive entrainment, monaural beats are considered an acoustic, purely physical phenomenon that directly affects the basilar membrane, where the sensory cells of hearing reside. Monaural beats aren’t headphones-dependent and have repeatedly shown strong cortical responses during EEG-based experiments.
Isochronic beats are sharp and regular pulses of sound created by a single tone being turned on and off at fast speed. The first study showing their effectiveness was published in 1981 by Arturo Manns. Contrary to binaural beats, isochronic tones don't need to be played back through headphones to preserve their effectiveness, which in that same study demonstrated a significant reduction in facial tension, insomnia, and muscular and emotional pain.
Subliminal messages are defined as signals below the absolute threshold level of our conscious awareness. These messages enter the mind stealthily, bypassing conscious resistance. Because your conscious mind is not aware of the subliminal messages, it cannot dispute, judge, or block them. Your mind relaxes into heightened receptivity, allowing positive messages to flow into your subconscious mind without the disruption of limiting beliefs. With repeated listening, your subconscious will accept the subliminal directives as true, and your behavior will reflect your new, positive belief system. Your retrained mind will attract and manifest in alignment with the messages received. What’s really fascinating is that our subconscious behavior is always on autopilot. Our subconsciousness is more powerful than consciousness when it comes to processing information: Subconsciousness is able to process 20,000 bits of information simultaneously, while consciousness can deal only with 7 ± 2 bits of information at the same time. 
''';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Rooted In Proven Science"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new Stack(
          children: <Widget>[
            Center(child: new Image.asset(
              'assets/learn_description2.jpg',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),),
            new ListView(
              children: <Widget>[
                new ListTile(
                  subtitle: new Text(
                    _learnRootedInProvenScienceDescription,
                    style: TextStyle(color: Colors.black, fontSize: 19.0),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class LearnOurProfessionals extends StatelessWidget {
  String _learnOurProfessionalsMariarosa = '''Dr. Mariarosa is a psychologist, psychotherapist and practitioner in integrative medicine, biofeedback and neurofeedback. After 15 years of her professional work in Italy, she continued her studies in US. and was awarded a PhD in integrative medicine. In 2015 she was invited as a keynote speaker in the World Congress of Integrative Medicine at Quantum University in Honolulu- Hawai’i.  Since 2009, she has created subliminal sounds and successfully applied for numerous clients. She uses to say “Nothing is impossible, as teach us the simply word Impossible that contain the meaning “Im-possible”, when we awake our consciousness and choice our Life! ''';
  String _learnOurProfessionalsGiancarlo = '''Mr. Giancarlo Tarozzi is a researcher and practitioner with years of experience in natural therapy, neuroplasticity of brain, brainwave sounds, and music of healing. He wrote many books about natural and holistic healing. He is also a director of two Italian Magazines: Jasmine and Olis (about natural healing, environmental).''';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Our Professionals"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new Stack(
          children: <Widget>[
            Center(child: new Image.asset(
              'assets/learn_description3.jpg',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),),
            new ListView(
              children: <Widget>[
                new ListTile(
                  title: new Image.asset('assets/mariarosa.png'),
                  subtitle: new Text(
                    _learnOurProfessionalsMariarosa,
                    style: TextStyle(color: Colors.black, fontSize: 19.0),
                  ),
                ),
                new ListTile(
                  title: new Image.asset('assets/giancarlo.png'),
                  subtitle: new Text(
                    _learnOurProfessionalsGiancarlo,
                    style: TextStyle(color: Colors.black, fontSize: 19.0),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

