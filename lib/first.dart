import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  File _image;
  File _video;
  VideoPlayerController _controller;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);

    setState(() {
      _image = image;
    });
  }

  Future getVideo() async {
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    await _playVideo(video);
    setState(() {
      _video = video;
    });
  }

  Future<void> _playVideo(File file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      _controller = VideoPlayerController.file(file);
      await _controller.setVolume(1.0);
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {});
    }
  }

  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller.dispose();
      _controller = null;
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  Widget _previewVideo() {
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 60,
        height: 80,
        child: AspectRatio(
            aspectRatio: _controller.value?.aspectRatio,
            child: VideoPlayer(_controller)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择图片/视频'),
      ),
      body: Center(
        child: Column(children: [
          _image == null ? Text('No image selected.') : Image.file(_image),
          _video == null ? Text('No video selected.') : _previewVideo(),
          Text(
            "\n\n",
          ),
          GestureDetector(
            onTap: getImage,
            child: Container(
              child: Text("选择图片"),
            ),
          ),
          Text(
            "\n\n",
          ),
          GestureDetector(
            onTap: getVideo,
            child: Container(
              child: Text("选择视频"),
            ),
          ),
        ]),
      ),
    );
  }
}
