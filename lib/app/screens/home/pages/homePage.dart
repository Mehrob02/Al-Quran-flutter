// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:itube/app/screens/home/screens/Settings.dart';
import 'package:itube/app/screens/home/screens/components/shadow_box.dart';
import 'package:itube/app/screens/home/screens/reader.dart';
import 'package:itube/Surahs/surahs.dart';
import 'package:itube/app/screens/home/screens/reader_new.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:itube/translation_russian/translation_russian.dart';
List<String> surahs =["Al-Fatiha","Al-Baqarah","Ali-Imran","An-Nisaa","Al-Maaida","Al-An'am","Al-A'raf","Al-Anfal","At-Tawbah","Yunus","Hud","Yusuf","Ar-Ra'd","Ibrahim","Al-Hijr",
"An-Nahl","Al-Isra'","Al-Kahf","Maryam","Ta-Ha","Al-Anbiya","Al-Hajj","Al-Mu'minun","An-Nur","Al-Furqaan","Ash-Shu'ara","An-Naml","Al-Qasas","Al-Ankabut","Ar-Rum",
"Luqman","As-Sajda","Al-Ahzab","Saba'","Fatir","Ya-Seen","As-Saffat","Sad","Az-Zumar","Ghafir","Fussilat","Ash-Shura","Az-Zukhruf","Ad-Dukhan","Al-Jathiyah","Al-Ahqaf",
"Muhammad","Al-Fath","Al-Hujurat","Qaf","Ad-Dhariyat","At-Tur","An-Najm","Al-Qamar", "Ar-Rahman", "Al-Waqi'ah","Al-Hadid","Al-Mujadilah","Al-Hashr","Al-Mumtahanah",
"As-Saff","Al-Jumu'ah","Al-Munafiqun","At-Taghabun","At-Talaq","At-Tahrim","Al-Mulk","Al-Qalam","Al-Haqq","Al-Ma'arij","Nuh","Al-Jinn","Al-Muzzammil",
"Al-Muddassir","Al-Qiyamah","Al-Insan","Al-Mursalat","An-Naba'", "An-Naziat",  "Abasa",  "At-Takwir", "Al-Infitar",  "Al-Mutaffifin","Al-Inshiqaq","Al-Buruj", "At-Tariq",
"Al-A'la","Al-Ghashiyah", "Al-Fajr", "Al-Balad",  "Ash-Shams","Al-Layl",   "Adh-Dhuha","Ash-Shahr","At-Tin","Al-Alaq","Al-Qadr", "Al-Bayyinah",  "Az-Zalzala","Al-Adiyat",
"Al-Qari'ah","At-Takathur","Al-Asr","Al-Humazah","Al-Fil","Quraysh","Al-Ma'un","Al-Kawthar","Al-Kafirun","An-Nasr",  "Al-Masad","Al-Ikhlas","Al-Falaq","An-Nas",
];
List surahsMassive =[AlFatiha,alBaqarah,aliImran,anNisaa,alMaaida,alAnaam,alAraf,alAnfal,atTawbah,Yunus,Hud,Yusuf,arRaad,Ibrahim,alHijr,
anNahl,alIsraa,alKahf,Maryam,taHa,alAnbiya,alHajj,alMuminun,anNur,alFurqaan,ashShuara,anNaml,alQasas,alAnkabut,arRum,
Luqman,asSajda,alAhzab,Sabaa,Fatir,yaSeen,asSaffat,Sad,azZumar,Ghafir,Fussilat,ashShura,azZukhruf,adDukhan,alJaziyah,alAhqaf,
Muhammad,alFath,alHujurat,Qaf,adhDhariyat,atTur,anNajm,alQamar, arRahman, alWaqiah,alHadid,alMujadilah,alHashr,alMumtahanah,
asSaff,alJumuah,alMunafiqun,atTaghabun,atTalaq,atTahrim,alMulk,alQalam,alHaqqah,alMaarij,Nuh,alJinn,alMuzzammil,
alMuddassir,alQiyama,alInsan,alMursalat,anNabaa, anNaziat,  Abasa,  atTakwir, alInfitar,  alMutaffifin,alInshiqaq,alBuruj, atTariq,
alAla,alGashyaa, alFajr, alBalad, ashShams,alLayl,adDhuha,ashShahr,atTin,alAlaq,alQadr, alBayyina,azZalzala,alAdiyat,
alQariah,atTakathur,alAsr,alHumazah,alFil,Quraysh,alMaun,alKawthar,alKafirun,anNasr,alMasad,alIkhlas,alFalaq,anNas,
];
List surahsTranslationRu=[
translation_russian_ALFatiha,  translation_russian_alBaqarah, translation_russian_AliImran,    translation_russian_anNisa,     translation_russian_ALMaaida,
translation_russian_AlAnam,    translation_russian_AlAraf,    translation_russian_AlAnfal,     translation_russian_AtTawbah,   translation_russian_Yunus,
translation_russian_Hud,       translation_russian_Yusuf,     translation_russian_ArRaad,      translation_russian_Ibrahim,    translation_russian_AlHijr,
translation_russian_AnNahl,    translation_russian_AlIsraa,   translation_russian_AlKahf,      translation_russian_Maryam,     translation_russian_TaHa,
translation_russian_AlAnbiya,  translation_russian_AlHajj,    translation_russian_AlMuminun,   translation_russian_AnNur,      translation_russian_AlFurqan,
translation_russian_AshShuara, translation_russian_AnNaml,    translation_russian_AlQasas,     translation_russian_AlAnkabut,  translation_russian_ArRum,
translation_russian_Luqman,    translation_russian_AsSajda,   translation_russian_AlAhzab,     translation_russian_Sabaa,      translation_russian_Fatir,
translation_russian_YaSeen,    translation_russian_AsSaffat,  translation_russian_Sad,         translation_russian_AzZumar,    translation_russian_Ghafir,
translation_russian_Fussilat,  translation_russian_AshShura,  translation_russian_AzZukhruf,   translation_russian_AdDukhan,   translation_russian_AlJathiyah,
translation_russian_AlAhqaf,   translation_russian_Muhammad,  translation_russian_AlFath,      translation_russian_AlHujurat,  translation_russian_Qaf,
translation_russian_AdDhariyat,translation_russian_AtTur,     translation_russian_anNajm,      translation_russian_AlQamar,    translation_russian_ArRahman, 
translation_russian_AlWaqiah,  translation_russian_AlHadid,   translation_russian_AlMujadilah, translation_russian_AlHashr,    translation_russian_AlMumtahanah,
translation_russian_AsSaff,    translation_russian_AlJumuah,  translation_russian_AlMunafiqun, translation_russian_AtTaghabun, translation_russian_AtTalaq,
translation_russian_AtTahrim,  translation_russian_AlMulk,    translation_russian_AlQalam,     translation_russian_AlHaqq,     translation_russian_AlMaarij,
translation_russian_Nuh,       translation_russian_AlJinn,    translation_russian_AlMuzzammil, translation_russian_AlMuddassir,translation_russian_AlQiyamah,
translation_russian_AlInsan,   translation_russian_AlMursalat,translation_russian_AnNabaa,     translation_russian_AnNaziat,   translation_russian_Abasa,  
translation_russian_AtTakwir,  translation_russian_AlInfitar, translation_russian_AlMutaffifin,translation_russian_AlInshiqaq, translation_russian_AlBuruj,
translation_russian_AtTariq,   translation_russian_AlAla,     translation_russian_AlGhashiyah, translation_russian_AlFajr,     translation_russian_AlBalad, 
translation_russian_AshShams,  translation_russian_AlLayl,    translation_russian_AdDhuha,     translation_russian_AshShahr,   translation_russian_AtTin,
translation_russian_AlAlaq,    translation_russian_AlQadr,    translation_russian_AlBayyinah,  translation_russian_AzZalzala,  translation_russian_AlAdiyat,
translation_russian_AlQariah,  translation_russian_AtTakathur,translation_russian_AlAsr,       translation_russian_AlHumathah, translation_russian_AlMaun,
translation_russian_AlKawthar, translation_russian_AlKafirun, translation_russian_AnNasr,      translation_russian_AlMasad,    translation_russian_AlIkhlas,
translation_russian_AlFalaq,   translation_russian_AnNas,
];
String viewSettings=  "List";
List <int> ayahs=[
7,286,200,176,120,165,206,75,129,109,123,111,43,52,99,128,111,110,98,135,112,78,118,64,77,227,93,88,69,60,34,30,73,54,45,83,182,88,75,85,54,53,89,59,37,
35,38,29,18,45,60,49,62,55,78,96,29,22,24,13,14,11,11,18,12,12,30,52,52,44,28,28,20,56,40,31,50,40,46,42,29,19,36,25,22,17,19,26,30,20,15,21,11,8,8,19,
5,8,8,11,11,8,3,9,5,4,7,3,6,3,5,4,5,6
];
String currentLanguage = '';
bool listItemPressed=false;
Widget gridItem(BuildContext context, int index){
return ShadowBox(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => reader(surahs[index],ayahs[index],0)),
            );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Container( alignment: Alignment.center, child: Text((index+1).toString(),style: const TextStyle(fontSize: 20, color: Colors.red),),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(surahs[index],style: const TextStyle(fontSize: 18,color: Colors.red),textAlign: TextAlign.center),
            Text("${ayahs[index]} verses",style: const TextStyle(fontSize: 12,color: Colors.red), textAlign: TextAlign.center,)
          ],
        ),
                    
      ]),
    ),
  ),
);
}
Container listItem(BuildContext context,int index){
  return Container(
    height: MediaQuery.of(context).size.height>MediaQuery.of(context).size.width? MediaQuery.of(context).size.height*0.10:MediaQuery.of(context).size.height*0.20,
    width: MediaQuery.of(context).size.width,
    child:TextButton( 
      onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => reader(surahs[index],ayahs[index],0)),
          );
    }, child: Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Container(width: MediaQuery.of(context).size.width*0.15, alignment: Alignment.center, child: Text((index+1).toString(),style: const TextStyle(fontSize: 30, color: Colors.red),),),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surahs[index],style: const TextStyle(fontSize: 18,color: Colors.red),),
                Text("${ayahs[index]} verses",style: const TextStyle(fontSize: 10,color: Colors.red),)
              ],
            ),
          ],
        ),
      ),
    ),
  ));
}

class homePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {

 @override
  void initState() {
    super.initState();
    initFontSize();
    initTranslationLanguage();
    _loadViewSettings();
  }
  void _loadViewSettings() async{
    viewSettings = await _getViewSettings();
    setState(() {});
  }
  Future<String> _getViewSettings() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("ViewSetting") ?? viewSettings;
  }
  void onListItemPressed(){
    setState(() {
      listItemPressed=!listItemPressed;
      });
  }
  Future initFontSize() async{
    fontSize = await _getFontSize();
  }
  
  Future<double> _getFontSize() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getDouble("ayahFontSize")??23;
  }
  Future initTranslationLanguage() async{
    currentLanguage = await _getTranslationLanguage();
  }
  
  Future<String> _getTranslationLanguage() async{
    var prefs = await  SharedPreferences.getInstance();
  return prefs.getString("ayahTranslationLanguage")??'en';
  }
   Future _setViewSettings() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("ViewSetting", viewSettings); // Save view setting
  }
  @override
Widget build(BuildContext context) {
  return  Scaffold(
    floatingActionButton: FloatingActionButton(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(40)),
      backgroundColor: Colors.red[600],
      onPressed: (){
      if(viewSettings=="List"){
        setState(() {
          viewSettings="Grid";
        });
      }
      else{
        setState(() {
          viewSettings="List";
        });
      }
      _setViewSettings();
    },
   child: Icon(viewSettings=="Grid"? Icons.list_alt_rounded:Icons.grid_on_outlined, color: Colors.white,),),
    body: Container(
      child: 
      viewSettings!="List"?
    GridView.builder(
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width<MediaQuery.of(context).size.height?3:MediaQuery.of(context).size.width<900?4:6,
      ),
      itemCount: 114,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: gridItem(context,index),
        );
      },
    )
    :
    SingleChildScrollView(
      child: Column(
        children: [
          Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 114,
              itemBuilder: (context, index) {
                return listItem(context, index);
              },
            ),
          ),
        ],
      ),
    ),),
  );
}
}