import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinitlist/controller/homeviewcontroller.dart';
import 'package:infinitlist/model/user.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
          firstPageProgressIndicatorBuilder: (context) => Container(
            height: Get.height,
            child: _loadingList(),
          ),
          firstPageErrorIndicatorBuilder: (context) => _loadingList(),
          noItemsFoundIndicatorBuilder: (context) => Container(
            color: Colors.blue,
            child: Text("No"),
          ),
          itemBuilder: (context, item, index) {
            return _cardView(item);
          },
        ),
      ),
    );
  }

  Widget _loadingList() {
    return Container(
        child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: 15,
      ),
    ));
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
