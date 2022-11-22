import 'package:flutter/material.dart';
import '../models/exercises.dart';
import 'package:video_player/video_player.dart';

import '../../constant/constants.dart';

// ignore: must_be_immutable
class ListExerciseWidget extends StatefulWidget {
  Exercise? exercise;
  String? preview;

  ListExerciseWidget({Key? key, @required this.exercise, this.preview}) : super(key: key);

    @override
  _ListExerciseWidgetState createState() => _ListExerciseWidgetState();
}

class _ListExerciseWidgetState extends State<ListExerciseWidget> {


  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    if(widget.preview == "video"){
      _controller = VideoPlayerController.network( widget.exercise!.video! );// first exercise video
      _controller!.setLooping(true);
      _initializeVideoPlayerFuture = _controller!.initialize();
      _controller!.play();
    }
    

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.

    if(widget.preview == "video"){
      _controller!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       
      },
      // borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: whiteColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 1.0,
              spreadRadius: 1.0,
              color: lightGreyColor!,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  widget.preview == 'video' ?
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the VideoPlayerController has finished initialization, use
                        // the data it provides to limit the aspect ratio of the video.
                        return AspectRatio(
                          aspectRatio: 1,//_controller.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15.0),
                              bottom: Radius.circular(15.0),
                            ),
                            child: VideoPlayer(_controller!)
                          ),
                        );
                      } else {
                        // If the VideoPlayerController is still initializing, show a
                        // loading spinner.
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )

                  : Hero(
                    tag: widget.exercise!.slug!,//['heroTag'],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.0),
                          bottom: Radius.circular(15.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(widget.exercise!.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(fixPadding * 1),
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    widget.exercise!.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: fixPadding * 1),
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    widget.exercise!.equipment!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}