// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/components/shadow_box.dart';
import 'package:itube/quran_provider/models/ayahtranslation.dart';
import 'package:itube/quran_provider/quran_repository.dart';
import 'package:quran/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyTest extends StatefulWidget{
  const MyTest({super.key, required this.page});
  final int page;
  @override
  State<MyTest> createState() => _MyTestState();
}

Widget surahPageViewer(int index, BuildContext context) {
if(MediaQuery.of(context).size.width>400&&MediaQuery.of(context).size.height<400){
  return
  kDebugMode?
   Image.asset(index<9?'quran-images/page00${index+1}.png':index<99?'quran-images/page0${index+1}.png':'quran-images/page${index+1}.png', fit: BoxFit.fitWidth,)
   :
   Image.asset(index<9?'assets/quran-images/page00${index+1}.png':index<99?'assets/quran-images/page0${index+1}.png':'assets/quran-images/page${index+1}.png', fit: BoxFit.fitWidth,);
}else{
 return 
 kDebugMode?
 Image.asset(index<9?'quran-images/page00${index+1}.png':index<99?'quran-images/page0${index+1}.png':'quran-images/page${index+1}.png',)
 :Image.asset(index<9?'assets/quran-images/page00${index+1}.png':index<99?'assets/quran-images/page0${index+1}.png':'assets/quran-images/page${index+1}.png',);
}
        
        
}
class _MyTestState extends State<MyTest> {
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
    currentPage = widget.page+1;
    pageController = PageController(initialPage: currentPage-1);
    initTranslationLanguage();
    for(int i = 0; i<getSurahCountByPage(currentPage);i++){
    _loadAyahTranslation(_getSurahNumbers(currentPage)[i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
            PageView.builder(
            controller: pageController,
            onPageChanged: (pageIndex) {
              setState(() => currentPage = pageIndex+1);
              debugPrint("$currentPage");
              debugPrint(getSurahCountByPage(currentPage).toString());
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: ShadowBox(
                          child: 
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                               IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 8),
                                 child: Text(_getTitles(currentPage).join(",")),
                               )
                        ],)),
                      ),
                    ),
                  ),
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
                           TextButton.icon(onPressed: (){
                            setState(() {
                              _isShowTranslationEnabled=true;
                            });
                           }, icon: Icon(Icons.library_books), label: Text("translation")),
                           Text("data")
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
  height: _isShowTranslationEnabled ? MediaQuery.of(context).size.height * 2 / 3 : 0,
  width: MediaQuery.of(context).size.width,
  color: Colors.white70,
  child: SingleChildScrollView(
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isShowTranslationEnabled = false;
            });
          },
          child: ShadowBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Close"),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: getSurahCountByPage(currentPage),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(_getTitles(currentPage).reversed.toList()[index],style: TextStyle(fontWeight: FontWeight.bold),),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ayahs[surahs.indexOf(_getTitles(currentPage).reversed.toList()[index])],
                  itemBuilder: (context, innerIndex) {
                    return ListTile(
                    title: Text("${surahsTranslationRu[_getSurahNumbers(currentPage).reversed.toList()[index]-1][innerIndex]}")
                    );
                  },
                ),
              ],
            );
          },
        ),
        
      ],
    ),
  ),
),

      ),
    );
  }
}
