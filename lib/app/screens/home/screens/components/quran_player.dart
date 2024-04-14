// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:itube/app/screens/home/screens/Settings.dart';
import 'package:itube/app/screens/home/screens/components/neu_box.dart';
import 'package:itube/app/screens/home/screens/components/shadow_box.dart';
import 'package:itube/quran_provider/models/surahs.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/playlist_provider.dart';

class QuranPlayer extends StatefulWidget {
  const QuranPlayer({super.key, required this.index});
  final int index;
  @override
  State<QuranPlayer> createState() => _QuranPlayerState();
}

class _QuranPlayerState extends State<QuranPlayer> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isPaused = true;
  bool _isLoopEnabled = false;
  bool _isRandomLoopEnabled = false;
  bool _isMenuOpened = false;
  bool _isAnimationCompleated=false;
  bool _floatingPlayer = false;
  bool _isSurahListOpened  = false;
  int currentIndex = 0;
  ScrollController scrollController = ScrollController();
  AudioPlayer _player = AudioPlayer();
  Duration? _currentDuration;
  Duration? _position;
  late final dynamic playlistProvider;
  void previous() {
    setState(() {
      currentIndex--;
      playSurah(currentIndex);
      _isPaused=true;
    });
  }

  void next() {
    setState(() {
      currentIndex++;
      playSurah(currentIndex);
      _isPaused=true;
    });
  }
  void playSurahByIndex(int index){
    setState(() {
      currentIndex = index;
    });
    playSurah(currentIndex);
     _isPaused=true;
  }

  void playSurah(int index) {
    if (index < 10) {
      _player.play(
          UrlSource("https://server8.mp3quran.net/afs/00${index + 1}.mp3"));
    } else if (index < 100) {
      _player.play(
          UrlSource("https://server8.mp3quran.net/afs/0${index + 1}.mp3"));
    } else {
      _player
          .play(UrlSource("https://server8.mp3quran.net/afs/${index + 1}.mp3"));
    }
    setState(() {
      _isMenuOpened = false;
    });
  }

  @override
  void initState() {
    currentIndex = widget.index;
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    _player = AudioPlayer();
    playSurah(currentIndex);
    _player.onPlayerComplete.listen((event) {
      
      if (_isLoopEnabled) {
        _isPaused = true;
        playSurah(currentIndex);
      } else if (_isRandomLoopEnabled) {
        setState(() {
          currentIndex = Random().nextInt(113) + 1;
          _isPaused = true;
        });
        playSurah(currentIndex);
      }else{
         if (currentIndex != 113) {
           next();
            }else{
_currentDuration=Duration.zero;
setState(() {
        _isPaused = false;
      });
        }
        
      }
    });
    _player.onPositionChanged.listen((event) async {
      _currentDuration = await _player.getCurrentPosition();
      _position = await _player.getDuration();
      setState(() {});
    });
//_player.setVolume(0.5);
    super.initState();
  }

