import 'package:flutter/material.dart';
import 'package:pemutar/native_view.dart';
import 'package:pemutar/native_view_controller.dart';

class NativeScreen extends StatefulWidget {
  const NativeScreen({Key? key}) : super(key: key);

  @override
  _NativeScreenState createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  NativeViewController? _nativeViewController;

  var videoUrl =
      "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemutar dari native'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _nativeViewController!.doPlay();
                    },
                    child: Text('Play'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _nativeViewController!.doPause();
                    },
                    child: Text('Pause'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _nativeViewController!.doMute();
                    },
                    child: Text('Mute'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: NativeView(
                videoUrl: videoUrl,
                onNativeViewCreated: (NativeViewController controller) {
                  setState(() {
                    _nativeViewController = controller;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
