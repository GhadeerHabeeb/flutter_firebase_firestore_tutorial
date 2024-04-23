
import 'package:flutter/material.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class ScrollLoopAuto extends StatelessWidget {
  List<String>images;

  ScrollLoopAuto({required this.images,super.key});

  @override
  Widget build(BuildContext context)
  {
    return ScrollLoopAutoScroll(
        scrollDirection: Axis.horizontal, //required
        delay: Duration(seconds: 1),
        duration: Duration(seconds: 30),
        gap: 0,
        reverseScroll: true,
        duplicateChild : 2,
        enableScrollInput : true,
        delayAfterScrollInput : Duration(seconds: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(var i=0;i<images.length;i++)

            Container(
              height: 300,
              child: Image.asset('${images[i]}' ),),


          ],
        )
    );
  }
}