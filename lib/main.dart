import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:fezs_demo/home.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  runApp(MyApp());
    try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
  }
  // runZoned<Future<Null>>(() async {
  //   runApp(MyApp());
  //   WidgetsFlutterBinding.ensureInitialized();
  // }, onError: (error, stackTrace) async {
  //   //Do sth for error
  // });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
