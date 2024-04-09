// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NeuBox extends StatefulWidget {
  final child;
  const NeuBox({super.key, required this.child});

  @override
  State<NeuBox> createState() => _NeuBoxState();
}

class _NeuBoxState extends State<NeuBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness==Brightness.light?Colors.grey[300] : Colors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
              color: Theme.of(context).brightness==Brightness.light?Colors.grey.shade500:Colors.grey.shade700,
              blurRadius: 15,
              offset: Offset(5, 5)
              ),
              BoxShadow(
              color: Theme.of(context).brightness==Brightness.light?Colors.white:Colors.grey.shade800,
              blurRadius: 15,
              offset: Offset(-5, -5)
              ),
            ]
          ),
          child: Center(
            child: widget.child,
          ),
        );
  }
}