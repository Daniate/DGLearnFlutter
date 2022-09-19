import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ffi/flutter_ffi.dart';
import 'package:flutter_ffi/flutter_ffi_platform_interface.dart';
import 'package:flutter_ffi/flutter_ffi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFfiPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFfiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFfiPlatform initialPlatform = FlutterFfiPlatform.instance;

  test('$MethodChannelFlutterFfi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFfi>());
  });

  test('getPlatformVersion', () async {
    FlutterFfi flutterFfiPlugin = FlutterFfi();
    MockFlutterFfiPlatform fakePlatform = MockFlutterFfiPlatform();
    FlutterFfiPlatform.instance = fakePlatform;

    expect(await flutterFfiPlugin.getPlatformVersion(), '42');
  });
}
