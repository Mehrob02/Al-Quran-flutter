// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itube/Surahs/surahs.dart';
import 'package:itube/app/screens/home/screens/Settings.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/components/aboutAyahViewer.dart';
import 'package:just_bottom_sheet/drag_zone_position.dart';
import 'package:just_bottom_sheet/just_bottom_sheet.dart';
import 'package:just_bottom_sheet/just_bottom_sheet_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../pages/bookMarksPage.dart';

Color bookMarked = const Color.fromARGB(255, 237, 235, 235);
Color notBookMarked = Colors.white;
Widget ayahWiever(
    BuildContext context, List<String> surah, int index, String surahName) {
      final ayahViewerscrollController = ScrollController();
  return Text("${index+1}");
}

// ignore: camel_case_types
class reader_new extends StatefulWidget {
  final String surah;
  final int ayahs;
  final int indexToScroll;

  reader_new(this.surah, this.ayahs, this.indexToScroll);

  @override
  _reader_newState createState() => _reader_newState();
}

class _reader_newState extends State<reader_new> {
  final ScrollController _scrollController = ScrollController();
  final targetKey = GlobalKey();
  AudioPlayer player = AudioPlayer();
  final String text = "This is a sample text. It contains several sentences. Each sentence is clickable.";
  
  @override
  void initState() {
    super.initState(); 
    initFontSize();
  }
   // импортируем для использования функции Future.delayed



Future<void> playSound(int surah, int ayah) async {
  if (surah != 1 && ayah == 1) {
    await player.play(UrlSource('https://quranaudio.pages.dev/1/1_1.mp3'));
    await Future.delayed(Duration(seconds: 7));
    await player.play(UrlSource('https://quranaudio.pages.dev/1/${surah}_${ayah}.mp3'));
  } else {
    await player.play(UrlSource('https://quranaudio.pages.dev/1/${surah}_${ayah}.mp3'));
  }
}



 Future initFontSize() async{
    fontSize = await _getFontSize();
  }
  
  Future<double> _getFontSize() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getDouble("ayahFontSize")??23;
  }
  

  void onBookmarkChanged(List surah, bool isBookmarked, int index,) {
    showMenu(context: context, position: RelativeRect.fill, items: [
      PopupMenuItem(
        value: 'option1',
        child: Row(children: const [
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.copy_all,
              color: Colors.grey,
            ),
          ),
          Text("Copy")
        ]),
      ),
      
      PopupMenuItem(
        value: 'option3',
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.play_arrow, color: Colors.red,),
            ),
            Text("Play")
          ],
        ),
      ),
    ]);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text(widget.surah),
            leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);},),
            backgroundColor:useMaterial3? Theme.of(context).backgroundColor:Colors.white70,
            foregroundColor: Colors.red,
          ),
       body:ListView(
      children: [
        Wrap(
        //  alignment: WrapAlignment.end,
          children:[ for(int i =0; i< widget.ayahs; i++)  Text(AlFatiha[i],),]
          //  AlFatiha.map((sentence) {
          //   // return GestureDetector(
          //   //   onTap: () {
          //   //     // Действие при нажатии на предложение
          //   //     print('Clicked on: $sentence');
          //   //     // Здесь можно добавить ваш код для обработки нажатия
          //   //   },
          //   //   child: Text(
          //   //     textDirection: TextDirection.rtl,
          //   //     style:TextStyle(
                  
          //   //     ),
          //   //     sentence
          //   //   ),
          //   // );
          // }).toList(),
        ),
      ],
    )
     
     );
  }

  void _scrollToIndex() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent * widget.indexToScroll / widget.ayahs,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }
}