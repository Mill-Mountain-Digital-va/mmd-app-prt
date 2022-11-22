class Category {
  String? id;
  String? name;
  String? slug;
  String? icon;
  String? status;
  String? image;

  Category();

  Category.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'].toString() : '';
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      icon = jsonMap['icon'] != null ? jsonMap['icon'].toString() : '';
      status = jsonMap['status'] != null ? jsonMap['status'].toString() : '';
      image = jsonMap['image_url'] != null ? jsonMap['image_url'].toString() : '';

    } catch (e) {
      id = '';
      name = '';
      slug = '';
      icon = 'cm';
      status = '';
      
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["slug"] = slug;
    map["icon"] = icon;
    map["status"] = status;
    
    return map;
  }
}
