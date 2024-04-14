// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';
import 'package:itube/app/app_wiev.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/listen_quran_screen.dart';
import 'package:itube/my_test/mytestfile.dart';
import 'package:itube/app/screens/home/screens/qibla_direction_screen.dart';
import 'package:itube/app/screens/welcome_screen.dart';
import 'package:itube/services/notification.dart';
import 'package:itube/translation.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';
import 'app/screens/home/screens/models/playlist_provider.dart';
import 'firebase_options.dart';
import 'app/screens/home/screens/reader.dart'; 
Translations translations = Translations();
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _enablePlatformOverrideForDesktop();
  await NotificationServices.initializeNotification();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
 
  await translations.loadTranslations();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red,
    ),                 
  home:WelcomeScreen(userRepository: FirebaseUserRepo())
 )
   
  );
}

