class Exercise {

  String? id;
  String? title;
  String? slug;
  String? lessonImage;
  String? shortText;
  String? fullText;
  double? position;
  bool? free;
  bool? published;

  String? image;
  String? video;

  String? duration;
  String? breakDuration;
  String? equipment;
  String? repetitions;
  
  Exercise();

  Exercise.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      title = jsonMap['title'] != null ? jsonMap['title'].toString() : '';
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      lessonImage = jsonMap['lesson_image'] != null ? jsonMap['lesson_image'].toString() : '';
      shortText = jsonMap['short_text'] != null ? jsonMap['short_text'].toString() : '';

      shortText = jsonMap['short_text'] != null ? jsonMap['short_text'].toString() : '';
      fullText = jsonMap['full_text'] != null ? jsonMap['full_text'].toString() : '';
      position = jsonMap['position'] != null ? double.tryParse(jsonMap['position'].toString()) : 0;
      free = jsonMap['free_lesson'] != null && jsonMap['free_lesson'].toString() == "1" ? true : false;
      published = jsonMap['published'] != null && jsonMap['published'].toString() == "1" ? true : false;

      image = jsonMap['image'] != null ? jsonMap['image'].toString() : '';
      video = jsonMap['video'] != null ? jsonMap['video'].toString() : '';

      duration = jsonMap['duration'] != null ? jsonMap['duration'].toString() : '';

      breakDuration = jsonMap['break_duration'] != null ? jsonMap['break_duration'].toString() : '';

      equipment = jsonMap['equipment'] != null ? jsonMap['equipment'].toString() : '';
      repetitions = jsonMap['repetitions'] != null ? jsonMap['repetitions'].toString() : '';

    } catch (e) {
      id = '';
      title = '';
      slug = '';
      
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["slug"] = slug;
    
    return map;
  }

  String exerciseMode () {
    String mode = "time";

    if((duration == '' || duration == "0") && repetitions != '' && repetitions != "0")
      mode = "repetitions";

    return mode;
  }

  /// DURATION TO STRING MM:SS
  String printDuration() {
    Duration _duration = new Duration( seconds: int.tryParse(duration!)! );

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(_duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  /// RETURNS STRING OF EXERCISE REPETITIONS
  String printRepetitions() {
    return 'X ' + repetitions!;
  }

}
