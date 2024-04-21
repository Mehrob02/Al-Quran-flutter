// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:itube/Surahs/alFatiha.dart';
import 'package:itube/blocs/authentification_bloc/authentification_bloc.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/pages/profile.dart';
import 'package:itube/app/screens/registrationPage.dart';
import 'package:itube/app/screens/welcome_screen.dart';
import 'package:itube/theme_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'screens/home/pages/bookMarksPage.dart';

bool useMaterial3 = true;
class appWiev extends StatefulWidget {
  final UserRepository userRepository;
  appWiev(this.userRepository, {super.key});

  @override
  State<appWiev> createState() => _appWievState();
}
bool isWelcomePageShown=false;
class _appWievState extends State<appWiev> {
  Future<bool> _getuseMaterial3() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getBool("auseMaterial3")??true;
  }
@override
void initState() {
  _loadIsWelcomePageShown();
  loadBookmakJson();
  super.initState();
}
Future loadBookmakJson() async{
    jsonString = await _getBookmakJson();
  }  
 Future<String> _getBookmakJson() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("bookmakJson")?? '''
    {
      "mark":[]
    }
  ''';
  }  
void _loadIsWelcomePageShown() async {
  
    isWelcomePageShown = await _getIsWelcomePageShown();
    setState(() {}); // Обновляем виджет после загрузки значения
  }
  

Future<void> inituseMaterial3() async {
  await Future.microtask(() async {
    useMaterial3 = await _getuseMaterial3();
  });
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
    return
      !isWelcomePageShown
      ?
          Scaffold(
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
            ):
            RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
      userRepository:widget.userRepository
      ),
      child: BlocBuilder<AuthenticationBloc,AuthenticationState>(builder: (context,state){
          if(state.status!=AuthenticationStatus.authenticated){
          return registrationPage();
          }else {
         return MyApp();
          }
        })
       
    );
  }
}