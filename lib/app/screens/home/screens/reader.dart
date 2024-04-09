// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itube/app/screens/home/screens/Settings.dart';
import 'package:itube/app/screens/home/pages/bookMarksPage.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/components/aboutAyahViewer.dart';
import 'package:just_bottom_sheet/drag_zone_position.dart';
import 'package:just_bottom_sheet/just_bottom_sheet.dart';
import 'package:just_bottom_sheet/just_bottom_sheet_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Color bookMarked = const Color.fromARGB(255, 237, 235, 235);
Color notBookMarked = Colors.white;


// ignore: camel_case_types
class reader extends StatefulWidget {
  final String surah;
  final int ayahs;
  final int indexToScroll;
  

  reader(this.surah, this.ayahs, this.indexToScroll);

  @override
  _readerState createState() => _readerState();
}

class _readerState extends State<reader> {
  final ScrollController _scrollController = ScrollController();
  final targetKey = GlobalKey();
  AudioPlayer player = AudioPlayer();
  bool _isReadingMode = false;
  List <String> marks=[];
List<List<String>> data=[]; 
  @override
  void initState() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    super.initState(); 
    initFontSize();
    loadData();
    loadBookmakJson();
    _scrollToIndex();
  }
@override
  void dispose() {
    // Release all sources and dispose the player.
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,]);
    player.dispose();

    super.dispose();
  }

Widget ayahWiever(
    BuildContext context, List<String> surah, int index, String surahName) {
      String? currentMark;
      bool isBookmarked=false;
      for(int i=0; i<marks.length;i++){
       bool Bookmarked= loadDataFrom(marks[i]).any((bookmark) => bookmark[0] == surahName && bookmark[1] == (index + 1).toString());
        if (Bookmarked==true) {
          isBookmarked=true;
          currentMark=marks[i];
        } 
        }
      final ayahViewerscrollController = ScrollController();
  return Container(
    
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
     border: Border(bottom: BorderSide(color: Colors.grey.shade200)) 
    ),
    // height: MediaQuery.of(context).size.height *.15,
    child: Stack(
      children:[ Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text((index + 1).toString()),
                IconButton(
                  onPressed: () {
                    showJustBottomSheet(
                      context: context,
                      dragZoneConfiguration: JustBottomSheetDragZoneConfiguration(
                  dragZonePosition: DragZonePosition.outside,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 4,
                      width: 30,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[300]
                          : Colors.white,
                    ),
                  ),
                ),
                      configuration: JustBottomSheetPageConfiguration(
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Material(
                            shape: const BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                AboutAyahViewer(surahs.indexOf(surahName), index),
                              ],
                            ),
                          ),
                        ));
                      }, height: MediaQuery.of(context).size.height*0.5, 
                      scrollController: ayahViewerscrollController,
                  cornerRadius: 16,
                  backgroundColor: Theme.of(context).canvasColor.withOpacity(1),
                      )
                    );
                  },
                  icon: const Icon(Icons.menu_book_rounded),
                  color: Colors.red[300],
                ),
              ],
            ),
            Expanded(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    surah[index],
                    style: TextStyle(fontSize: fontSize, fontFamily: "quran",fontWeight: FontWeight.w100, height: fontSize*0.1 ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 30,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
     isBookmarked?  Positioned(  // draw a red marble
              top: 0.0,
              right: 0.0,
              child:  Icon(Icons.bookmark, 
                color: bookMarkColors[marks.indexOf(currentMark!)%10]),
            ):SizedBox()
      ]
    ),
  );
}
Future<void> playSound(int surah, int ayah) async {
  if (surah != 1 && ayah == 1) {
    await player.play(UrlSource('https://quranaudio.pages.dev/1/1_1.mp3'));
    await Future.delayed(Duration(seconds: 7));
    await player.play(UrlSource('https://quranaudio.pages.dev/1/${surah}_${ayah}.mp3'));
  } else {
    await player.play(UrlSource('https://quranaudio.pages.dev/1/${surah}_${ayah}.mp3'));
  }
}

