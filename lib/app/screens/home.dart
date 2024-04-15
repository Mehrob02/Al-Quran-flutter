// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:itube/app/screens/home/screens/listen_quran_screen.dart';
import 'package:itube/theme_provider/provider.dart';
import 'package:itube/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:itube/main.dart';
import 'package:itube/app/screens/home/screens/Feedback.dart';
import 'package:itube/app/screens/home/screens/Settings.dart';
import 'package:itube/app/screens/home/pages/namaz_time.dart';
import 'package:itube/app/screens/home/pages/profile.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/pages/bookMarksPage.dart';
import 'package:itube/app/screens/home/screens/support.dart';
import 'package:itube/app/screens/home/screens/reader.dart';
import 'package:itube/app/screens/home/screens/csc_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/authentification_bloc/authentification_bloc.dart';
import 'home/screens/models/playlist_provider.dart';
 bool useMaterial3 = true;
 String? locationCity;
 String? locationCountry;
 List favoriteSurahs=[];
 List <Color> bookMarkColors =[
Colors.red,
Colors.blue,
Colors.green.shade600,
Colors.purple,
Colors.pink,
Colors.indigo,
Colors.orange,
Colors.brown,
Colors.yellow,
Colors.teal
 ];
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
     return ChangeNotifierProvider(
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
              primaryColor: Colors.red.shade800,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade800),
              useMaterial3: useMaterial3,
            ),
            home:MyHomePage(title: 'ITUBE',));}));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User _user;
  String? _userName;
  bool _isLoading = true;
  int _currentIndex = 0;
   String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final List<Widget> _children = [
    homePage(),
    bookMarksPage(),
   NamazTime(),
    const profilePage(),
  ];

  Future<String> _getCurrentUser() async{
  var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("currentUser") ?? _userName!;
  }

 Future<void> _setCurrentUser() async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString("currentUser", _userName!);
}

  
  void _loadViewSettings() async{
    viewSettings = await _getViewSettings();
  }
  Future<String> _getViewSettings() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("ViewSetting")??"List";
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
  
Future<void> loadData() async {

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    List<dynamic> markList = jsonMap['mark'];
    setState(() {
      data = markList.map((list) => List<String>.from(list)).toList();
      marks = jsonMap.keys.toList();
    });
  } void _initStateAsync() async{
  await translations.loadTranslations();
  }
  @override
  void initState() {  
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent)
  );  
  
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
   _initStateAsync();
