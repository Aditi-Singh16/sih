class TicketChecker{
  final String id;
  final String type;
  final String name;
  final String age;
  final String gender;
  final String nationality;
  final String email;
  final String phone_no;




  TicketChecker( {
    required this.id,
    required this.type,
    required this.name,
      required this.age,
    required this.gender,
    required this.nationality,
    required this.email,
    required this.phone_no,
  });

  Map<String,dynamic> toMap() {
    return {
      'id':id,
      'name':name,
      'age':age,
      'gender':gender,
      'nationality':nationality,
      'email':email,
      'phone_no':phone_no,
      'type':type
    };
  }

}