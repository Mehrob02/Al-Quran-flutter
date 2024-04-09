// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itube/main.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/reader.dart';
import 'package:itube/app/screens/home/screens/components/tag.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bookMarksPage extends StatefulWidget {
  @override
  _bookMarksPageState createState() => _bookMarksPageState();
}
String jsonString = '''
    {
      "mark":[]
    }
  ''';
List <String> marks=[];
List<List<String>> data = []; 
class _bookMarksPageState extends State<bookMarksPage> {


  bool isFloatingActionButtonClicked= false;
  bool bookMarksHide=false;



@override
  void initState() { 
    loadBookmakJson();
    loadData();
    _initStateAsync();
    super.initState();
  } 
   void _initStateAsync() async{
  await translations.loadTranslations();
  }
Future loadBookmakJson() async{
    jsonString = await _getBookmakJson();
    loadData();
  }  
 Future<String> _getBookmakJson() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("bookmakJson")??'''
    {
      "mark":[]
    }
  ''';
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
 
void addTag(String mark) {
  Map<String, dynamic> jsonMap = json.decode(jsonString);
  jsonMap[mark] = [];
  String updatedJsonString = json.encode(jsonMap);
  jsonString = updatedJsonString; 
  setState(() {
    loadData(); 
    _setBookmakJson();
  });
  debugPrint(jsonString);
}
void removeTag(String mark) {
  Map<String, dynamic> jsonMap = json.decode(jsonString);

   if(mark!='mark'){
    jsonMap.remove(mark);
   }
  String updatedJsonString = json.encode(jsonMap);
  jsonString = updatedJsonString;
  setState(() {
    loadData(); 
    _setBookmakJson();
  });
  debugPrint(jsonString+"dd");
}
void addToTag(String mark, String surah, String ayah){
Map<String, dynamic> jsonMap = json.decode(jsonString);
  jsonMap[mark].add([surah, ayah]);
  String updatedJsonString = json.encode(jsonMap);
  setState(() {
    jsonString=updatedJsonString;
    loadData();
    _setBookmakJson();
  });
  debugPrint(jsonString);
 }
void removeFromTag(String mark, String surah, String ayah) {
  Map<String, dynamic> jsonMap = json.decode(jsonString);

  jsonMap[mark].removeWhere((mark)=>mark[0]==surah&&mark[1]==ayah);
  // setState(() {
  //           buildBookmarkList.removeWhere((bookmark) =>
  //               bookmark[0] == widget.surah &&
  //               bookmark[1] == (index + 1).toString());
  //         });
  String updatedJsonString = json.encode(jsonMap);
  
  setState(() {
    jsonString = updatedJsonString;
    loadData();
    _setBookmakJson();
  });

  debugPrint(jsonString);
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

  

 String? bookMarkName;
 void addBookMarkCollection(String bookMarkTitle){
          addTag(bookMarkTitle);
 }
 Future<void> addBookMarkCollectionShowDialog(BuildContext context) async{
 bookMarkName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations.translate('Enter Bookmark Collection name', currentLanguage)),
          content: TextField(
            onChanged: (value) => bookMarkName = value,
            decoration: InputDecoration(hintText: translations.translate("Name of the collection", currentLanguage)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(bookMarkName);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (bookMarkName != null && bookMarkName!.isNotEmpty) {
      debugPrint('Имя книги: $bookMarkName');
      addBookMarkCollection(bookMarkName!);
    } else {
      debugPrint('Имя книги не введено');
    }
    setState(() {
      bookMarkName='';
    });
  }
   Future<void> removeBookMarkCollectionShowDialog(BuildContext context) async{
String? selectedMark;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(translations.translate("Select a Mark", currentLanguage)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              value: selectedMark,
              onChanged: (value) => setState(() {selectedMark = value;}),
              items: marks.map<DropdownMenuItem<String>>((String mark) {
                return DropdownMenuItem(
                  value: mark,
                  child: Text(mark),
                  onTap: () {
                    setState(() {
                      selectedMark=mark;
                    });
                  },
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

  if (selectedMark != null && selectedMark != 'mark') {
    debugPrint('Выбранная метка: $selectedMark');
   try{
 removeTag(selectedMark!);
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

 Future<void> addMarkToBookMarkCollectionShowDialog(BuildContext context) async {
  String? selectedMark;
  String? surahValue;
  String? ayahValue;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(translations.translate("Select a Mark", currentLanguage)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedMark,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMark = newValue!;
                });
                
              },
              items: marks.map<DropdownMenuItem<String>>((String mark) {
                return DropdownMenuItem<String>(
                  value: mark,
                  child: Text(mark),
                );
              }).toList(),
            ),
            TextField(
              onChanged: (value) => surahValue = value,
              decoration: InputDecoration(hintText: translations.translate('Surah', currentLanguage)),
            ),
            TextField(
              onChanged: (value) => ayahValue = value,
              decoration: InputDecoration(hintText: translations.translate('Ayah', currentLanguage)),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (selectedMark != null &&
                  surahValue != null &&
                  surahValue!.isNotEmpty &&
                  ayahValue != null &&
                  ayahValue!.isNotEmpty) {
                Navigator.of(context).pop({'mark': selectedMark, 'surah': surahValue, 'ayah': ayahValue});
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

  if (selectedMark != null && surahValue != null && ayahValue != null) {
    debugPrint('Выбранная метка: $selectedMark');
    debugPrint('Surah: $surahValue');
    debugPrint('Ayah: $ayahValue');
   try{
 addToTag(selectedMark!, surahValue!, ayahValue!);
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


 
  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: marks.length,
          itemBuilder: (context, index) {
            
            return TagBuilder(mark: marks[index], data: loadDataFrom(marks[index]), removeFromTag: (String ayah, String surah) { 
              removeFromTag(marks[index], ayah, surah);
             },);
          },
        ),
      ),
      // floatingActionButtonLocation: 
      // FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: 
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //      FloatingActionButton(
        
      //   onPressed: (){
      //     addMarkToBookMarkCollectionShowDialog(context);
      //     // addToTag('mark','Surah2', 'Ayah2');
      //     // removeFromTag('mark','surah1', 'ayah1');
      //     // addToTag('mahmudjon','1', '2');
      //     // removeFromTag('mark','surah2', 'ayah2');
      //     // addTag("my favorities");
      //     setState(() {
      //       _setBookmakJson();
      //     });
      //   },
      //   tooltip: 'Add Data to tag',
      //   child: Icon(Icons.add),
      // ),
      //     FloatingActionButton(
      //       onPressed: (){
      //         //addTag('Tag$tagNumber');
      //         // addToTag('mark','Surah2', 'Ayah2');
      //         // removeFromTag('mark','surah1', 'ayah1');
      //         // addToTag('mahmudjon','1', '2');
      //         // removeFromTag('mark','surah2', 'ayah2');
      //         // addTag("my favorities");
      //         addBookMarkCollectionShowDialog(context); 
             
      //         _setBookmakJson();
      //       },
      //       tooltip: 'Add Data',
      //       child: Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: (){
      //         //addTag('Tag$tagNumber');
      //         // addToTag('mark','Surah2', 'Ayah2');
      //         // removeFromTag('mark','surah1', 'ayah1');
      //         // addToTag('mahmudjon','1', '2');
      //         // removeFromTag('mark','surah2', 'ayah2');
      //         // addTag("my favorities");
      //         removeBookMarkCollectionShowDialog(context); 
      //         setState(() {
      //           _setBookmakJson();
      //         });
      //       },
      //       tooltip: 'Delete Tag',
      //       child: Icon(Icons.motion_photos_off_rounded),
      //     ),
      //   ],
      // ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        animatedIcon: AnimatedIcons.menu_close,
        animationDuration: Duration(milliseconds: 500),
        icon: Icons.menu,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(Icons.remove),
            label:translations.translate("Remove bookmark coolection", currentLanguage),
            onTap: (){
               removeBookMarkCollectionShowDialog(context); 
              setState(() {
                _setBookmakJson();
              });
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: translations.translate("Add new bookmark collection", currentLanguage),
            onTap: () {
              addBookMarkCollectionShowDialog(context);
              _setBookmakJson();
            },
          ),
        ],
      ),
    );
  }
}

