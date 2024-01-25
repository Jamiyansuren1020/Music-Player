import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlayListProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playList = [
    Song(
        songName: "Sick World",
        artistName: "LiL Comp",
        albumImagePath: "assets/hip-hop-artist.png",
        audioPath: "assets/mp3-song.mp3"),

    Song(
        songName: "Billy Jeans",
        artistName: "Michael Jackson",
        albumImagePath: "assets/michael-jackson-artist.png",
        audioPath: "assets/mp3-song.mp3"),
    
    Song(
        songName: "The Rocky",
        artistName: "Rocker",
        albumImagePath: "assets/rock-artist.png",
        audioPath: "assets/mp3-song.mp3"),
    
  ];

  // A U D I O P L A Y E R

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //contructor
  PlayListProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  }

  //pause current song 
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async{
    if(isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song 
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if(_currentSongIndex != null) {
      if(_currentSongIndex! < _playList.length - 1) {
        //go to the next song if it is not the last song 
        currentSongIndex = _currentSongIndex! + 1;
      }else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async{
    //if more than 2 seconds have passed, restart the song
    if(_currentDuration.inSeconds > 2) {

    }
    // if it's within first 2 seconds of the song, play previous song
    else {
      if(_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      }else {
        // if it's the first song, loop back to last song
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  //listen to durations
  void listenToDuration () {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //dispose audio player

  //current song index
  int? _currentSongIndex;

  //Getter

  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration; 

  //Setter

  set currentSongIndex(int? newIndex) {

    //update current index
    _currentSongIndex = newIndex;

    if(newIndex != null) {
      play(); // play the song at the new index
    }

    //update UI
    notifyListeners();
  }
}
