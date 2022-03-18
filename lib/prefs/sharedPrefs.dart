import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  final idKey = 'this_user_id';
  final userNameKey = 'this_user_fName';
  final phoneNumberKey = 'this_user_phone';
  final userTypeKey = 'this_user_type';
  final monumentIdKey = 'this_mon_id';
  final monumentNameKey = 'this_monName_key';

  Future<void> setUserIdPref(String? id) async {
    final prefs = await SharedPreferences.getInstance();

    if (id == null) {
      prefs.setString(idKey, '0');
    }
    prefs.setString(idKey, id!);
  }

  Future<void> setUserNamePref(String? userName) async {
    final prefs = await SharedPreferences.getInstance();

    if (userName == null) {
      prefs.setString(userNameKey, '');
    }
    prefs.setString(userNameKey, userName!);
  }

  Future<void> setMonNamePref(String? monName) async {
    final prefs = await SharedPreferences.getInstance();

    if (monName == null) {
      prefs.setString(monumentNameKey, '');
    }
    prefs.setString(monumentNameKey, monName!);
  }

  Future<void> setUserPhoneNoPref(String? phone) async {
    final prefs = await SharedPreferences.getInstance();

    if (phone == null) {
      prefs.setString(phoneNumberKey, '0');
    }
    prefs.setString(phoneNumberKey, phone!);
  }

  Future<void> setUserType(String? userType) async {
    final prefs = await SharedPreferences.getInstance();

    if (userType == null) {
      prefs.setString(userTypeKey, '');
    }
    prefs.setString(userTypeKey, userType!);
  }

  Future<void> setMonumentIdPref(String? monid) async {
    final prefs = await SharedPreferences.getInstance();

    if (monid == null) {
      prefs.setString(monumentIdKey, '0');
    }
    prefs.setString(monumentIdKey, monid!);
  }

  Future<String> readUserIdPref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('this_user_id') ?? '0';
  }

  Future<String> readMonumentIdPref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('this_mon_id') ?? '0';
  }

  Future<String> readUserPhonePref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('this_user_phone') ?? '0';
  }

  Future<String> readUserNamePref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('this_user_fName') ?? '';
  }

  Future<String> readMonumentNamePref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('this_monName_key') ?? '';
  }

  readUserTypePref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('this_user_type') ?? '';
  }
}
