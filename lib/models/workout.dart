import 'category.dart';
import 'exercises.dart';

class Workout {
  String? id;
  String? categoryId;
  String? title;
  String? slug;
  String? description;
  double? price;
  String? strike;
  DateTime? startDate;
  bool? featured;
  bool? trending;
  bool? popular;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  bool? published;
  bool? free;
  DateTime? expireAt;
  String? image;

  Category? category;
  List<Exercise>? exercises;

  String? equipment;
  String? turns;

  String? breakAfterTurn;

  Workout();

  Workout.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();

      categoryId = jsonMap['category_id'] != null ? jsonMap['category_id'].toString() : '';
      title = jsonMap['title'] != null ? jsonMap['title'].toString() : '';
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      description = jsonMap['description'] != null ? jsonMap['description'].toString() : '';
      price = jsonMap['price'] != null ? double.tryParse( jsonMap['price'].toString() ) : 0.0;
      // strike = jsonMap['strike'] != null ? jsonMap['strike'].toString() : '';
      startDate = jsonMap['start_date'] != null ? DateTime.parse(jsonMap['start_date']) : null;
      
      featured = jsonMap['featured'] != null && jsonMap['featured'].toString() == "1" ? true : false;
      trending = jsonMap['trending'] != null && jsonMap['trending'].toString() == "1" ? true : false;
      popular = jsonMap['popular'] != null && jsonMap['popular'].toString() == "1" ? true : false;

      metaTitle = jsonMap['meta_title'] != null ? jsonMap['meta_title'].toString() : '';
      metaDescription = jsonMap['meta_description'] != null ? jsonMap['meta_description'].toString() : '';
      metaKeywords = jsonMap['meta_keywords'] != null ? jsonMap['meta_keywords'].toString() : '';

      
      published = jsonMap['published'] != null && jsonMap['published'].toString() == "1" ? true : false;
      free = jsonMap['free'] != null && (jsonMap['free'].toString() == "1" || jsonMap['free'] == true) ? true : false;

      expireAt = jsonMap['expire_at'] != null ? DateTime.parse(jsonMap['expire_at']) : null;
      
      image = jsonMap['image'] != null ? jsonMap['image'].toString() : '';

      
      category = jsonMap['category'] != null ? Category.fromJSON(jsonMap['category']) : new Category();

      exercises = jsonMap['published_lessons'] != null && (jsonMap['published_lessons'] as List).length > 0
          ? List.from(jsonMap['published_lessons']).map((element) => Exercise.fromJSON(element)).toList()
          : [];

      equipment = jsonMap['equipment'] != null ? jsonMap['equipment'].toString() : '';
      turns = jsonMap['turns'] != null ? jsonMap['turns'].toString() : '1';

      breakAfterTurn = jsonMap['break_after_turn'] != null ? jsonMap['break_after_turn'].toString() : '';

      
    } catch (e) {
      id = '';
      // TODO add the rest of the fields
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["image"] = image;

    return map;
  }
}
