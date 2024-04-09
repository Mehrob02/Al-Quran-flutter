// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itube/blocs/authentification_bloc/authentification_bloc.dart';
import 'package:itube/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:itube/main.dart';
import 'package:itube/app/screens/home/pages/bookMarksPage.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

Container passworsReset(BuildContext context) {
  var email = FirebaseAuth.instance.currentUser!.email!;
  return Container(
    child: Column(
      children: [
        SizedBox(height: 25),
        ElevatedButton(
          style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red),
  ),
          onPressed: () async {
            try {
              await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
           
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translations.translate('Email has been sent', currentLanguage)),
                  action: SnackBarAction(
                    label: translations.translate("Close", currentLanguage),
                    onPressed: () {
                      // Дополнительные действия
                    },
                  ),
                ),
              );
            } catch (error) {
              print('Error sending email $error');
            }
          },
          child: Text(translations.translate("Change Password", currentLanguage),style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}
var acs=ActionCodeSettings(url: 'https://itube-32fc3.firebaseapp.com', handleCodeInApp: true,);  
Container verify(BuildContext context){
return Container(
  alignment: Alignment.center,
  child: Column(
    children: [
      SizedBox(height: 10),
      ElevatedButton(
        style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red),
  ),
        onPressed: () async{
try {
  await FirebaseAuth.instance.currentUser!.sendEmailVerification(acs);
  ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translations.translate('Email has been sent', currentLanguage)),
                  action: SnackBarAction(
                    label: translations.translate('Close', currentLanguage),
                    onPressed: () {
                      // Дополнительные действия
                    },
                  ),
                ),
              );
  Future.delayed(Duration(seconds: 3),() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
context.read<SignInBloc>().add(SignOutRequired());

  });            
} catch (e) {
  print('Error sending email $e');
}
        },
         child: Text(translations.translate("verify", currentLanguage),style: TextStyle(color: Colors.white)))
    ],
  ),
);
} 
class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  late User _user;
  String? _userName;
  final user = FirebaseAuth.instance.currentUser!;
   bool _isLoading = true; 
  @override
  void initState() {
    _initStateAsync();
    _getUserData();
    super.initState();
  }
  void _initStateAsync() async{
  await translations.loadTranslations();
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
Future<void> _getUserData() async {
    // Get currently authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        _user = user;
      });

      try {
        // Retrieve user data from Firestore
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if(mounted){
          setState(() {
          _userName = snapshot['name'];
          _isLoading = false; // Set loading indicator to false when data is loaded
        });
        }
      } catch (error) {
        debugPrint("Error retrieving user data: $error");
        setState(() {
          _isLoading = false; // Set loading indicator to false in case of error
        });
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository,
      ),
      child: Scaffold(
        body: Center(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 4,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red[600],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _userName![0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              !FirebaseAuth.instance.currentUser!.emailVerified
                  ? verify(context)
                  : const SizedBox(),
              passworsReset(context),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red),
  ),
                  onPressed: () async{
                     SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
                    context.read<SignInBloc>().add(SignOutRequired());
                  },
                  child: Text(translations.translate("Sign out", currentLanguage),style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}