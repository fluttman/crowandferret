// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({super.key});

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  final Color mainColor = const Color(0xFF734D9F);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87, //mainColor,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: AssetImage('assets/images/main_logo.png')),
            ),
          ),
          Text(
            'Crow & Ferret',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            'info@crowandferret.com',
            style: TextStyle(color: Colors.grey[200], fontSize: 15),
          ),
          Text(
            '123456789',
            style: TextStyle(color: Colors.grey[200], fontSize: 15),
          ),
        ],
      ),
    );
  }
}
