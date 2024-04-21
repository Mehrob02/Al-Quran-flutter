import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itube/app/screens/home/screens/reader_viewer.dart';
import 'package:itube/app/app_wiev.dart';
import 'package:itube/theme_provider/provider.dart';
import 'package:itube/Surahs/alFatiha.dart';
import 'package:itube/app/screens/home/pages/bookMarksPage.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../main.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}
double fontSize =20;
class _settingsState extends State<settings>
    with SingleTickerProviderStateMixin {
      String? _userName;
  late AnimationController _controller;
   
  @override
  void initState(){
    _initStateAsync();
    super.initState();
   getUserData();
    initFontSize();
    _loadReadingView();
    _controller = AnimationController(vsync: this);
  }
  Future<bool> _setReadingView()async{
      var prefs = await SharedPreferences.getInstance();
  return prefs.setBool("readingView",isReaderView);
  } 
  void _loadReadingView()async{
      var prefs = await SharedPreferences.getInstance();
  isReaderView=prefs.getBool("readingView")??true;
  } 
  void _initStateAsync() async{
  await translations.loadTranslations();
  }
  void saveData(String jsonString) {
  // Проверяем, что пользователь аутентифицирован
  if (FirebaseAuth.instance.currentUser != null) {
    // Получаем UID текущего пользователя
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Сохранение данных в Firebase
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'bookMarks': jsonString,
      'email':FirebaseAuth.instance.currentUser!.email,
      'name':_userName,
      'user_id':uid
    });
  } else {
    print('Пользователь не аутентифицирован');
  }
}
Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
        
        setState(() {
          _userName = snapshot['name'];
        });
      } catch (error) {
        print("Error retrieving user data: $error");
      }
    }
    Future loadBookmakJson() async{
    jsonString = await _getBookmakJson();
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
    Future uploadData() async {
    User? user = FirebaseAuth.instance.currentUser;
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
        debugPrint(jsonString);
       
       debugPrint(snapshot['bookMarks']);
          setState(() {
            jsonString = snapshot['bookMarks'];
            _setBookmakJson();
          });
         ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translations.translate('Uploaded sucessifully!', currentLanguage)),
                ),
              );
      } catch (error) {
        debugPrint("Error retrieving user data: $error");
        ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translations.translate("Coudn't  get your data. Check internet connection and  try again.", currentLanguage)),
                ),
              );
      }
    }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementFont() async{
     if (fontSize < 36) {
    setState(() {
      fontSize+=1;
    });
    }
    await _setFontSize();
  }
  void _decrementFont() async{
    if (fontSize > 16) {
    setState(() {
      fontSize-=1;
    });
    }
    await _setFontSize();
  }Future _setFontSize() async{
    var prefs = await  SharedPreferences.getInstance();
    prefs.setDouble("ayahFontSize", fontSize);
  }
  Future initFontSize() async{
    fontSize = await _getFontSize();
  }
  Future initTranslationLanguage() async{
    currentLanguage = await _getTranslationLanguage();
  }
  
  Future<String> _getTranslationLanguage() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("ayahTranslationLanguage")??'en';
  }
  Future _setTranslationLanguage() async{
    var prefs = await  SharedPreferences.getInstance();
    prefs.setString("ayahTranslationLanguage", currentLanguage);
  }
  Future<double> _getFontSize() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getDouble("ayahFontSize")??23;
  }
  void changeLanguageToEn(){
    setState(() {
      currentLanguage = 'en';
    });
    setState(() {
                                _setTranslationLanguage();
                              });
  }
  void changeLanguageToRu(){
     setState(() {
      currentLanguage = 'ru';
    });
    setState(() {
                                _setTranslationLanguage();
                              });
  }
  Future inituseMaterial3() async{
    useMaterial3 = await _getuseMaterial3();
  }
  
  Future<bool> _getuseMaterial3() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getBool("auseMaterial3")??true;
  }
  Future<bool> _setuseMaterial3() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.setBool("auseMaterial3",useMaterial3);
  }
  Future <void> saveBookmarkData(BuildContext context) async{
  await showDialog(context: context, builder:(BuildContext context) {
     return  AlertDialog(
       title: const Text('Backup Bookmarks'),
       content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          const Text("Note, that this will erise your previous savings\nAre  you sure?"),
          const SizedBox(height: 10,),
           Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               TextButton(onPressed: () {
                                Navigator.of(context).pop(false);
               },
               child: const Text("Go Back"),),
               TextButton(onPressed: () {
              try {
                              saveData(jsonString);
                   Fluttertoast.showToast(
        msg: translations.translate("Your data saved in cloud database!", currentLanguage),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
                            } catch (e) {
                              debugPrint("Error saving data to file");
              Fluttertoast.showToast(
        msg: translations.translate("Couldn't connect to the database. Check internet connection and try again.", currentLanguage),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
                            }
                            Navigator.of(context).pop();
           },
           child: const Text("Backup"),),
             ],
           ),
         ],
       )
       );
   },);
  }
  
  Future<void> uploadBookmarkData(BuildContext context) async {
  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent users from dismissing the dialog
    builder: (context) {
      return AlertDialog(
        title: const Text("Checking database..."),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
          ],
        ),
      );
    },
  );

  // Get user data
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

  // Dismiss loading dialog
  Navigator.of(context, rootNavigator: true).pop();

  // Show upload confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Upload Bookmarks'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Are you sure? "),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Upload Status: "),
                Container(
                  child: snapshot['bookMarks'] == null
                      ? const Text("You don't have saved data")
                      : const Text("Ready to restore Data"),
                ),
              ],
            ),
            snapshot['bookMarks'] != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("Go Back"),
                      ),
                      TextButton(
                        onPressed: () {
                          try {
                            uploadData();
                          } catch (e) {
                            debugPrint("Error");
                          }
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Upload"),
                      ),
                    ],
                  )
                : TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Go Back"),
                  ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        elevation: 2.0,
        centerTitle: true,
        title: Text(
        translations.translate("Settings", currentLanguage),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return Scaffold(
            body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
            children: [
             !isReaderView? Card(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                     child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text(
                        translations.translate("AYAHS FONT SETTINGS", currentLanguage),
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30,),),
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(AlFatiha[0],style: TextStyle(fontSize: fontSize, fontFamily: "quran"),),
                          Text(fontSize.toString(),style: TextStyle(fontSize: fontSize),),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(             
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [  
                          ElevatedButton(
                            onPressed: (){
                              _decrementFont();
                          },
                          style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Colors.red),
                    ), child: Text(translations.translate("Smaller", currentLanguage),style: const TextStyle(color: Colors.white),),
                          ),
                          ElevatedButton(onPressed: (){
                            _incrementFont();
                          },
                          style: ButtonStyle(
                       backgroundColor:MaterialStateProperty.all(Colors.red),
                    ), child: Text(translations.translate("Larger", currentLanguage),style: const TextStyle(color: Colors.white)),
                    
                          ),
                          
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    
                  ],
                ),
              ):const SizedBox(),
              Card(
                child: Column(
                 children: [
                  ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: Text(translations.translate("Dark theme", currentLanguage)),
                    trailing: Switch.adaptive(
                     value: notifier.isDark,
                      onChanged: (value)=>notifier.changeTheme()
                    )
                    ),
                    ListTile(
                    leading: const Icon(Icons.widgets_rounded),
                    title: Text(translations.translate("Change UI depending on Themes", currentLanguage)),
                    trailing: Switch.adaptive(
                     value: useMaterial3,
                      onChanged: (value){
                      setState(() {
                        useMaterial3 = !useMaterial3;
                      });
                      _setuseMaterial3();
                      notifier.changeTheme();
                      notifier.changeTheme();
                      }
                    )
                    )
                  ], 
                ),
              ),
              Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             Text(translations.translate("Translation Language", currentLanguage)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                      
                                ElevatedButton(onPressed: () {
                                  changeLanguageToEn();
                                },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(currentLanguage=='en'? Colors.red:Theme.of(context).colorScheme.background),foregroundColor: const MaterialStatePropertyAll(Colors.black)),child: const Text('en'),),
                                ElevatedButton(onPressed: () {
                                  changeLanguageToRu();
                                },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(currentLanguage=='ru'? Colors.red:Theme.of(context).colorScheme.background),foregroundColor: const MaterialStatePropertyAll(Colors.black) ),child: const Text('ru'),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ), 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(onPressed: (){
                          
                          saveBookmarkData(context);
                        
                        }, 
                        child: const Text("Backup Bookmark data")),
                        const SizedBox(height: 5,),
TextButton(
  onPressed: () async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .get();

      if (!snapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You don't have saved data"),
          ),
        );
      } else {
        uploadBookmarkData(context);

      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  },
  child: const Text("Upload Bookmark data"),
),


                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Current mode: ${!isReaderView?"List":"Book"}"),
              TextButton(onPressed: (){
                setState(() {
    isReaderView=!isReaderView;
    _setReadingView();
  });
              }, child: const Text("Change"))
            ],
          
          )
            ],
                  ),
                  ),
          );
          }
        )
      );
  }
}