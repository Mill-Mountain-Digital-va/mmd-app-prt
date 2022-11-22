class RouteArgument {
  String? id;
  String? heroTag;
  dynamic param;
  dynamic goBackRoute;

  RouteArgument({this.id, this.heroTag, this.param, this.goBackRoute});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
