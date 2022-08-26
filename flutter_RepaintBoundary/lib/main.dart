import 'package:flutter/material.dart';
import 'package:flutter_repaintboundary/DotPainter.dart';
import 'package:flutter_repaintboundary/ExpensiveDrawingPainter.dart';

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
      home: const MyHomePage(title: 'RepaintBoundary'),
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

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _dotPainterKey = GlobalKey();
  Offset _pos = const Offset(100, 100);

  bool _turnOnRepaintBoundary = false;

  Widget _backgroundWidget() {
    return CustomPaint(
      painter: ExpensiveDrawingPainter(),
      isComplex: true,
      willChange: false,
      size: MediaQuery.of(context).size,
    );
  }

  Widget _repaintBoundaryBackgroundWidget() {
    return RepaintBoundary(
      child: _backgroundWidget(),
    );
  }

  Widget _dotWidget() {
    return Listener(
      onPointerDown: _updatePosition,
      onPointerMove: _updatePosition,
      child: CustomPaint(
        key: _dotPainterKey,
        painter: DotPainter(_pos),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
        ),
      ),
    );
  }

  Widget _repaintBoundaryDotWidget() {
    return RepaintBoundary(
      child: _dotWidget(),
    );
  }

  void _updatePosition(PointerEvent event) {
    RenderBox? renderBox =
        _dotPainterKey.currentContext?.findRenderObject() as RenderBox;
    Offset pos = renderBox.globalToLocal(event.position);
    setState(() {
      _pos = pos;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: _turnOnRepaintBoundary
            ? [
                _repaintBoundaryBackgroundWidget(),
                _repaintBoundaryDotWidget(),
              ]
            : [
                _backgroundWidget(),
                _dotWidget(),
              ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 120,
          color: Colors.lime,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Text(
                      "移动白色小球时，并不需要重绘其他控件，此时可以使用RepaintBoundary",
                      style: TextStyle(
                        color: Colors.blue,
                        // fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _turnOnRepaintBoundary
                        ? "RepaintBoundary 已启用"
                        : "RepaintBoundary 已禁用",
                  ),
                  Switch(
                    value: _turnOnRepaintBoundary,
                    onChanged: (value) {
                      setState(() {
                        _turnOnRepaintBoundary = value;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
