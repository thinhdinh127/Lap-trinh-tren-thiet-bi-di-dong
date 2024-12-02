import 'package:btprofile/dangnhap.dart';
import 'package:btprofile/example.dart';
import 'package:btprofile/profile.dart';
import 'package:btprofile/trangchu.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examples',
      theme: ThemeData(

        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}