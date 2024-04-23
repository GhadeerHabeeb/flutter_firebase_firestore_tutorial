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
      body: Column(
        children: [
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
            ),

            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30.0,
                    child: Center(
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },

                        icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.grey,),
                      ),
                    ),
                  ),
                      Text('${widget.title}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.menu,size: 30,color: Colors.grey,),
                  )
                ],
              ),
            ),
          ),
          YoutubePlayer(
            controller: _controller!,
          ),
        ],
      ),
    );
  }
}