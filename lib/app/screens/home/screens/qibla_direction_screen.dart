import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';


class QiblaDirectionScreen extends StatefulWidget {
  @override
  _QiblaDirectionScreenState createState() => _QiblaDirectionScreenState();
}

class _QiblaDirectionScreenState extends State<QiblaDirectionScreen> {
   double _qiblaDirection = 0;
  bool _isLoading = true;
double longitude = 0; // Example longitude value
   double latitude = 0; 
   double? heading;
   
  @override
  void initState() {
   _getLocation();
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _getQiblaDirection(latitude, longitude);
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading!;
      });
    });
    super.initState();
  }
Future<void> _getLocation() async {
    try {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
          setState(() {
            latitude = position.latitude;
            longitude = position.longitude;
             _getQiblaDirection(latitude, longitude);
          });
    } catch (e) {
      print('Error getting locatio: $e');
    }
  }
  Future<void> _getQiblaDirection(double latitude, double longitude) async {
    try {
      final dio = Dio();
      final response =
          await dio.get('http://api.aladhan.com/v1/qibla/$latitude/$longitude');
      if (response.statusCode == 200) {
        setState(() {
          _qiblaDirection = response.data['data']['direction'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load Qibla direction');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
             double angleDifference = ((_qiblaDirection - heading!.ceil()) % 360).abs();
Color textColor = angleDifference < 1 ? Colors.green : Colors.white;
     return Scaffold(
      backgroundColor:Colors.red.shade800,
      appBar: AppBar(title: Text("QIBLA DIRECTION"),),
      body: _isLoading
            ? CircularProgressIndicator()
            : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
Text(
  '${heading!.ceil() > 0 ? heading!.ceil() : (heading!.ceil() + 360)} deg',
  style: TextStyle(
    fontSize: 30,
    color: textColor,
  ),
),

          SizedBox(height: 50),
           Padding(
             padding: const EdgeInsets.all(18.0),
             child: Stack(
              alignment: Alignment.center,
                      children: [
                        Transform.rotate(angle: (heading??0) * (math.pi/180)*-1, child:Image.asset("assets/compass.png"),),
                         Image.asset("assets/nail.png")
                      ],
                    ),
           ),
            Text(
                        _qiblaDirection != null
                            ? 'Qibla Direction: ${_qiblaDirection.floor()} degrees'
                            : 'Failed to load Qibla direction',
                        style: TextStyle(fontSize: 20,  color: Colors.white70),
                      ),
           Text("your latitude : ${latitude==0?'detecting....':latitude}, \n your longitude: ${longitude==0?'detecting...':longitude}, ${(latitude==0 && longitude==0)?'\n make shoure that you enabled location services':''}", style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}