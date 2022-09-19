import 'dart:core';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_ffi/flutter_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterFfiPlugin = FlutterFfi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterFfiPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    List array = [];
    array.length = 4;
    for (int i = 0; i < array.length; ++i) {
      array[i] = Random().nextInt(100);
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FFI(Foreign Function Interface)'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Text(
                  'C function: ${array[0]} + ${array[1]} = ${_flutterFfiPlugin.nativeAddInCFunc(array[0], array[1])}'),
              Text(
                  'C++ function: ${array[2]} + ${array[3]} = ${_flutterFfiPlugin.nativeAddInCppFunc(array[2], array[3])}'),
            ],
          ),
        ),
      ),
    );
  }
}
