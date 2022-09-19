import 'flutter_ffi_platform_interface.dart';
import 'dart:ffi';
import 'dart:io';

typedef MyNativeFunc = Int32 Function(Int32, Int32);
typedef MyDartFunc = int Function(int x, int y);

class FlutterFfi {
  MyDartFunc? _nativeAddInCFunc;
  MyDartFunc? _nativeAddInCppFunc;

  FlutterFfi() {
    final DynamicLibrary nativeApiLib = Platform.isAndroid
        ? DynamicLibrary.open('libNativeApi.so')
        : DynamicLibrary.process();

    // _nativeAddInCFunc = nativeApiLib
    //     .lookup<NativeFunction<MyNativeFunc>>("native_add_in_c")
    //     .asFunction();
    // _nativeAddInCppFunc = nativeApiLib
    //     .lookup<NativeFunction<MyNativeFunc>>("native_add_in_cpp")
    //     .asFunction();

    // or
    _nativeAddInCFunc = nativeApiLib.lookupFunction<MyNativeFunc, MyDartFunc>('native_add_in_c');
    _nativeAddInCppFunc = nativeApiLib.lookupFunction<MyNativeFunc, MyDartFunc>('native_add_in_cpp');
  }

  MyDartFunc get nativeAddInCFunc => _nativeAddInCFunc!;
  MyDartFunc get nativeAddInCppFunc => _nativeAddInCppFunc!;

  Future<String?> getPlatformVersion() {
    return FlutterFfiPlatform.instance.getPlatformVersion();
  }
}
