import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ffi_method_channel.dart';

abstract class FlutterFfiPlatform extends PlatformInterface {
  /// Constructs a FlutterFfiPlatform.
  FlutterFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFfiPlatform _instance = MethodChannelFlutterFfi();

  /// The default instance of [FlutterFfiPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFfi].
  static FlutterFfiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFfiPlatform] when
  /// they register themselves.
  static set instance(FlutterFfiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
