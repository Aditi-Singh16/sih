class MyUser{
  final String uid;
  final String name;
  final String type;
  final String phone;
  final String nationality;


  MyUser({
    required this.uid,
    required this.name,
    required this.phone,
    required this.nationality,
    required this.type
  });

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'phone': phone,
      'nationality': nationality,
      'type': type,
    };
  }
}