// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:itube/Surahs/surahs.dart';
import 'package:itube/app/app_wiev.dart';
import 'package:itube/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
   void _loadIsWelcomePageShown() async {
  isWelcomePageShown = await _getIsWelcomePageShown();
  setState(() {}); // Обновляем виджет после загрузки значения
}
  Future<bool> _getIsWelcomePageShown() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getBool("isWelcomePageShown")??false;
  }
   Future<void> _setIsWelcomePageShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isWelcomePageShown", isWelcomePageShown);
    debugPrint(isWelcomePageShown.toString());
  }
 @override
Widget build(BuildContext context) {
  return  Scaffold(
         body: SingleChildScrollView(
  child: SizedBox(
    height: MediaQuery.of(context).size.height,
    child:  Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(20,-1.2),
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red[600],
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-2.7,-1.2),
          child: Container(
            height: MediaQuery.of(context).size.width/1.5,
            width: MediaQuery.of(context).size.width/1.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(2.7,-1.2),
          child: Container(
            height: MediaQuery.of(context).size.width/1.4,
            width: MediaQuery.of(context).size.width/1.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 234, 174, 35),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height/1.6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AlFatiha[0], style: TextStyle(fontFamily: "quran", fontSize: 40, color: Colors.white),),
                  SizedBox(height: 8.0),
                  Text("Be closer to Quran", style: TextStyle(color: Colors.white),),
                ],
              ))
              ),
                ],
              ),
            ),),
            floatingActionButton: Container(
             decoration: BoxDecoration( shape:BoxShape.rectangle, borderRadius: BorderRadius.circular(30)),
              child: TextButton(
                focusNode: FocusNode(),
                onPressed: (){
                  setState(() { 
                    isWelcomePageShown=true;    
                    _setIsWelcomePageShown();   
                  });
                },    
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Start the way to Jannah...", style: TextStyle(color: Colors.red),),
                )),
              ),
            );
}

}
