import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {

  final String id;
  final int index;
  final String title;

  VideoScreen({required this.title,required this.id,required this.index});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  YoutubePlayerController? _controller;

  @override
  void initState() {

    _controller = YoutubePlayerController(
      initialVideoId:widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        loop: true,
      ),
    )..addListener((){});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title:Center(child: Text('${widget.title}')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              YoutubePlayer(
                controller: _controller!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}