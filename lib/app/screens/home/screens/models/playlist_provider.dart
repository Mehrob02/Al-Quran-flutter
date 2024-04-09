import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/models/surah.dart';

class PlaylistProvider extends ChangeNotifier {
  final List <Surah>  _playList = List<Surah>.generate(114, (index) => Surah(surahs[index], "Mishari bin Rashid Alafasy", "https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg"));
  //   Surah("Al-Fatiha", "Mishari bin Rashid Alafasy", "https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg"),
  //   Surah("Al-Baqarah", "Mishari bin Rashid Alafasy", "https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg"),
  //   Surah("Ali-Imran", "Mishari bin Rashid Alafasy", "https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg")
  // ];
  int? currenSurahIndex;

  final AudioPlayer _player= AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  PlaylistProvider(){
    listenToDuration();
  }
  bool  isPlaying=false;

  void play()async{
    final String path=currenSurahIndex!>=100? "https://server8.mp3quran.net/afs/${currentSurahIndex!+1}.mp3":currenSurahIndex!>=10?"https://server8.mp3quran.net/afs/0${currentSurahIndex!+1}.mp3":"https://server8.mp3quran.net/afs/00${currentSurahIndex!+1}.mp3";
  await _player.stop();
  await _player.play(UrlSource(path));
  isPlaying=true;
  notifyListeners();
  }
  void pause()async{
await _player.pause();
isPlaying=false;
notifyListeners();
  }
   void resume()async{
await _player.resume();
isPlaying=true;
notifyListeners();
  }
  void pORr()async{
    if (isPlaying){
       pause();
    }else{
       play();
  }
  notifyListeners();
  }
  void seek(Duration position)async{
await _player.seek(position);
  }
  void playNextSurah(){
    if(currenSurahIndex!=null){
      if(currenSurahIndex!<playList.length-1){
        currenSurahIndex=currenSurahIndex!+1;
      }else{
        currenSurahIndex=0;
      }

    }
  }
  void playPreviousSurah(){
    if(_duration.inSeconds>2){

    }else{
       if(currenSurahIndex!>0){
      if(currenSurahIndex !> playList.length-1){
        currenSurahIndex=currenSurahIndex!-1;
      }else{
        currenSurahIndex=playList.length-1;
      }
    }
    }
   
  }
   void listenToDuration(){
_player.onDurationChanged.listen((Duration duration){
      _totalDuration=duration;
      notifyListeners();
    });
   _player.onPositionChanged.listen((event) { 
    _duration=event;
    notifyListeners();
   }); 
   _player.onPlayerComplete.listen((event) {
    playNextSurah();
   });
   }

  List <Surah> get playList => _playList;
  int? get currentSurahIndex=>currenSurahIndex; 
  bool  get _isPlaying => isPlaying;
  Duration get totalDuration => _totalDuration;
  Duration get duration => _duration;


  set currentSurahIndex(int? newIndex){
    currentSurahIndex = newIndex;
    notifyListeners();
  }
}