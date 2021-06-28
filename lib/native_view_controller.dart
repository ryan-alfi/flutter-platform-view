import 'package:flutter/services.dart';

class NativeViewController {
  MethodChannel? _channel;

  NativeViewController(String id) {
    _channel = new MethodChannel('flutter.native/$id');
    _channel!.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'sendFromNative':
        String text = call.arguments as String;
        return new Future.value("Text from native: $text");
    }
  }

  Future<void> doPlay() async {
    try {
      final String result = await _channel!.invokeMethod('play');
      print("Result from native: $result");
    } on PlatformException catch (e) {
      print("Error from native: $e.message");
    }
  }

  Future<void> doPause() async {
    try {
      final String result = await _channel!.invokeMethod('pause');
      print("Result from native: $result");
    } on PlatformException catch (e) {
      print("Error from native: $e.message");
    }
  }

  Future<void> doMute() async {
    try {
      final String result = await _channel!.invokeMethod('mute');
      print("Result from native: $result");
    } on PlatformException catch (e) {
      print("Error from native: $e.message");
    }
  }
}
