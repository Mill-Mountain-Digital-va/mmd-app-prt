class UserBasic {
  String? id;
  String? gender;
  String? height;
  String? heightType;
  String? weight;
  String? weightType;
  String? fitnessLevel;
  String? age;
  // dynamic param;
  // dynamic goBackRoute;

  UserBasic();

  UserBasic.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      gender = jsonMap['gender'] != null ? jsonMap['gender'].toString() : '';
      height = jsonMap['height'] != null ? jsonMap['height'].toString() : '';
      heightType = jsonMap['height_type'] != null ? jsonMap['height_type'].toString() : 'cm';
      weight = jsonMap['weight'] != null ? jsonMap['weight'].toString() : '';
      weightType = jsonMap['weight_type'] != null ? jsonMap['weight_type'].toString() : 'kg';
      fitnessLevel = jsonMap['fitness_level'] != null ? jsonMap['fitness_level'].toString() : '';
      age = jsonMap['age'] != null ? jsonMap['age'].toString() : '';
    } catch (e) {
      id = '';
      gender = '';
      height = '';
      heightType = 'cm';
      weight = '';
      weightType = 'kg';
      fitnessLevel = '';
      age = '';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["gender"] = gender;
    map["height"] = height;
    map["height_type"] = heightType;
    map["weight"] = weight;
    map["weight_type"] = weightType;
    map["fitness_level"] = fitnessLevel;
    map["age"] = age;
    return map;
  }
}
