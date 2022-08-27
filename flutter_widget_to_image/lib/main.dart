import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// https://api.flutter-io.cn/flutter/rendering/RenderRepaintBoundary/toImage.html
class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();

  Logger logger = Logger();

  Uint8List? _imgByteData;
  File? _imgFile;

  Future<Uint8List?> _capturePngByteData() async {
    RenderObject? obj = globalKey.currentContext?.findRenderObject();
    if (null == obj || obj is! RenderRepaintBoundary) {
      return null;
    }
    RenderRepaintBoundary boundary = obj;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<bool> _savePngFile() async {
    Uint8List? pngData = await _capturePngByteData();

    setState(() {
      _imgByteData = pngData;
    });

    if (null == pngData) {
      return false;
    }

    // 保存到相册
    if (!await _requestPermission()) {
      return false;
    }
    await ImageGallerySaver.saveImage(pngData, quality: 100);

    // 保存到其他目录
    Directory? docsDir;

    if (Platform.isAndroid) {
      docsDir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      docsDir = await getApplicationDocumentsDirectory();
    }
    if (null == docsDir) {
      return false;
    }
    File pngFile = File("${docsDir.path}/1.png");
    File finalFile = await pngFile.writeAsBytes(pngData, flush: true);

    setState(() {
      _imgFile = finalFile;
    });

    logger.d("finalFile: $finalFile");

    return true;
  }

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.storage.status;
      if (status.isDenied) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    } else if (Platform.isIOS) {
      // 这里忽略 iOS，ImageGallerySaver 在 saveImage 的时候，会请求权限
      return true;
    }
    return false;
  }

  Widget _capturedImageWidget() {
    Widget child;
    if (null == _imgByteData) {
      child = const Icon(
        Icons.error_outline,
        color: Colors.redAccent,
        size: 300,
      );
    } else {
      child = Image.memory(
        _imgByteData!,
      );
    }
    return Container(
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RepaintBoundary(
              key: globalKey,
              child: Center(
                child: Container(
                  color: Colors.blueAccent,
                  child: Text(
                    '为控件生成图片 ${DateTime.now().toIso8601String()}',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      shadows: kElevationToShadow[16],
                    ),
                  ),
                ),
              ),
            ),
            _capturedImageWidget(),
            Text("图片保存路径：${_imgFile?.path}"),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: ElevatedButton(
          onPressed: _savePngFile,
          child: const Text(
            "为控件生成图片",
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
