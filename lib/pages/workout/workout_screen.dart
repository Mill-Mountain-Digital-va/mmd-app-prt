import 'package:protennisfitness/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:protennisfitness/elements/ExercisePreviewWidget.dart';
// import 'package:flutter_html/flutter_html.dart';
import '../../elements/ListExerciseWidget.dart';
import '../../elements/ExerciseHelpBottomSheetWidget.dart';
import '../../models/exercises.dart';
import '../../models/workout.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

import '../../generated/l10n.dart';

// ignore: must_be_immutable
class WorkoutScreen extends StatefulWidget {

  Workout? workout;

  WorkoutScreen(
      {Key? key,
      @required this.workout})
      : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool favorite = false, play = false;

  int _currentExercise = 0;

  Duration? exerciseDuration;
  Duration? breakDuration;

  int workoutTurns = 1;
  int _currentTurn = 0;

  bool _firstExercise = true;
  
  Timer? _timer;

  bool _inBreak = false;
  bool _breakIsPlaying = false;
  bool _isTurnBreak = false;
  bool _isPlaying = false;

  Duration oneSec = const Duration(seconds: 1);

  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    // set first workout turn
    _currentTurn = 1;

    _initializeExercise( );

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller!.dispose();
    _timer!.cancel();

    super.dispose();
  }

  /// TIMER FOR CURRENT EXERCISE
  void startTimer() {

    if(_firstExercise == false && widget.workout!.exercises!.elementAt( _currentExercise ).exerciseMode() != 'time') return;
    
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (exerciseDuration!.inSeconds == 0) {
          setState(() {
            _isPlaying = false;
          });
          
          if(_firstExercise == true){
            setState(() {
              timer.cancel();
              _firstExercise = false;
            });

            _initializeExercise( autoPlay: true );

          }else{
            setState(() {
              timer.cancel();
              _controller!.pause();// pause video
            });
            
            _startBreak();
          }
          
          

          // when exercise ends play break
          // _playBreak();
        } else {
          setState(() {
            //remove second to exercise duration
            exerciseDuration = Duration(seconds: exerciseDuration!.inSeconds - 1);
          });
        }
      },
    );
  }

  /// INITIALIZE BREAK
  void _startBreak(){
    setState(() {
      _inBreak = true;
      _breakIsPlaying = true;
      _isTurnBreak = false;
      breakDuration = new Duration( seconds: int.tryParse(widget.workout!.exercises!.elementAt( _currentExercise ).breakDuration!)! );
    });

    if((_currentExercise + 1) == widget.workout!.exercises!.length){
      _changeExercise('skip_break');
    }else
      _playBreak();


  }

  /// PLAY BREAK TIME
  void _playBreak(){
    print("_playBreak");
    
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (breakDuration!.inSeconds == 0) {
          // finish break
          setState(() {
            _inBreak = false;
            _breakIsPlaying = false;
            timer.cancel();
          });

          // go to next exercise
          _changeExercise('skip_break');
        } else {
          setState(() {
            //remove second to break duration
            breakDuration = Duration(seconds: breakDuration!.inSeconds - 1);
          });
        }
      },
    );
  }

  /// INITIALIZE TURN BREAK
  void _startTurnBreak() {
    print("_startTurnBreak");
    String breakAfterTurn = widget.workout!.breakAfterTurn != "" ? widget.workout!.breakAfterTurn! : "20";

    setState(() {
      _inBreak = true;
      _breakIsPlaying = true;
      _isTurnBreak = true;
      breakDuration = new Duration( seconds: int.tryParse( breakAfterTurn )! );
    });
    _playTurnBreak();
  }

  /// PLAY TURN BREAK TIME
  void _playTurnBreak(){
    print("_playBreak");
    
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (breakDuration!.inSeconds == 0) {
          // finish break
          setState(() {
            _inBreak = false;
            _breakIsPlaying = false;
            _isTurnBreak = false;
            timer.cancel();
            _currentTurn ++;
            _currentExercise = 0;
          });
          // intialize next exercise
          _initializeExercise( autoPlay: true );
        } else {
          setState(() {
            //remove second to break duration
            breakDuration = Duration(seconds: breakDuration!.inSeconds - 1);
          });
        }
      },
    );
  }
  
  /// control play pause video and timer
  void _videoPlay({bool continuePlay = false}){
    setState(() {
      // If the video is playing, pause it.
      if ((_controller!.value.isPlaying || _isPlaying) && continuePlay == false) {
        print("isPlaying");
        if(_firstExercise == false){
          _controller!.pause();
        }
        //pause timer
        _timer!.cancel();

        setState(() {
          _isPlaying = false;
        });

      } else {
        // If the video is paused, play it.
        print("play");
        if(_firstExercise == false){
          _controller!.play();
        }
        setState(() {
          _isPlaying = true;
        });
        // start timer
        startTimer();
      }
    });
  }

  /// PAUSE TIME, VISEO CONTINUE PLAYING
  void _pauseTimer() {
    if(_isPlaying){
      _timer!.cancel();

      setState(() {
        _isPlaying = false;
      });

    }
  }

  /// REPLAY TIMER, used in case on exercise help open, and if video is playing when botoom sheet is closed continue timer
  void _replayTimer(){
    setState(() {
      _isPlaying = true;
    });
    // start timer
    startTimer();
  }

  /// control play pause of break timer
  void _breakTimerPausePlay(){
    
    // If the video is playing, pause it.
    if (_breakIsPlaying) {
    
      //pause timer
      setState(() {
        _breakIsPlaying = false;
      });
      _timer!.cancel();
    } else {
      setState(() {
        _breakIsPlaying = true;
      });
      // start timer
      _playBreak();
    }
  }

  /// SKIP EXERCISE BREAK AND GO TO NEXT EXERCISE
  void _skipBreakTime({String option = "skip_break"}) {
    // CANCEL BREAK TIMER
    _timer!.cancel();

    if(option == "skip_break"){
      setState(() {
        _inBreak = false;
        _breakIsPlaying = false;
      });
    }

    // go to next exercise
    _changeExercise(option);
  }

  /// SKIP BREAK BETWEEN TURNS
  void _skipTurnBreakTime(){
    // CANCEL BREAK TIMER
    _timer!.cancel();

    setState(() {
      _inBreak = false;
      _breakIsPlaying = false;
      _isTurnBreak = false;
      _currentTurn ++;
      _currentExercise = 0;
    });
    // intialize next exercise
    _initializeExercise( autoPlay: true );
  }


  /// CHANGE CURRENT EXERCISE
  void _changeExercise(String option){
    print("****__changeExercise__****");
    print(option);
    // 
    if(_firstExercise){

      if(_timer != null && _timer!.isActive)
        _timer!.cancel();

      setState(() {
        _firstExercise = false;
      });

      _initializeExercise( autoPlay: true );

    }else if(option == 'next' || option == 'skip_break'){
      // if is on break
      if(_inBreak == false && option == 'next'){
        setState(() {
          _timer!.cancel();
          _controller!.pause();// pause video
        });
        
        _startBreak();
      }else{
        // check if current exercise is last one
        if((_currentExercise + 1) == widget.workout!.exercises!.length){

          // CHECK IF IS LAST TURN OF WORKOUT
          if(_currentTurn == workoutTurns){
            //TODO - go to complete page or workout page with success message
            Navigator.pop(context);
          }else{
            // go to next workout turn
            // play end turn break
            _timer!.cancel();
            _startTurnBreak();
            
          }
        }else{
          setState(() {
            _currentExercise ++;
          });
          // intialize next exercise
          _initializeExercise( autoPlay: true );
        }
      }
      
    }else if(option == 'previous' || option == 'previous_break'){
      // go to previous exercise
      
      // if is on break
      if(_inBreak == true && option == 'previous_break'){
        print("On break screen");
        setState(() {
          _inBreak = false;
          _breakIsPlaying = false;
        });
        // setState(() {
        //   _timer!.cancel();
        //   _controller!.pause();// pause video
        // });
        
        _initializeExercise( autoPlay: true );
        // _startBreak();
      }else{
        print("On exercise screen");
        // check if current exercise is the first one of the turn
        if(_currentExercise == 0){
          print('first exercise');
          // CHECK IF IS LAST TURN OF WORKOUT
          if(_currentTurn == 1){
            print('first turn');
            // go to initial screen
            setState(() {
              _firstExercise = true;
            });
            _initializeExercise( );
          }else{
            print('not on first turn');
            // go to next workout turn
            // play end turn break
            setState(() {
              _currentTurn--;
            });
            _startTurnBreak();
            
          }
        }else{
          print('not on first exercise');

          setState(() {
            _currentExercise --;
          });

          setState(() {
            _timer!.cancel();
            _controller!.pause();// pause video
          });
        
        _startBreak();
        }
      }
    }else{


    }
  }

  /// INITIALIZE EXERCISE
  void _initializeExercise({bool autoPlay = false }){
    print(autoPlay);
    print(widget.workout!.exercises!.elementAt( _currentExercise ).video);

    _controller = VideoPlayerController.network( widget.workout!.exercises!.elementAt( _currentExercise ).video! );// first exercise video
    _controller!.setLooping(true);

    print( _currentExercise );

    if(_firstExercise){

      exerciseDuration = new Duration(seconds: 10);

    }else{
      
      exerciseDuration = new Duration( seconds: int.tryParse(widget.workout!.exercises!.elementAt( _currentExercise ).duration!)! );

      // breakDuration = new Duration( seconds: int.tryParse(widget.workout!.exercises!.elementAt( _currentExercise ).breakDuration) );
    }

    workoutTurns = int.tryParse(widget.workout!.turns!)!;

    if(workoutTurns < 1) workoutTurns = 1;

    print("workout turns -> " + workoutTurns.toString());

    _initializeVideoPlayerFuture = _controller!.initialize();

    setState(() { });

    // if auto play is required
    if(autoPlay == true){
      _videoPlay(continuePlay: true);
    }

  }

  /// DURATION TO STRING MM:SS
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  /// RETURNS STRING OF EXERCISE REPETITIONS
  String _printRepetitions(String _repetitions) {
    return 'X ' + _repetitions;
  }

  @override
  Widget build(BuildContext context) {

    Exercise _exercise = widget.workout!.exercises!.elementAt( _currentExercise );
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: _inBreak == true || _firstExercise == true ? primaryColor : whiteColor,
      appBar: AppBar(
        backgroundColor: _inBreak == true || _firstExercise == true ? Colors.transparent : Colors.white,
        elevation: _inBreak == true || _firstExercise == true ? 0.0 : 10.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _inBreak == true || _firstExercise == true ? whiteColor : blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.workout!.title!,
          style: TextStyle(color: _inBreak == true || _firstExercise == true ? Colors.white : primaryColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: _inBreak == true || _firstExercise == true ? 
      //break screen
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightSpace,
                Center(
                  child: Text(
                    _firstExercise == true ? S.of(context).get_ready : _isTurnBreak ? S.of(context).turn_break_str : S.of(context).break_str,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Center(
                  child: Text(
                    _printDuration(_firstExercise ? exerciseDuration! : breakDuration!),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _firstExercise == true ? SizedBox(width: 60)
                       : InkWell(
                        onTap: () {
                          
                          if(_isTurnBreak == false)
                            _skipBreakTime(option: "previous_break");
                          // else
                            // _skipTurnBreakTime("previous");
                        },
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: darkBlueColor,
                            size: 26.0,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if(_firstExercise)
                            _videoPlay();
                          else
                            _breakTimerPausePlay();
                        },
                        borderRadius: BorderRadius.circular(45.0),
                        child: Container(
                          width: 90.0,
                          height: 90.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.0),
                            color: darkBlueColor,
                          ),
                          child: Icon(
                            (_breakIsPlaying) || (_firstExercise && _isPlaying) ? Icons.pause : Icons.play_arrow,
                            color: whiteColor,
                            size: 45.0,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          
                          if(_firstExercise == true)
                            _changeExercise('next');
                          else if(_isTurnBreak == false)
                            _skipBreakTime();
                          else
                            _skipTurnBreakTime();
                        },
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: darkBlueColor,
                            size: 26.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(height: 5, color: Colors.white, thickness: 1),
                SizedBox(height: 20),
                _firstExercise == true || widget.workout!.exercises!.length > _currentExercise + 1 ?
                Center(
                  child: Text(
                    "Next ...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ) : SizedBox.shrink(),
                SizedBox(height: 20),
                _firstExercise == true || widget.workout!.exercises!.length > _currentExercise + 1 ?
                // Row(
                //   children: [
                //     ListExerciseWidget(
                //       exercise: widget.workout!.exercises!.elementAt( _firstExercise == true ? _currentExercise : _currentExercise + 1 ),
                //       preview: 'video',
                //     )
                //   ],
                // )
                Row(
                  children: [
                    ExercisePreviewWidget(
                      exercise: widget.workout!.exercises!.elementAt( _firstExercise == true ? _currentExercise : _currentExercise + 1 ),
                      preview: 'video',
                    )
                  ],
                )
                : SizedBox.shrink(),
                //if last exercise from last workout turn
                widget.workout!.exercises!.length == _currentExercise + 1 ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // if last turn of workout, go to workout page 
                        if(_currentTurn >= workoutTurns){
                          Navigator.of(context).pop();
                        }else{
                          // go to next turn

                        }
                      },
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(fixPadding * 3.0, fixPadding * 1.5, fixPadding * 3.0, fixPadding * 1.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.1, 0.5, 0.9],
                            colors: [
                              Colors.green[700]!,
                              Colors.green[500]!,
                              Colors.green[300]!,
                            ],
                          ),
                        ),
                        child: Text(
                          _currentTurn == workoutTurns ? S.of(context).finish_workout.toUpperCase() : S.of(context).next_turn.toUpperCase(),
                          style: white16MediumTextStyle,
                        ),
                      ),
                    ),
                  ],
                )
                : SizedBox.shrink()
              ]
            )
          )
        ],
      )
      : // EXERCISE SCREEN 
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0),
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          // Expanded(
          //   child: Image.asset(
          //     'assets/jump-girl.png',
          //     fit: BoxFit.fitHeight,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Text(
                  _exercise.title!,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 38.0,
                    color: darkBlueColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _exercise.equipment!,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: darkBlueColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  (S.of(context).exercise + " " + (_currentExercise + 1).toString() +' of ' + widget.workout!.exercises!.length.toString()).toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: darkBlueColor,
                  ),
                ),          
                heightSpace,
                Text(
                  (S.of(context).turn + " " + (_currentTurn).toString() +' of ' + widget.workout!.turns!).toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: darkBlueColor,
                  ),
                ),
                heightSpace,
                // Html(
                //   data: _exercise.shortText,
                //   style: {
                //     "p": Style(
                //       fontSize: FontSize.large,
                //       color: darkBlueColor,
                //       textAlign: TextAlign.center
                //     ),
                //   }
                // ),
                InkWell(
                  onTap: () {
                    //_exerciseHelp();
                    var bottomSheetController;

                    _pauseTimer();

                    bottomSheetController = scaffoldKey.currentState!.showBottomSheet(
                          (context) => ExerciseHelpBottomSheetWidget(
                            scaffoldKey: scaffoldKey,
                            exercise: _exercise,
                            close: () {
                              // print("callback");
                              bottomSheetController.close();
                            },
                          ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      elevation: 10,
                    );

                    bottomSheetController.closed.then((value) {
                      print("botoom sheet closed");
                      if(_controller!.value.isPlaying){
                        _replayTimer();
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: 170.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      S.of(context).exercise_help,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ),
                ),
                heightSpace,
                heightSpace,
                Text(
                  _exercise.exerciseMode() == 'time' ? _printDuration(exerciseDuration!) : _printRepetitions(_exercise.repetitions!),
                  style: TextStyle(
                    fontSize: 38.0,
                    color: darkBlueColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                heightSpace,
                heightSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TODO ADD FEATURE FAVORITES
                      /* InkWell(
                        onTap: () {
                          setState(() {
                            favorite = !favorite;
                          });
                        },
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: darkBlueColor.withOpacity(0.2),
                          ),
                          child: Icon(
                            (favorite) ? Icons.favorite : Icons.favorite_border,
                            color: darkBlueColor,
                            size: 26.0,
                          ),
                        ),
                      ),*/
                      InkWell(
                        onTap: () {
                          _changeExercise('previous');
                        },
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: darkBlueColor.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: darkBlueColor,
                            size: 26.0,
                          ),
                        ),
                      ),
                      // SizedBox(width: 60,),
                      widget.workout!.exercises!.elementAt( _currentExercise ).exerciseMode() == 'time' ?
                      InkWell(
                        onTap: () {
                          // PLAY PAUSE EXERCISE
                          _videoPlay();
                        },
                        borderRadius: BorderRadius.circular(45.0),
                        child: Container(
                          width: 90.0,
                          height: 90.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.0),
                            color: darkBlueColor,
                          ),
                          child: Icon(
                            (_controller!.value.isPlaying || (_firstExercise && _isPlaying)) ? Icons.pause : Icons.play_arrow,
                            color: whiteColor,
                            size: 45.0,
                          ),
                        ),
                      ) : SizedBox(height: 90),
                      InkWell(
                        onTap: () {
                          _changeExercise('next');
                        },
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: darkBlueColor.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: darkBlueColor,
                            size: 26.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
