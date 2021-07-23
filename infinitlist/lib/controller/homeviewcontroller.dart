import 'dart:convert';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinitlist/api/api.dart';
import 'package:infinitlist/model/user.dart';

class HomeView_Controller extends GetxController {
  List<User> userList = <User>[].obs;
  Rx<int> pageNo = 1.obs;

  void _pageIncrement() {
    this.pageNo.value++;
  }

  fetchFromApi(PagingController<int, User> _pagingController) async {
    try {
      final response = await API.fetch_user_list(pageNo: pageNo.toString());
      if (response == "bad request" ||
          response == "Timeout" ||
          response == "exception") {
        _pagingController.error = "error";
      } else {
        _pageIncrement();
        List<User> _userList = User.parseList(json.decode(response));
        _pagingController.appendPage(_userList, pageNo.value);
        _userList.clear();
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void dispo() {
    this.pageNo.value = 1;
    // this.isLoading.value = false;
  }
}
