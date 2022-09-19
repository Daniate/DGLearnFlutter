import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_ffi_platform_interface.dart';

/// An implementation of [FlutterFfiPlatform] that uses method channels.
class MethodChannelFlutterFfi extends FlutterFfiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_ffi');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
