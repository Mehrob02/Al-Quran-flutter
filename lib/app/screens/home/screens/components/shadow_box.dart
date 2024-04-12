// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShadowBox extends StatefulWidget {
  final child;
  const ShadowBox({super.key, required this.child});

  @override
  State<ShadowBox> createState() => _ShadowBoxState();
}

class _ShadowBoxState extends State<ShadowBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
           color: Theme.of(context).brightness==Brightness.light?Colors.white70 : Colors.black87, 
           borderRadius: BorderRadius.circular(29),
           boxShadow: [
           BoxShadow(
            offset: Offset(5, 5),
            blurRadius: 8,
            color: Theme.of(context).brightness==Brightness.light?Color(0xFFD3D3D3).withOpacity(.84):Color.fromARGB(255, 101, 101, 101).withOpacity(.64),  
           ),
           BoxShadow(
            offset: Offset(-5, -5),
            blurRadius: 8,
            color: Theme.of(context).brightness==Brightness.light?Color(0xFFD3D3D3).withOpacity(.84):Color.fromARGB(255, 101, 101, 101).withOpacity(.64),  
           )
           ]
          ),
          child: Center(
            child: widget.child,
          ),
        );
  }
}