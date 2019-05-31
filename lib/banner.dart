import 'dart:async';

import 'package:flutter/material.dart';

import 'banner_model.dart';

/**
 * Created by Maker on 2019/5/29.
 * Describe:
 */

class TopBanner extends StatefulWidget {
  final List<BannerModel> banners;
  final OnTapBannerItem onTap;

  const TopBanner(this.banners, this.onTap, {Key, key}) : super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<TopBanner> {
  int virtualIndex = 0;
  int realIndex = 1;
  PageController controller;
  Timer timer;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: realIndex);
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      // 自动滚动
      /// print(realIndex);
      controller.animateToPage(realIndex + 1,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 226.0,
          child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            PageView(
              controller: controller,
              onPageChanged: _onPageChanged,
              children: _buildItems(),
            ),
            _buildIndicator(), // 下面的小点
            Positioned(
              child: _numberIndicator(),
              right: 10.0,
              top: 10.0,
            ),
          ]),
        ),
      ],
    );
  }

  List<Widget> _buildItems() {
    // 排列轮播数组
    List<Widget> items = [];
    if (widget.banners.length > 0) {
      // 头部添加一个尾部Item，模拟循环
      items.add(_buildItem(widget.banners[widget.banners.length - 1]));
      // 正常添加Item
      items.addAll(widget.banners
          .map((story) => _buildItem(story))
          .toList(growable: false));
      // 尾部
      items.add(_buildItem(widget.banners[0]));
    }
    return items;
  }

  Widget _buildItem(BannerModel banner) {
    return GestureDetector(
      onTap: () {
        // 按下
        if (widget.onTap != null) {
          widget.onTap(banner);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(banner.imagePath, fit: BoxFit.cover),
//          _buildItemTitle(banner.title), // 内容文字,大意
        ],
      ),
    );
  }

  /// 文字标题
  Widget _buildItemTitle(String title) {
    return Container(
      decoration: BoxDecoration(
        /// 背景的渐变色
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: const Alignment(0.0, -0.8),
          colors: [const Color(0xa0000000), Colors.transparent],
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }

  /// 右上角数字指示器
  Widget _numberIndicator() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text(
        "${++virtualIndex}/${widget.banners.length}",
        style: TextStyle(color: Colors.white, fontSize: 11.0),
      ),
    );
  }

  /// 正下方中间圆点指示器
  Widget _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.banners.length; i++) {
      indicators.add(Container(
          width: 6.0,
          height: 6.0,
          margin: EdgeInsets.symmetric(horizontal: 1.5, vertical: 10.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == virtualIndex ? Colors.white : Colors.grey)));
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: indicators);
  }

  _onPageChanged(int index) {
    realIndex = index;
    int count = widget.banners.length;
    if (index == 0) {
      virtualIndex = count - 1;
      controller.jumpToPage(count);
    } else if (index == count + 1) {
      virtualIndex = 0;
      controller.jumpToPage(1);
    } else {
      virtualIndex = index - 1;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    timer.cancel();
  }
}

typedef void OnTapBannerItem(BannerModel banner);
