// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/components/shadow_box.dart';
import 'package:itube/my_test/mytestfile.dart';
import 'package:itube/quran_provider/models/ayahtranslation.dart';
import 'package:itube/quran_provider/quran_repository.dart';
import 'package:quran/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ReaderNew extends StatefulWidget{
  const ReaderNew({super.key, required this.page});
  final int page;
  @override
  State<ReaderNew> createState() => _ReaderNewState();
}

Widget surahPageViewer(int index, BuildContext context) {
if(MediaQuery.of(context).size.width>400&&MediaQuery.of(context).size.height<400){
  return
  kDebugMode?
   ColorFiltered(
    colorFilter:ColorFilter.mode(
      Theme.of(context).brightness!=Brightness.dark?Color.fromARGB(135, 215, 187, 127):Color.fromARGB(0, 0, 0, 0),
  BlendMode.color
      ),
      child:Image.asset(index<9?'quran-images/page00${index+1}.png':index<99?'quran-images/page0${index+1}.png':'quran-images/page${index+1}.png', fit: BoxFit.fitWidth,color: Theme.of(context).brightness!=Brightness.dark?Colors.black: Colors.white,))
   :
  ColorFiltered(
    colorFilter:ColorFilter.mode(
      Theme.of(context).brightness!=Brightness.dark?Color.fromARGB(135, 215, 187, 127):Color.fromARGB(0, 0, 0, 0),
     BlendMode.color
      ),
      child: Image.asset(index<9?'assets/quran-images/page00${index+1}.png':index<99?'assets/quran-images/page0${index+1}.png':'assets/quran-images/page${index+1}.png', fit: BoxFit.fitWidth,color: Theme.of(context).brightness!=Brightness.dark?Colors.black: Colors.white,)
  );
}else{
 return 
 kDebugMode?
 ColorFiltered(
    colorFilter:ColorFilter.mode(
      Theme.of(context).brightness!=Brightness.dark?Color.fromARGB(135, 215, 187, 127):Color.fromARGB(0, 0, 0, 0),
     BlendMode.color
      ),
      child: Image.asset(index<9?'quran-images/page00${index+1}.png':index<99?'quran-images/page0${index+1}.png':'quran-images/page${index+1}.png',color:Theme.of(context).brightness!=Brightness.dark?Colors.black: Colors.white,))
 : ColorFiltered(
   colorFilter:ColorFilter.mode(
      Theme.of(context).brightness!=Brightness.dark?Color.fromARGB(135, 215, 187, 127):Color.fromARGB(0, 0, 0, 0),
      BlendMode.color
      ),
      child:Image.asset(index<9?'assets/quran-images/page00${index+1}.png':index<99?'assets/quran-images/page0${index+1}.png':'assets/quran-images/page${index+1}.png',color: Theme.of(context).brightness!=Brightness.dark?Colors.black: Colors.white,));
}
        
        
}
class _ReaderNewState extends State<ReaderNew> {
  late int currentPage;
  late PageController pageController;
  bool _isHideMenu =false;
  bool _isShowTranslationEnabled=false;
  late String getTitlesString;
  List<AyahTranslation>? ayahtranslation;
Future initTranslationLanguage() async{
    currentLanguage = await _getTranslationLanguage();
  }
  
  Future<String> _getTranslationLanguage() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("ayahTranslationLanguage")??'en';
  }
  void _loadAyahTranslation(int surah) async {
    ayahtranslation = await QuanRepository().getSurah(surah);
    setState(() {});
  }
