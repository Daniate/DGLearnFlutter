import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isolate_huge_task/UserEntityVM.dart';
import 'package:flutter_isolate_huge_task/ListViewItemCellPlaceholder.dart';
import 'package:shimmer/shimmer.dart';
import 'UserEntity.dart';

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserEntity> _users = [];
  bool _parsing = false;

  void _parse() async {
    _users = [];
    setState(() {
      _parsing = true;
    });

    _users = await UserEntityVM.parseUsers();
    setState(() {
      _parsing = false;
    });
  }

  Widget _placeholderListView() {
    return ListView.builder(
      itemCount: 200,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.black54,
              highlightColor: Colors.black26,
              child: const ListViewItemCellPlaceholder(),
            ),
          ],
        );
      },
    );
  }

  Widget _usersListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return _itemCell(_users[index]);
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 5,
          color: Colors.lime,
        );
      },
      itemCount: _users.length,
    );
  }

  Widget _itemCell(UserEntity userEntity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96.0,
            height: 96.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: userEntity.avatarUrlString!,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return const CupertinoActivityIndicator(
                    color: Colors.green,
                    radius: 30,
                  );
                },
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error_outline);
                },
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Text("昵称：${userEntity.name}"),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Text("状态：${userEntity.statusMessage}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _parse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("开辟Isolate处理巨量任务"),
      ),
      body: Column(
        children: [
          PerformanceOverlay.allEnabled(),
          Expanded(
            child: _users.isEmpty ? _placeholderListView() : _usersListView(),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: ElevatedButton(
          onPressed: _parsing ? null : _parse,
          child: Text(_parsing ? "解析中……" : "解析"),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