void showFloatingPlayer(BuildContext context) {
  }

 void showSurahList(BuildContext context){
    setState(() {
     _isMenuOpened=false;  
     _isSurahListOpened=true;
    });
   }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ChangeNotifierProvider(
      create: (_) => PlaylistProvider(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Stack(children: [
            Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: NeuBox(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_new))),
                    ),
                    Text("Q U R' A N   P L A Y L E R"),
                    SizedBox(
                      height: 60,
                      width: 60,
                    ),
                  ],
                ),
                SizedBox(height: 25),
                SizedBox(
                    child: NeuBox(
                        child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                            height: 280,
                            child: Image.network(
                              "https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg",
                              fit: BoxFit.cover,
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mishari bin Rashid Alafasy",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey.shade500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                surahs[currentIndex],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              )
                            ],
                          ),
                          Icon(
                            Icons.star,
                            size: 25,
                            color: Colors.red.shade700,
                          )
                        ],
                      ),
                    )
                  ],
                ))),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((_currentDuration ??
                            Duration(
                                hours: 0,
                                minutes: 0,
                                seconds: 0,
                                milliseconds: 0))
                        .toString()
                        .substring(0, 7)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isMenuOpened = false;
                        });
                        setState(() {
                          _isRandomLoopEnabled = !_isRandomLoopEnabled;
                          _isLoopEnabled = false;
                        });
                      },
                      icon: _isRandomLoopEnabled
                          ? Icon(Icons.shuffle)
                          : Icon(
                              Icons.shuffle,
                              color: Colors.grey.shade400,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isLoopEnabled = !_isLoopEnabled;
                          _isRandomLoopEnabled = false;
                        });
                        setState(() {
                          _isMenuOpened = false;
                        });
                      },
                      icon: _isLoopEnabled
                          ? Icon(Icons.repeat_one)
                          : Icon(
                              Icons.repeat_one,
                              color: Colors.grey.shade400,
                            ),
                    ),
                    Text((_position ??
                            Duration(
                                hours: 0,
                                minutes: 0,
                                seconds: 0,
                                milliseconds: 0))
                        .toString()
                        .substring(0, 7)),
                  ],
                ),
                SizedBox(height: 25),
                NeuBox(
                  child: 
                  // LinearPercentIndicator(
                  //   lineHeight: 10,
                  //   percent: _currentDuration != null && _position != null
                  //       ? (_currentDuration!.inSeconds / _position!.inSeconds)
                  //       : 0,
                  //   barRadius: Radius.circular(5),
                  //   backgroundColor: Colors.transparent,
                  // ),
                   Slider(
                    max: _position != null? (_position!.inSeconds).toDouble():0,
                    min: 0,
                    value:  _currentDuration != null?(_currentDuration!.inSeconds).toDouble(): 0,
                    onChanged: (value){
                      _player.seek(Duration(seconds: value.toInt()));
                    },
                    
                    )
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                          child: NeuBox(
                              child: IconButton(
                                  style: currentIndex == 0
                                      ? ButtonStyle(
                                          foregroundColor: MaterialStatePropertyAll(
                                              Colors.grey.shade400))
                                      : ButtonStyle(),
                                  onPressed: () {
                                    debugPrint(currentIndex.toString());
                                    if (currentIndex != 0) {
                                      previous();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.skip_previous_rounded,
                                  )))),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: NeuBox(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_isPaused) {
                                          _isPaused = false;
                                          _player.pause();
                                          setState(() {
                                            _isMenuOpened = false;
                                          });
                                        } else {
                                          _isPaused = true;
                                          _currentDuration == Duration.zero
                                              ? _player.resume()
                                              : playSurah(currentIndex);
                                          setState(() {
                                            _isMenuOpened = false;
                                          });
                                        }
                                      });
                                    },
                                    icon: Icon(_isPaused
                                        ? Icons.pause
                                        : Icons.play_arrow))),
                          )),
                      Expanded(
                          child: NeuBox(
                              child: IconButton(
                                  style: currentIndex == 113
                                      ? ButtonStyle(
                                        foregroundColor: MaterialStatePropertyAll(Colors.grey.shade400)
                                        )
                                      :ButtonStyle() ,
                                  onPressed: () {
                                    debugPrint(currentIndex.toString());
                                    if (currentIndex != 113) {
                                      next();
                                    }
                                  },
                                  icon: Icon(Icons.skip_next_rounded)))),
                    ],
                  ),
                )
              ],
            ),

            Positioned(
              top: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  AnimatedContainer(
                    duration:
                        Duration(milliseconds: 300),
                    height: _isMenuOpened
                        ? MediaQuery.of(context).size.height / 2
                        : 60, 
                    width: _isMenuOpened
                        ? MediaQuery.of(context).size.width / 1.3
                        : 60,
                      onEnd: () {
                        setState(() {
                         _isAnimationCompleated=!_isAnimationCompleated;
                        });
                      },
                    child: NeuBox(
                      child: _isMenuOpened&&_isAnimationCompleated
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Show floating player "),
                                        Switch.adaptive(
                                            value: _floatingPlayer,
                                            onChanged: (value) {
                                              setState(() {
                                                _floatingPlayer = value;
                                                showFloatingPlayer(context);
                                              });
                                            })
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isMenuOpened = !_isMenuOpened;
                                          
                                        });
                                        setState(() {
                                  _isSurahListOpened=false;
                                });
                                      },
                                      icon: Icon(Icons.menu),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.center,
                                          //   children: [
                                          //     Text("Reciter"),
                                          //     Text(
                                          //         "Mishari bin Rashid Alafasy"),
                                          //   ],
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.center,
                                          //   children: [
                                          //     Text("Surah"),
                                          //     Text(surahs[currentIndex]),
                                          //   ],
                                          // ),
                                           Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Surah List"),
                                              IconButton(onPressed: (){
                                                showSurahList(context);
                                              }, icon: Icon(Icons.my_library_music_rounded)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Surah audio URL"),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isMenuOpened = false;
                                                    });
                                                    if(currentIndex<9){
                                                      Clipboard.setData(ClipboardData(text: "https://server8.mp3quran.net/afs/00${currentIndex + 1}.mp3"));
                                                    } else if(currentIndex<99){
                                                      Clipboard.setData(ClipboardData(text: "https://server8.mp3quran.net/afs/0${currentIndex + 1}.mp3"));
                                                    }else if(currentIndex>100){
                                                      Clipboard.setData(ClipboardData(text: "https://server8.mp3quran.net/afs/${currentIndex + 1}.mp3"));
                                                    }                                             
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Copied to clipboard'),
          ),
        );
                                                  },
                                                  icon: Icon(Icons.copy))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                            RichText(
                                              text: TextSpan(
                                              children: [
                                                TextSpan(text: "All audios are taken \nfrom ", style: TextStyle(color: Colors.blueGrey)),
                                                TextSpan(text: "surahquran.com",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:Colors.red, decoration: TextDecoration.underline))
                                              ]
                                            )),
                                              
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isMenuOpened = false;
                                                    });
                                                    launch('https://surahquran.com/');
                                                  },
                                                  icon:
                                                      Icon(Icons.arrow_outward))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  _isMenuOpened = true;
                                });
                                  setState(() {
                                  _isSurahListOpened=false;
                                });
                              },
                              icon: Icon(Icons.menu),
                            ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
      bottomSheet:  AnimatedContainer(
                    duration:
                        Duration(milliseconds: 300),
                    height: _isSurahListOpened
                        ? MediaQuery.of(context).size.height *2 / 3
                        : 0,     
                        child: NeuBox(child: 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: ListView.builder(
                                itemCount: surahs.length,
                                itemBuilder:(context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                           playSurahByIndex(index);
                                        });
                                      },
                                      onDoubleTap: (){
                                        setState(() {
                                           playSurahByIndex(index);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [ 
                                          Row(
                                            children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(8),
                                                              child: SizedBox(
                                                                  height: 60,
                                                                  child: Image.network(
                                                                    "https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg",
                                                                    fit: BoxFit.cover,
                                                                  ))),
                                                            ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(surahs[index], style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                                                                    Text("Mishari bin Rashid Alafasy"),
                                                                  ],
                                                                )
                                            ],
                                          ),
                                          index==currentIndex?SizedBox(width: 60, child: Lottie.asset(
                                            kDebugMode ?"Animation1712941068031.json":"assets/Animation1712941068031.json",
                                            animate: _isPaused
                                            )):SizedBox(),
                                        ],
                                      ),
                                    )
                                  );
                                },),),
                                Expanded(flex:1,child: GestureDetector(
                                  onTap: (){setState(() {
                                  _isSurahListOpened=false;
                                });},
                                  child: ShadowBox(
                                    child: Text("Close"),
                                  ),
                                ) ,),
                            ],
                          ),
                        )),
                        )
      ),
    ));
  }
  //   ))
  // );
  //}
}
