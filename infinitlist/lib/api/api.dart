import 'dart:async';
import 'package:http/http.dart' as http;

class API {
  static Future<String> fetch_user_list({required String pageNo}) async {
    try {
      final response = await http
          .get(Uri.parse(
              "https://jsonplaceholder.typicode.com/photos?_page=$pageNo"))
          .timeout(Duration(seconds: 60));
      if (response.statusCode == 200) {
        // print("Body:" + response.body.toString());
        return response.body;
      } else {
        print("Bad request");
        return "bad request";
      }
    } on TimeoutException {
      print("Timeout");
      return "Timeout";
    } catch (e) {
      print("exception");
      return "exception";
    }
  }

  static Future<String> fetch_user_list1() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"))
          .timeout(Duration(seconds: 60));
      if (response.statusCode == 200) {
        // print("Body:" + response.body.toString());
        return response.body;
      } else {
        print("Bad request");
        return "bad request";
      }
    } on TimeoutException {
      print("Timeout");
      return "Timeout";
    } catch (e) {
      print("exception");
      return "exception";
    }
  }
}
