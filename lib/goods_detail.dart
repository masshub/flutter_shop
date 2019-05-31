import 'package:flutter/material.dart';

import 'opacity_animation.dart';
import 'pagination.dart';

/**
 * Created by Maker on 2019/5/30.
 * Describe:
 */

class GoodsDetail extends StatefulWidget {
  @override
  _GoodsDetailState createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> {
  ScrollController _scrollController = ScrollController();
  var distance;

  final List<String> tabs = ["tab0", "tab1", "tab2"];
  TabController _controller;

  getDistance() {
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixel = _scrollController.position.pixels;
      print("maxScroll: $maxScroll,,,,,pixel:$pixel");
    });
  }

  AnimationController controller;
  Animation<double> animation;

//  void _initController() {
//    controller = AnimationController(
//      duration: Duration(milliseconds: 2000),
//      vsync: this,
//    );
//  }

  void _initAni() {
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
      });
  }

  @override
  void initState() {
    super.initState();
    getDistance();
    _controller = TabController(length: tabs.length, vsync: ScrollableState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: _sliverBuilder,
      controller: _scrollController,
      body: TabBarView(
        controller: _controller,
        children: tabs.map((f) {
          return Center(
            child: _itemBuilder(context, 50),
          );
        }).toList(),
      ),
    ));
  }

  void _control() {
    var distance = _scrollController.position;
    setState(() {
      print(distance);
    });
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        centerTitle: true,
        //标题居中
        expandedHeight: 226.0,
        //展开高度200
        floating: false,
        //不随着滑动隐藏标题
        pinned: true,
        //固定在顶部
        primary: true,
        snap: false,
        // 是否位于状态下方
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Icon(
            Icons.add_shopping_cart,
            size: 26.0,
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
        title: TabBar(
          tabs: tabs.map((f) {
            return Text(f);
          }).toList(),
          controller: _controller,
          indicatorColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorWeight: 5.0,
          labelStyle: TextStyle(height: 2),
        ),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Pagination(),
          collapseMode: CollapseMode.pin,
        ),
      ),
    ];
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('无与伦比的标题+$index'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
