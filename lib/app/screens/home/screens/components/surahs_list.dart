import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itube/app/screens/home/pages/homePage.dart';
import 'package:itube/app/screens/home/screens/components/quran_player.dart';
import 'package:itube/app/screens/home/screens/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SurahsList extends StatefulWidget {
  const SurahsList({super.key});

  @override
  State<SurahsList> createState() => _SurahsListState();
}

class _SurahsListState extends State<SurahsList> {
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
    return ListView.builder(
        itemCount: 114,
        itemBuilder: (context, index){
          return ListTile(
          trailing: Text((index+1).toString()),
            title: Text(surahs[index]),
            subtitle: Text("Mishari bin Rashid Alafasy"),
            leading: ClipRRect(borderRadius: BorderRadius.circular(20), child:Image.network("https://cdns-images.dzcdn.net/images/artist/bad685cc810fc6a0333e72528ec228a4/500x500.jpg", fit: BoxFit.cover,)),
            onTap: () {
           debugPrint(_connectionStatus);
           if(_connectionStatus!='Failed to get connectivity.'){
              Navigator.push(context, MaterialPageRoute(builder:(context) => ChangeNotifierProvider(
    create: (_) => PlaylistProvider(),
    child: QuranPlayer(index:index)
              ),));}else{
                 ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$_connectionStatus\nPlease check your internet connection."),
        ),
      );
              }
            
            },
          );
        });
  }
}