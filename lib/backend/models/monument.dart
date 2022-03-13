class Monument {
  String? id;
  final String desc;
  final List<dynamic> gallery;
  final String mainPic;
  final String monumentName;
  final String foreigner;
  final String category;
  final String end;
  final Map<String, dynamic> indian;
  final double lat;
  final double long;
  final String state;
  final String city;
  final String rating;
  final String operatorID;
  final String start;
  //logged in user or channel id

  Monument(
      {this.id,
      required this.desc,
      required this.gallery,
      required this.mainPic,
      required this.monumentName,
      required this.foreigner,
      required this.category,
      required this.end,
      required this.indian,
      required this.lat,
      required this.long,
      required this.state,
      required this.city,
      required this.rating,
      required this.operatorID,
      required this.start
    });

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'gallery': gallery,
      'mainPic': mainPic,
      'monumentName': monumentName,
      'foreigner': foreigner,
      'category': category,
      'end': end,
      'indian': indian,
      'lat': lat,
      'long': long,
      'state': state,
      'city': city,
      'rating': rating,
      'operatorID': operatorID,
      'start':start
    };
  }
}
