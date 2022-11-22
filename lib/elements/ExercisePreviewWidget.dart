import 'package:flutter/material.dart';
import '../models/exercises.dart';
import 'package:video_player/video_player.dart';

import '../../constant/constants.dart';

// ignore: must_be_immutable
class ExercisePreviewWidget extends StatefulWidget {
  Exercise? exercise;
  String? preview;

  ExercisePreviewWidget({Key? key, @required this.exercise, this.preview}) : super(key: key);

    @override
  _ExercisePreviewWidgetState createState() => _ExercisePreviewWidgetState();
}

class _ExercisePreviewWidgetState extends State<ExercisePreviewWidget> {


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
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 100.0,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15.0),
      //   color: whiteColor,
      //   boxShadow: <BoxShadow>[
      //     BoxShadow(
      //       blurRadius: 1.0,
      //       spreadRadius: 1.0,
      //       color: lightGreyColor!,
      //     ),
      //   ],
      // ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 1),
            width: MediaQuery.of(context).size.width - 50,
            child: Center(
              child: Text(
                widget.exercise!.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22, color: whiteColor, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: fixPadding * 1),
          //   width: MediaQuery.of(context).size.width - 150,
          //   child: Text(
          //     widget.exercise!.equipment!,
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(fontSize: 14, color: Colors.black),
          //   ),
          // )
          Container(
            padding: EdgeInsets.symmetric(horizontal: fixPadding * 1),
            width: MediaQuery.of(context).size.width - 50,
            child: Center(
              child: Text(
                widget.exercise!.exerciseMode() == 'time' ? widget.exercise!.printDuration() : widget.exercise!.printRepetitions(),
                style: TextStyle(
                  fontSize: 22.0,
                  color: whiteColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller!),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Container(
                  margin: EdgeInsets.only(top: 30),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      )
    );
  }
}