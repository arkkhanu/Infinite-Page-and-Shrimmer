import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinitlist/controller/homeviewcontroller.dart';
import 'package:infinitlist/model/user.dart';

class POView extends StatefulWidget {
  POView({Key? key}) : super(key: key);

  @override
  _POViewState createState() => _POViewState();
}

class _POViewState extends State<POView> {
  ScrollController _scrollController = ScrollController();
  HomeView_Controller _homeView_Controller = Get.put(HomeView_Controller());
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _homeView_Controller.fetchFromApi(_pagingController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List"),
      ),
      body: PagedListView<int, User>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<User>(
          noItemsFoundIndicatorBuilder: (context) => Container(
            color: Colors.blue,
            child: Text("No"),
          ),
          itemBuilder: (context, item, index) {
            return _cardView(item);
          },
        ),
      ),
      // body: Container(color: Colors.green, child: _buildBody()),
    );
  }

  Widget _cardView(User user) {
    return Container(
      height: 100,
      child: GestureDetector(
        onTap: () {
          print("User is:" + user.title.toString());
          print("ID is:" + user.id.toString());
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _singleText("Name", user.title.toString().substring(0, 10)),
                _singleText("Id", user.id.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleText(String title, String value) {
    return Column(
      children: [
        Text(title),
        Text(value),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pagingController.dispose();
    super.dispose();
  }
}