loadBookmakJson();
_getCurrentUser();
   // inituseMaterial3();
    _loadViewSettings();
   if(locationCity == null&&locationCountry==null){
    setState(() {
      locationCity='Yekaterinburg';
      locationCountry='Russia';
    });
   }
   setState(() {
   });
    _getUserData();
    super.initState();
  }
   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
   @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    _connectivitySubscription.cancel();
    super.dispose();
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

        setState(() {
          _userName = snapshot['name'];
          _setCurrentUser();
          _isLoading = false; // Set loading indicator to false when data is loaded
        });
      } catch (error) {
        setState(() {
          _isLoading = false; // Set loading indicator to false in case of error
        });
      }
    }
  }
  
  
  void showSheet(){
    showBottomSheet(context: context, builder: (context){
     return Text("");
    });
  }
  @override
  Widget build(BuildContext context) {
    
   return BlocProvider<SignInBloc>(
   create: (context)=>SignInBloc(
                        userRepository: context.read<AuthenticationBloc>().userRepository),
  child: Scaffold(
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
                color: Colors.red,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          :  Text(
                 _userName!,
                  style: TextStyle(color: Colors.white,fontSize: 25),
                ),
                Text(FirebaseAuth.instance.currentUser!.email??"connection error",style: const TextStyle(color: Colors.white),)
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(translations.translate('Settings', currentLanguage)),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const settings()),
          )
            },
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title:  Text(translations.translate('Feedback', currentLanguage)),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => feedback()),
          )
            },
          ),
          ListTile(
            leading: const Icon(Icons.handshake_outlined),
            title: Text(translations.translate('Support', currentLanguage)),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const support()),
          )
            },
          ),
          ListTile(
            leading: const Icon(Icons.headphones),
            title: Text('Listen Quran'),
            onTap: () => {
              Navigator.pop(context),
              debugPrint(_connectionStatus),
             if(_connectionStatus!='Failed to get connectivity.'){
              Navigator.push(
          context,
           MaterialPageRoute(builder:(context) =>  ListenQuran()
           )   
          )}else{
             ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$_connectionStatus\nPlease check your internet connection."),
          ))
          }
            },
          ),
        ],
      ),
    ),
    appBar:
    _currentIndex!=2? 
    AppBar(
      backgroundColor: Colors.red.shade800,
      foregroundColor: Colors.white,
      title: Text(widget.title,style: const TextStyle(color: Colors.white),),
      actions:[
       _currentIndex==0? IconButton(
          onPressed: (){
            debugPrint(MediaQuery.of(context).size.height.toString());
            showSearch(
              context: context,
               delegate: CustomSearchDelegate());
          },
         icon: const Icon(Icons.search)):const SizedBox()
      ],
    )
    :AppBar(
      backgroundColor: Colors.red.shade800,
      foregroundColor: Colors.white,
      centerTitle: true,
      title: ElevatedButton.icon(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStatePropertyAll(Colors.red.shade800,)
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>CSC_Picker()) );
      },
       icon: Icon(Icons.location_on), 
       label: Text('$locationCity, $locationCountry')),
      elevation: 0,
    ),
      body: _children[_currentIndex],
      bottomNavigationBar:  Container(
            color: Colors.red.shade800,
            child: Padding(
              padding: MediaQuery.of(context).size.width>MediaQuery.of(context).size.height?const EdgeInsets.all(0):const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
              child: GNav(
                style: GnavStyle.google,
              curve: Curves.linear,
                backgroundColor: Colors.red.shade800,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.withOpacity(0.5),
                padding: const EdgeInsets.all(14),
                selectedIndex: _currentIndex,
                onTabChange: onTabTapped,
                gap: 8,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    iconColor: Colors.white,
                    text: translations.translate("Home", currentLanguage),
                  ),
                  GButton(
                    icon: Icons.book,
                    iconColor: Colors.white,
                    text: translations.translate("Bookmarks", currentLanguage),
                  ),
                  GButton(
                    icon: Icons.access_time_rounded,
                    iconColor: Colors.white,
                    text: translations.translate("Salah time", currentLanguage),
                  ),
                  GButton(
                    icon: Icons.manage_accounts_sharp,
                    iconColor: Colors.white,
                    text: translations.translate("You", currentLanguage),
                  ),
                ],
              ),
            ),
          )
    )
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    if(query.isNotEmpty){
      return[
     IconButton(onPressed: (){ query='';}, icon: const Icon(Icons.clear))
   ];
    }else{
      return[];
    }
   
  }
  @override
  Widget? buildLeading(BuildContext context) {
   return
    IconButton(onPressed: (){ close(context, null);}, icon: const Icon(Icons.arrow_back))
   ;
  }

  @override
  Widget buildResults(BuildContext context) {
   List<String> machResoults=[];
   for (var surah in surahs) {
     if(surah.toLowerCase().contains(query.toLowerCase())){
      machResoults.add(surah);
     }else if(int.tryParse(query)!=null){
      machResoults.clear();
      machResoults.add(surahs[int.parse(query)-1]);
     }
   }
   return machResoults.isNotEmpty? ListView.separated(
    itemCount: machResoults.length ,
    separatorBuilder: (context, index) => const Divider(),
    itemBuilder: (context,index){
      var result = machResoults[index];
      return ListTile(title: Text(result),onTap: () {
        Navigator.pop(context);
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => reader(result,ayahs[surahs.indexOf(result)],0)),
          );
      },);
    }):const Center(child:Text("No Result Found"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   List<String> machResoults=[];
   for (var surah in surahs) {
     if(surah.toLowerCase().contains(query.toLowerCase())){
      machResoults.add(surah);
     }else if(int.tryParse(query)!=null){
      if(int.tryParse(query)!>0 &&int.tryParse(query)!<115){
      machResoults.clear();
      machResoults.add(surahs[int.parse(query)-1]);
     }}
   }
   return machResoults.isNotEmpty? ListView.separated(
    itemCount: machResoults.length ,
    separatorBuilder: (context, index) => const Divider(),
    itemBuilder: (context,index){
      var result = machResoults[index];
      return ListTile(title: Text(result),onTap: () {
        Navigator.pop(context);
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => reader(result,ayahs[surahs.indexOf(result)],0)),
          );
      },);
    }):const Center(child:Text("No Result Found"));
  }
}
