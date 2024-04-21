import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itube/app/screens/home.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/components/quran_player.dart';
import 'package:itube/app/screens/home/screens/models/playlist_provider.dart';
import 'package:provider/provider.dart';

import 'neu_box.dart';

class FavoriteSurahsList extends StatefulWidget {
  const FavoriteSurahsList({super.key});

  @override
  State<FavoriteSurahsList> createState() => _FavoriteSurahsListState();
}

class _FavoriteSurahsListState extends State<FavoriteSurahsList> {
   String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
 @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
      print(e.toString());
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
    _connectivitySubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
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
                                    icon: const Icon(Icons.arrow_back_ios_new))),
                          ),
                          const Text(" F A V O R I T I E S"),
                         const SizedBox(
                            height: 60,
                            width: 60,
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                  itemCount: favoriteSurahs.length,
                  itemBuilder: (context, index){
                    return ListTile(
                    trailing: Text((favoriteSurahs[index]+1).toString()),
                      title: Text(surahs[favoriteSurahs[index]]),
                      subtitle: const Text("Mishari bin Rashid Alafasy"),
                      leading: ClipRRect(borderRadius: BorderRadius.circular(20), child:Image.network("https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg", fit: BoxFit.cover,)),
                      onTap: () {
                     debugPrint(_connectionStatus);
                     if(_connectionStatus!='Failed to get connectivity.'){
                        Navigator.push(context, MaterialPageRoute(builder:(context) => ChangeNotifierProvider(
              create: (_) => PlaylistProvider(),
              child: QuranPlayer(index:favoriteSurahs[index])
                        ),));}else{
                           ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$_connectionStatus\nPlease check your internet connection."),
                  ),
                );
                        }
                      
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}