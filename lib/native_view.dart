import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pemutar/native_view_controller.dart';

typedef void NativeViewCreatedCallback(NativeViewController controller);

class NativeView extends StatelessWidget {
  static const StandardMessageCodec _decoder = StandardMessageCodec();

  final NativeViewCreatedCallback onNativeViewCreated;
  final String videoUrl;

  const NativeView(
      {Key? key, required this.onNativeViewCreated, required this.videoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = {"video_url": this.videoUrl};

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "PemutarPlatformView",
        onPlatformViewCreated: _onPlatfromViewCreated,
        creationParams: args,
        creationParamsCodec: _decoder,
      );
    }

    return Container();
  }

  void _onPlatfromViewCreated(int id) {
    if (onNativeViewCreated == null) {
      return;
    }
    onNativeViewCreated(NativeViewController('pemutar'));
  }
}
