import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Buttons'),
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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: TrackingScrollController(),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SafeArea(
          child: Center(
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "ElevatedButton",
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_balance_wallet,
                  ),
                  label: const Text(
                    "ElevatedButton.icon",
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Text(
                    "ElevatedButton.icon",
                  ),
                  label: const Icon(
                    Icons.account_balance_wallet,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "TextButton",
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.access_alarm,
                  ),
                  label: const Text(
                    "TextButton.icon",
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Text(
                    "TextButton.icon",
                  ),
                  label: const Icon(
                    Icons.access_alarm,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Text(
                    "MaterialButton",
                  ),
                ),
                CupertinoButton(
                  onPressed: () {},
                  child: const Text(
                    "CupertinoButton",
                  ),
                ),
                CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text(
                    "CupertinoButton.filled",
                  ),
                ),
                const BackButton(
                  color: Colors.blueAccent,
                ),
                const CloseButton(
                  color: Colors.redAccent,
                ),
                FlatButton(
                  onPressed: () {},
                  child: const Text(
                    "FlatButton",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.access_alarm,
                  ),
                  label: const Text(
                    "FlatButton.icon",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: const Text(
                    "FlatButton.icon",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  label: const Icon(
                    Icons.access_alarm,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "OutlinedButton",
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.access_alarm,
                  ),
                  label: const Text(
                    "OutlinedButton.icon",
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Text(
                    "OutlinedButton.icon",
                  ),
                  label: const Icon(
                    Icons.access_alarm,
                  ),
                ),
                PopupMenuButton<int>(
                  tooltip: "PopupMenuButton",
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 1,
                        child: Text(
                          "PopupMenuButton > PopupMenuItem 1",
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text(
                          "PopupMenuButton > PopupMenuItem 2",
                        ),
                      ),
                    ];
                  },
                  position: PopupMenuPosition.under,
                ),
                RawMaterialButton(
                  onPressed: () {},
                  child: const Text(
                    "RawMaterialButton",
                  ),
                ),
                DropdownButton<int>(
                  items: [
                    DropdownMenuItem(
                      onTap: () {},
                      value: 1,
                      child: const Text(
                        "1",
                      ),
                    ),
                    DropdownMenuItem(
                      onTap: () {},
                      value: 2,
                      child: const Text(
                        "2",
                      ),
                    ),
                  ],
                  onChanged: (value) {},
                  hint: const Text(
                    "DropdownButton",
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  underline: const SizedBox(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_circle_outlined,
                  ),
                  tooltip: "IconButton",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "FloatingActionButton",
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
