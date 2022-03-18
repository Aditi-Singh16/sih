class TicketChecker {
  final String monumentID;
  final String monument_name;
  final String operatorName;
  final String type;
  final String name;
  final String age;
  final String gender;
  final String nationality;
  final String email;
  final String phone_no;

  TicketChecker({
    required this.monumentID,
    required this.monument_name,
    required this.operatorName,
    required this.type,
    required this.name,
    required this.age,
    required this.gender,
    required this.nationality,
    required this.email,
    required this.phone_no,
  });

  Map<String, dynamic> toMap() {
    return {
      'monumentID': monumentID,
      'monument_name': monument_name,
      'operator_name':operatorName,
      'name': name,
      'age': age,
      'gender': gender,
      'nationality': nationality,
      'email': email,
      'phone': phone_no,
      'type': type
    };
  }
}