List <String> _getTitles(int page){
    return getPageData(page)
    .map((e) => surahs[int.parse(e['surah'].toString())-1])
    .toList();
  }
  List <int> _getSurahNumbers(int page){
    return getPageData(page)
    .map((e) => int.parse(e['surah'].toString()))
    .toList();
  }
  
  @override
  void initState() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    currentPage = widget.page+1;
    pageController = PageController(initialPage: currentPage-1);
    initTranslationLanguage();
    for(int i = 0; i<getSurahCountByPage(currentPage);i++){
    _loadAyahTranslation(_getSurahNumbers(currentPage)[i]);
    }
    super.initState();
  } 
  @override
  void dispose() {
    // Release all sources and dispose the player.
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children:[
            PageView.builder(
            controller: pageController,
            onPageChanged: (pageIndex) {
              setState(() => currentPage = pageIndex+1);
              debugPrint("$currentPage");
              setState(() {
                _isShowTranslationEnabled = false;
                value=1;
              });
            },
            padEnds: false,
            reverse: true,
            itemCount: 604,
            itemBuilder: (context, index){
             return MediaQuery.of(context).size.width>400&&MediaQuery.of(context).size.height<400? SingleChildScrollView(
               child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isHideMenu=!_isHideMenu;
                    _isShowTranslationEnabled=false;
                  });
                },
                onDoubleTap: () {
                   setState(() {
                    _isHideMenu=!_isHideMenu;
                     _isShowTranslationEnabled=false;
                  });
                },
                child: surahPageViewer(index, context)
                ),
             ):GestureDetector(
                onTap: () {
                  setState(() {
                    _isHideMenu=!_isHideMenu;
                    _isShowTranslationEnabled=false;
                  });
                },
                onDoubleTap: () {
                   setState(() {
                    _isHideMenu=!_isHideMenu;
                     _isShowTranslationEnabled=false;
                  });
                },
                child: surahPageViewer(index, context)
                );
            }), 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedOpacity(
                  opacity: _isHideMenu?1:0,
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 300),
                  child: _isHideMenu? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: ShadowBox(
                          child: 
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                               IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_rounded)),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 8),
                                 child: Text(_getTitles(currentPage).join(","), style: TextStyle(fontWeight: FontWeight.bold),),
                               )
                        ],)),
                      ),
                    ),
                  ):SizedBox(),
                ),
                AnimatedOpacity(
              opacity: _isHideMenu?1:0,
              curve: Curves.linear,
              duration: Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: ShadowBox(
                      child: 
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        IconButton(onPressed: (){
                          setState(() {
                            pageController.nextPage(duration: Duration(milliseconds: 800), curve: Curves.linear);
                          });
                        }, icon: Icon(Icons.arrow_back)),
                           TextButton.icon(onPressed: (){
                            setState(() {
                              _isShowTranslationEnabled=true;
                              _isHideMenu=false;
                            });
                           }, icon: Icon(Icons.library_books), label: Text("translation")),
                           Text("Page $currentPage"),
                            IconButton(onPressed: (){
                          setState(() {
                            pageController.previousPage(duration: Duration(milliseconds: 800), curve: Curves.linear);
                          });
                        }, icon: Icon(Icons.arrow_forward)),
                    ],)),
                  ),
                ),
              ),
            ), 
              ],
            ), 
            
          ]
        ),
        bottomSheet: AnimatedContainer(
  duration: Duration(milliseconds: 300),
  height: _isShowTranslationEnabled?MediaQuery.of(context).size.height * 2 / 3 : 0,
  width: MediaQuery.of(context).size.width,
  color: Colors.white70,
  child: SingleChildScrollView(
    child: Column(
      children: [
       
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: getSurahCountByPage(currentPage),
          itemBuilder: (context, index) {
            return MyTest(ayahNumber: ayahs[surahs.indexOf(_getTitles(currentPage).reversed.toList()[index])], surahName: _getTitles(currentPage).reversed.toList()[index], value:1, currentPage: currentPage,index:index);
          },
        ),
         GestureDetector(
          onTap: () {
            setState(() {
              _isShowTranslationEnabled = false;
              value =1;
            });
          },
          child: ShadowBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Close"),
            ),
          ),
        ),
      ],
    ),
  ),
),

      ),
    );
  }
}