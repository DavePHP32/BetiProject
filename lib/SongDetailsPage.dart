import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chanson.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SongDetailsPage(
        songId: '1',
        songTitle: 'Chanson 1',
        songInterprete: 'Interprète 1',
        songParoles: 'Paroles de la chanson 1...',
        songUrlAudio: 'URL de l\'audio de la chanson 1',
        songProduction: 'Nom de la production de la chanson 1', // Ajout de la valeur de production
      ),
    );
  }
}


class SongDetailsPage extends StatefulWidget {
  final String songId;
  final String songTitle;
  final String songInterprete;
  final String songParoles;
  final String songUrlAudio;
  final String songProduction; // Ajout de la variable songProduction

  SongDetailsPage({
    required this.songId,
    required this.songTitle,
    required this.songInterprete,
    required this.songParoles,
    required this.songUrlAudio,
    required this.songProduction,
  });


  @override
  _SongDetailsPageState createState() => _SongDetailsPageState();
}

class _SongDetailsPageState extends State<SongDetailsPage> {
  Chanson? _currentSong; // Déclarez la variable _currentSong
  List<Chanson> listeDesChansons = [];

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        if (mounted) {
          setState(() {
            _isPlaying = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isPlaying = false;
          });
        }
      }
    });
    fetchSongsFromFirebase();
  }

  Future<void> fetchSongsFromFirebase() async {
    List<Chanson> chansons = [];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('chansons').get();

      querySnapshot.docs.forEach((doc) {
        Chanson chanson = Chanson.fromDocumentSnapshot(doc);
        chansons.add(chanson);
      });

      setState(() {
        listeDesChansons = chansons;
        _currentSong = listeDesChansons.isNotEmpty ? listeDesChansons[0] : null;
      });
    } catch (error) {
      print("Erreur lors de la récupération des chansons : $error");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(widget.songUrlAudio);
    }
  }

  void _rewind() {
    _audioPlayer.seek(Duration(seconds: -10));
  }

  void _fastForward() {
    _audioPlayer.seek(Duration(seconds: 10));
  }

  void _goToPreviousSong() {
    int currentIndex = listeDesChansons.indexOf(_currentSong!);
    if (currentIndex > 0 && mounted) {
      setState(() {
        _currentSong = listeDesChansons[currentIndex - 1];
        _audioPlayer.stop();
        _isPlaying = false;
      });
    }
  }


  void _goToNextSong() {
    // Implémentez la logique pour passer au chant suivant
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.songTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.songParoles,
                style: TextStyle(fontSize: 30, color: Colors.black),

              ),
            ),

          ),
          AudioPlayerControls(
            isPlaying: _isPlaying,
            playPause: _playPause,
            rewind: _rewind,
            fastForward: _fastForward,
            goToPreviousSong: _goToPreviousSong,
            goToNextSong: _goToNextSong,
          ),
        ],
      ),
    );
  }
}

class AudioPlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback playPause;
  final VoidCallback rewind;
  final VoidCallback fastForward;
  final VoidCallback goToPreviousSong;
  final VoidCallback goToNextSong;

  AudioPlayerControls({
    required this.isPlaying,
    required this.playPause,
    required this.rewind,
    required this.fastForward,
    required this.goToPreviousSong,
    required this.goToNextSong,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: goToPreviousSong,
        ),
        IconButton(
          icon: Icon(Icons.replay_10),
          onPressed: rewind,
        ),
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: playPause,
        ),
        IconButton(
          icon: Icon(Icons.forward_10),
          onPressed: fastForward,
        ),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: goToNextSong,
        ),
      ],
    );
  }
}
