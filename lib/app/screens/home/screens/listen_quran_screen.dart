// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/components/favorite_surah_list.dart';
import 'package:itube/app/screens/home/screens/components/quran_player.dart';
import 'package:itube/app/screens/home/screens/models/playlist_provider.dart';
import 'package:itube/app/screens/home/screens/models/surah.dart';
import 'package:provider/provider.dart';
import 'package:quran/surah_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/neu_box.dart';
import 'components/surahs_list.dart';

class ListenQuran extends StatefulWidget {
  const ListenQuran({super.key});
  @override
  State<ListenQuran> createState() => _ListenQuranState();
}
var lastSurahIndex=null;
Duration lastSurahDuration=Duration.zero;
List reciters = ["Mishari bin Rashid Alafasy"];
class _ListenQuranState extends State<ListenQuran> {
 @override
  void initState() {
    _loadLastSurahIndex();
    _loadLastSurahDuration();
    super.initState();
  }
  Future<void> _loadLastSurahIndex() async{
     final prefs = await SharedPreferences.getInstance();
    if(prefs.getInt("lastSurahIndex")!=null){
        lastSurahIndex= prefs.getInt("lastSurahIndex");
    }
  }
  Future<void> _loadLastSurahDuration() async{
     final prefs = await SharedPreferences.getInstance();
    if(prefs.getInt("lastSurahDuration")!=null){
      
        lastSurahDuration=Duration(seconds: prefs.getInt("lastSurahDuration")!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      right: false, 
      left: false,
      child: Scaffold(
        // appBar: AppBar(
        //   iconTheme: IconThemeData(color: Colors.white),
        //   backgroundColor: Colors.red,
        //   elevation: 2.0,
        //   title: Text(
        //     "Select the surah",
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body:
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   SizedBox(
                            height: 60,
                            width: 60,
                            child: NeuBox(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back_ios_new))),
                          ),
                          Text("S E L E C T  T H E  S U R A H"),
                         SizedBox(
                            height: 60,
                            width: 60,
                            child: NeuBox(
                                child: IconButton(
                                    onPressed: () {
                                     showSearch(
                  context: context,
                   delegate: CustomSurahSearchDelegate());
                                    },
                                    icon: Icon(Icons.search))),
                          ),
                  ],
                ),
              ),
               SizedBox(height: 15),
               SizedBox(
                height: MediaQuery.of(context).size.height * .15,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: Row(
                    children: [
                      Expanded(flex: 1, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:(){
                            debugPrint("Favorities");
                            Navigator.push(context, MaterialPageRoute(builder:(context) {
                              return FavoriteSurahsList();
                            },));
                          },
                          child: NeuBox(child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Icon(Icons.favorite, color: Colors.redAccent),
                              Text("Favorities"),
                            ],
                          ))),
                      )),
                      Expanded(flex: 1, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:GestureDetector(
                          onTap:(){
                            debugPrint("Recent");

                          },
                          child: NeuBox(child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Icon(Icons.history),
                              Text("Recent"),
                            ],
                          ))),
                      )),
                      Expanded(flex: 1, child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:(){
                            debugPrint("Go to last");
                            if(lastSurahIndex!=null){
                              Navigator.push(context, MaterialPageRoute(builder:(context) => ChangeNotifierProvider(
      create: (_) => PlaylistProvider(),
      child: QuranPlayer(index:lastSurahIndex, lastSurahDuration: lastSurahDuration,)
                ),));
                              debugPrint("go!");
                            }
                          },
                          child: NeuBox(child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Icon(Icons.last_page_outlined),
                              Text("Go to last"),
                            ],
                          ))),
                      )),
                    ],
                   ),
                 ),
               ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: GestureDetector(
            //     onTap: () {
            //   Navigator.push(context, PageRouteBuilder(pageBuilder:(context, animation, secondaryAnimation) {
            //     return FavoriteSurahsList();
            //   },));
            //   },
            //     child: SizedBox(
            //       width: 120,
            //       height: 150,
            //       child: NeuBox(
            //       child: Text("Favorities"),
            //     ),
            //     ),
            //   ),
            // ),
              SizedBox(height: 15),
              Expanded(child: SurahsList()),
            ],
          )
            ),
    );
  }
}

class CustomSurahSearchDelegate extends SearchDelegate{
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
    IconButton(onPressed: (){ close(context, null);}, icon: const Icon(Icons.arrow_back));
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
      return ListTile(title: Text(result),leading: Text((surahs.indexOf(result)+1).toString()),onTap: () {
         Navigator.push(context, MaterialPageRoute(builder:(context) => ChangeNotifierProvider(
    create: (_) => PlaylistProvider(),
    child: QuranPlayer(index:surahs.indexOf(result))
              ),));
        Navigator.pop(context);
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
      return ListTile(title: Text(result),leading: Text((surahs.indexOf(result)+1).toString()),onTap: () {
        Navigator.pop(context);
         Navigator.push(context, MaterialPageRoute(builder:(context) => ChangeNotifierProvider(
    create: (_) => PlaylistProvider(),
    child: QuranPlayer(index:surahs.indexOf(result))
              ),));
      },);
    }):const Center(child:Text("No Result Found"));
  }
}