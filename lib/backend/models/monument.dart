class Monument{
  final String desc;
  final List<dynamic> gallery;
  final String mainPic;
  final String monumentName;//logged in user or channel id

  Monument({
    required this.desc,
    required this.gallery,
    required this.mainPic,
    required this.monumentName
  });

  Map<String,dynamic> toMap() {
    return {
      'desc':desc,
      'gallery':gallery,
      'mainPic':mainPic,
      'monumentName':monumentName
    };
  }

}