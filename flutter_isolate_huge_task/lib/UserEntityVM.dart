import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'UserEntity.dart';

class UserEntityVM extends Object {
  static Future<List<UserEntity>> parseUsers() async {
    /// 只能在 main isolate 中读取文件，在其他 isolate 中读取文件会报错
    /// 参见：https://github.com/flutter/flutter/issues/61480#issuecomment-673985944
    final fileData = await rootBundle.loadString("assets/json/users.json");
    return await _parseUsersInBackground(fileData);
  }

  /// 生成一个 isolate，并等待第一个消息
  static Future<List<UserEntity>> _parseUsersInBackground(
      String content) async {
    /// ReceivePort: 让 worker isolate 可以向 main isolate 发送消息
    final rp = ReceivePort();

    await Isolate.spawn(_readAndParseUsersJson, [rp.sendPort, content]);

    return await rp.first as List<UserEntity>;
  }

  /// 在 spawned isolate 上执行的函数
  /// 读取文件内容
  /// 解码JSON
  /// 转换为模型
  /// 将结果返回给 main isolate
  static void _readAndParseUsersJson(List<dynamic> args) async {
    // 此处故意休眠几秒钟，模拟弱网环境
    sleep(Duration(seconds:3 + Random().nextInt(8)));

    SendPort sp = args[0];
    String content = args[1];

    final json = jsonDecode(content) as List;

    Isolate.exit(sp, UserEntity.fromJsonList(json));
  }
}
