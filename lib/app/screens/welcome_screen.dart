// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itube/app/app_wiev.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/profile.dart';
import 'package:itube/app/screens/registrationPage.dart';
import 'package:itube/blocs/authentification_bloc/authentification_bloc.dart';
import 'package:itube/my_test/mytestfile.dart';
import 'package:itube/theme_provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.userRepository});
 final UserRepository userRepository;
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _loadIsWelcomePageShown();
    Future.delayed(Duration(seconds: 3),()async{
     !isWelcomePageShown?Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>appWiev(FirebaseUserRepo())))
     :Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
      userRepository:widget.userRepository
      ),
      child: BlocBuilder<AuthenticationBloc,AuthenticationState>(builder: (context,state){
          if(state.status!=AuthenticationStatus.authenticated){
          return registrationPage();
          }else{
        return  ChangeNotifierProvider(
      create: (BuildContext context)=>UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Itube',
            //By default theme setting, you can also set system
            // when your mobile theme is dark the app also become dark

            themeMode: notifier.isDark? ThemeMode.dark : ThemeMode.light,

            //Our custom theme applied
            darkTheme: notifier.isDark? notifier.darkTheme : notifier.lightTheme,

            theme: ThemeData(
              primaryColor: Theme.of(context).primaryColor,
              colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).primaryColor),
              useMaterial3: useMaterial3,
            ),
            home: MyApp());}));
          }
          
        }
      ),
    )))
     ;
    });
    inituseMaterial3();
    super.initState();
  }
  void _loadIsWelcomePageShown() async {
  isWelcomePageShown = await _getIsWelcomePageShown();
  setState(() {}); 
}
 Future inituseMaterial3() async{
    useMaterial3 = await _getuseMaterial3();
  }
  Future<bool> _getuseMaterial3() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getBool("auseMaterial3")??true;
  }
  Future<bool> _getIsWelcomePageShown() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getBool("isWelcomePageShown")??false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.pink,Colors.red.shade600,Color.fromARGB(255, 234, 174, 35)], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 80,width:80,
          child:Image.asset(kDebugMode?'welcomeIcon.jpg':'assets/welcomeIcon.jpg',fit: BoxFit.cover),
          ),
          SizedBox(height: 20,),
          Text("اَلسَّلَامُ عَلَيْكُم", style: TextStyle(fontFamily: "quran", fontSize: 35, color: Colors.white),)
        ]),
      ),
    );
  }
}