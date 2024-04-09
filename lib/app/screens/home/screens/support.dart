// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:itube/main.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';

class support extends StatefulWidget {
  const support({super.key});

  @override
  State<support> createState() => _supportState();
}

class _supportState extends State<support> {
 @override
  void initState() {
    _initStateAsync();
    super.initState();
  }
   void _initStateAsync() async{
  await translations.loadTranslations();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        elevation: 2.0,
        centerTitle: true,
        title: Text(
          translations.translate("Support", currentLanguage),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Center(child: 
      Text(translations.translate("Make Du'a for me, leave a feedback and help to improve the app, so you can earn good deeds too, In shaa Allah, this is your best support for me 😊", currentLanguage), textAlign: TextAlign.center, style: TextStyle(height: 3),)),
      );
  }
}