Future<void> loadData() async {

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    List<dynamic> markList = jsonMap['mark'];
    setState(() {
      data = markList.map((list) => List<String>.from(list)).toList();
      marks = jsonMap.keys.toList();
    });
  }
  List loadDataFrom(String mark){
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    List<dynamic> markList = jsonMap[mark];
    return data = markList.map((list) => List<String>.from(list)).toList();
     
  } 

 Future initFontSize() async{
    fontSize = await _getFontSize();
  }
  
  Future<double> _getFontSize() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getDouble("ayahFontSize")??23;
  }
 
  Future loadBookmakJson() async{
    jsonString = await _getBookmakJson();
    loadData();
  }  
 Future<String> _getBookmakJson() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("bookmakJson")??jsonString;
  }  
Future<void> _setBookmakJson() async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setString("bookmakJson", jsonString).then((_) {
    // После сохранения JSON строки, загружаем новое значение
    loadBookmakJson();
  }).catchError((error) {
    // Обработка ошибок, если таковые есть
    debugPrint("Error saving JSON string: $error");
  });
} 

Future <void> addToTagDialog(BuildContext context, String surah, String ayah)async{
String? selectedMark;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select a Mark'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              enableFeedback: true,
              value: selectedMark,
              onChanged: (value) {setState(() {selectedMark = value!;});
              },
              items: marks.map<DropdownMenuItem<String>>((String mark) {
                return DropdownMenuItem<String>(
                  value: mark,
                  child: Text(mark),
                );
              }).toList(),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (selectedMark != null) {
                Navigator.of(context).pop({'mark': selectedMark,});
              } else {
                // Выводите сообщение об ошибке или обработку в случае неверного ввода
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );

  if (selectedMark != null) {
    debugPrint('Выбранная метка: $selectedMark');
   try{
 addToTag(selectedMark!, surah, ayah);
   }catch(e){
    debugPrint(e.toString());
   }
  } else {
    debugPrint('Метка, Surah или Ayah не выбраны');
  }

  setState(() {
    // Обновите состояние по вашим требованиям
  });
}
void addToTag(String mark, String surah, String ayah){
Map<String, dynamic> jsonMap = json.decode(jsonString);
  jsonMap[mark].add([surah, ayah]);
  String updatedJsonString = json.encode(jsonMap);
  setState(() {
    jsonString=updatedJsonString;
    _setBookmakJson();
  });
  debugPrint(jsonString);
 }

  
  void onBookmarkChanged(List surah, bool isBookmarked, int index) {
    setState(() {
      for(int i=0; i<marks.length;i++){
       bool Bookmarked= loadDataFrom(marks[i]).any((bookmark) => bookmark[0] == widget.surah && bookmark[1] == (index + 1).toString());
        if (Bookmarked==true) {
          isBookmarked=true;
        } 
        }
    });
    debugPrint(isBookmarked.toString());
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
        value: 'option2',
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
      for(int i=0; !isBookmarked? i<1:i<0;i++)
      PopupMenuItem(
        value: 'option3',
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.push_pin_outlined, color: Colors.red,),
            ),
            Text("mark")
          ],)
      ),
    ]).then((value) {
      // Обработка выбора в меню
      if (value == 'option1') {
        Clipboard.setData(ClipboardData(text: surah[index]));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Copied to clipboard'),
          ),
        );
      }else if(value  == 'option2'){
       playSound(surahs.indexOf(widget.surah)+1,(index+1));
      }else if(value=='option3'){
          addToTagDialog(context,widget.surah,(index+1).toString());
        }
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: Text(widget.surah),
            leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context);},),
            //actions: [ IconButton(onPressed:(){ setState(() { _isReadingMode=!_isReadingMode;});},icon:Icon(_isReadingMode? Icons.remove_red_eye:Icons.remove_red_eye_outlined)),],
            floating: true,
        //    backgroundColor:useMaterial3? Theme.of(context).backgroundColor:Colors.white70,
            foregroundColor: Colors.red,
          ),
          SliverList(
            key: targetKey,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                    return GestureDetector(
                        onLongPress: () {
                          onBookmarkChanged(surahsMassive[surahs.indexOf(widget.surah)], false, index,);
                        },
                        child:
                            ayahWiever(context,surahsMassive[surahs.indexOf(widget.surah)], index, widget.surah));
              },
              // Builds 1000 ListTiles
              childCount: widget.ayahs,
              
            ),
          ), 
        ],
        
      ),
     
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
