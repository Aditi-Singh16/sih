import 'package:http/http.dart' as http;

class GetNumberOfPeople {
  var baseUrl = 'https://prediction-model-api.herokuapp.com/crowdPrediction';

  Future<List<int>> fetchCrowdNumber(String city, int dayOfWeek) async {
    List<int> hrs = [9, 10, 11, 12, 13, 14, 15, 16, 17];
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    List<int> res = [];
    for (int i = 0; i < hrs.length; i++) {
      String dayWhole = DateTime(year, month, day, hrs[i], 0).toString();
      final response = await http.get(Uri.parse(baseUrl +
          '?city=' +
          city +
          '&dayWhole=' +
          dayWhole +
          '&dayOfWeek=' +
          dayOfWeek.toString()));
      res.add((double.parse(response.body)).toInt());
    }
    return res;
  }
}
