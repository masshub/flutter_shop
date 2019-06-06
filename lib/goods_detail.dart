import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'data_table_demo.dart';
import 'opacity_animation.dart';
import 'pagination.dart';
import 'package:binding_helper/binding_helper.dart';

import 'post.dart';
import 'progress_view.dart';
import 'rating_bar.dart';
import 'shopping_cart.dart';
import 'styles.dart';

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
  final List<String> tabs = ["商品", "评价", "详情"];
  List<Widget> _content;

  // 顶部tab透明度
  double _tabOpacity = 0.0;

  getDistance() {
    _scrollController.addListener(() {
      var pixel = _scrollController.position.pixels;
      print("滑动位置pixel:$pixel;;;;;滑动位置：${_scrollController.positions}");
      if (pixel <= 0.0) {
        _tabOpacity = 0.0;
      } else if (pixel >= 196.0) {
        _tabOpacity = 1.0;
      } else {
        _tabOpacity = pixel / 196.0;
      }
      if (pixel <= 148.0 + _rect2.height) {
        _offState = true;
        _tab0 = Colors.white;
        _side0 = Colors.white;
        _tab1 = Colors.white70;
        _side1 = Colors.transparent;
        _tab2 = Colors.white70;
        _side2 = Colors.transparent;
      } else if (pixel >= 148.0 + _rect2.height + _rect1.height) {
        _offState = false;
        _tab2 = Colors.white;
        _side2 = Colors.white;
        _tab1 = Colors.white70;
        _side1 = Colors.transparent;
        _tab0 = Colors.white70;
        _side0 = Colors.transparent;
      } else {
        _offState = false;
        _tab1 = Colors.white;
        _side1 = Colors.white;
        _tab0 = Colors.white70;
        _side0 = Colors.transparent;
        _tab2 = Colors.white70;
        _side2 = Colors.transparent;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _content = [_goods(), _evaluate(), _detail()];
    getDistance();
  }

  Rect _rect0;
  Rect _rect1;
  Rect _rect2;
  bool _offState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            _sliverAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _itemBuilder(context, index);
                },
                childCount: _content.length,
                addAutomaticKeepAlives: true,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 48.0,
            child: _bottomButtons(),
          ),
        ),
        Positioned(
          child: Offstage(
            offstage: _offState,
            child: Container(
              height: 26.0,
              width: 26.0,
              child: FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(0.0,
                      duration: Duration(seconds: 1), curve: Curves.ease);
                },
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.keyboard_arrow_up,color: Colors.white),
                mini: true,
              ),
            ),
          ),
          right: 16.0,
          bottom: 68.0,
        ),
        _addShoppingCart(),
      ],
    ));
  }

  int _count = 0;

  bool _shoppingOffstage = true;

  Widget _addShoppingCart() {
    return Offstage(
      offstage: _shoppingOffstage,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black54,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.white70,
                      onPressed: () {
                        setState(() {
                          _shoppingOffstage = true;
                          _count = 0;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 140.0,
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                            imageUrl: posts[0].imageUrl,
                            placeholder: (context, url) => ProgressView(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "中策轮胎 12R22.5-18PR eS88",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.0, color: Color(0xff333333)),
                            ),
                            Gaps.vGap10,
                            Expanded(
                              flex: 1,
                              child: Text(
                                "全新正品 官方授权 全国包安装 全新",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xff999999)),
                              ),
                            ),
                            Gaps.vGap5,
                            RichText(
                              text: TextSpan(
                                  text: "¥",
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.red),
                                  children: [
                                    TextSpan(
                                      text: "1550.",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.red),
                                    ),
                                    TextSpan(
                                      text: "00",
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.red),
                                    ),
                                  ]),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 1.0,
                    child: Container(
                      margin: EdgeInsets.only(left: 16.0),
                      color: Color(0xffededed),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "购买数量",
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xff333333)),
                          ),
                          flex: 8,
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_count - 1 < 0) {
                                  return;
                                } else {
                                  _count--;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.black,
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text(
                              '${_count}',
                              style: TextStyle(
                                  fontSize: 17.0, color: Color(0xff333333)),
                              maxLines: 1,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _count++;
                                });
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.black,
                              )),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      setState(() {
                        _shoppingOffstage = true;
                        _count = 0;
                      });
                    },
                    child: Container(
                      height: 48.0,
                      alignment: Alignment.center,
                      child: Text("确定",
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return DataTableDemo();
                }));

              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 16.0,
                    width: 16.0,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.phone,
                        size: 12.0,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Text(
                    "客服",
                    style: TextStyle(fontSize: 13.0, color: Color(0xff666666)),
                  )
                ],
              )),
          flex: 3,
        ),
        Container(
          width: 1.0,
          color: Color(0xffededed),
        ),
        Expanded(
          child: MaterialButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return ShoppingCart();
                }));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 20.0,
                    color: Colors.grey,
                  ),
                  Text(
                    "购物车",
                    style: TextStyle(fontSize: 13.0, color: Color(0xff666666)),
                  )
                ],
              )),
          flex: 3,
        ),
        Expanded(
          child: FlatButton(
            color: Colors.orange,
            onPressed: () {
              setState(() {
                _shoppingOffstage = false;
                _count = 0;
              });
            },
            child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "加入购物车",
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                )),
          ),
          flex: 5,
        ),
        Expanded(
          child: FlatButton(
              color: Colors.red,
              onPressed: () {
                setState(() {
                  _shoppingOffstage = false;
                  _count = 0;
                });
              },
              child: Container(
                  height: double.infinity,
//                  width: double.infinity,
                  alignment: Alignment.center,
//                  color: Colors.red,
                  child: Text(
                    "立即购买",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ))),
          flex: 5,
        ),
      ],
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      centerTitle: true,
      //标题居中
      expandedHeight: 202.0,
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
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return ShoppingCart();
            }));
          },
          child: Icon(
            Icons.add_shopping_cart,
            size: 26.0,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
      ],
      title: _topTab(),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Pagination(),
        collapseMode: CollapseMode.pin,
      ),
    );
  }

  Color _tab0 = Colors.red;
  Color _side0 = Colors.red;
  Color _tab1 = Colors.transparent;
  Color _side1 = Colors.white;
  Color _tab2 = Colors.white;
  Color _side2 = Colors.transparent;

  Widget _topTab() {
    return Opacity(
        opacity: _tabOpacity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (_tabOpacity == 1.0) {
                        _scrollController.animateTo(0.0,
                            duration: Duration(seconds: 1), curve: Curves.ease);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: _side0, width: 2.0),
                      )),
                      child: Text(
                        tabs[0],
                        style: TextStyle(color: _tab0, fontSize: 16.0),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_tabOpacity == 1.0) {
                        _scrollController.animateTo(_rect2.height + 150.0,
                            duration: Duration(seconds: 1), curve: Curves.ease);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: _side1, width: 2.0),
                      )),
                      child: Text(
                        tabs[1],
                        style: TextStyle(color: _tab1, fontSize: 16.0),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_tabOpacity == 1.0) {
                        _scrollController.animateTo(
                            _rect2.height + _rect1.height + 150.0,
                            duration: Duration(seconds: 1),
                            curve: Curves.ease);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: _side2, width: 2.0),
                      )),
                      child: Text(
                        tabs[2],
                        style: TextStyle(color: _tab2, fontSize: 16.0),
                      ),
                    ),
                  ),
                ])
          ],
        ));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return _content[index];
  }

  Widget _goods() {
    return RectProvider(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: RichText(
                text: TextSpan(
                    text: "¥",
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                    children: [
                      TextSpan(
                          text: "1550.",
                          style: TextStyle(fontSize: 28.0, color: Colors.red)),
                      TextSpan(
                          text: "00",
                          style: TextStyle(fontSize: 18.0, color: Colors.red)),
                      TextSpan(
                          text: "     ",
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.white)),
                      TextSpan(
                          text: "原价：¥1560",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff999999),
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Color(0xff999999))),
                    ]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                "中策轮胎 12R22.5-18PR eS88",
                style: TextStyle(fontSize: 18.0, color: Color(0xff333333)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Text(
                "全新正品 官方授权 全国包安装 全新正品 官方授权 全国包安装 全新正品 官方授权 全国包安装",
                style: TextStyle(fontSize: 14.0, color: Color(0xff999999)),
              ),
            ),
            Container(
              height: 4.0,
              width: double.infinity,
              color: Color(0xfff7f7f7),
            ),
            ListTile(
              title: Text(
                "参数",
                style: TextStyle(fontSize: 13.0, color: Color(0xff666666)),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 20.0,
                color: Colors.red,
              ),
              onTap: () {
                _showParameters(context);
              },
            ),
            Container(
              height: 4.0,
              width: double.infinity,
              color: Color(0xfff7f7f7),
            ),
          ],
        ),
        onGetRect: (r) {
          setState(() {
            _rect2 = r;
          });
        });
  }

  // 参数
  void _showParameters(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 14.0, color: Colors.red),
                      )),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "产品参数",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    flex: 10,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(fontSize: 14.0, color: Colors.red),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 46.0),
                height: 1.0,
                color: Color(0xffe4e4e4),
              ),
              Container(
                margin: EdgeInsets.only(top: 47.0),
                child: _ParamsList(),
              ),
            ],
          );
        });
  }

  List<String> _paramsTitle = ["品牌", "型号", "适合发动机", "净含量", "机油分类", "粘度级别"];
  List<String> _paramsContent = ["美孚", "力霸", "汽油发动机", "4L", "全合成", "15W-40"];

  Widget _ParamsList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _paramsItem(index);
      },
      itemCount: _paramsTitle.length,
      itemExtent: 48.0,
    );
  }

  Widget _paramsItem(int index) {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
      ),
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _paramsTitle[index],
              style: TextStyle(fontSize: 14.0, color: Color(0xff999999)),
            ),
            flex: 1,
          ),
          Expanded(
            child: Text(
              _paramsContent[index],
              style: TextStyle(fontSize: 14.0, color: Color(0xff333333)),
            ),
            flex: 3,
          ),
        ],
      ),
      decoration: BoxDecoration(
          // ignore: unrelated_type_equality_checks
          border: Border(
              bottom: BorderSide(
                  color: index == _paramsTitle
                      ? Colors.transparent
                      : Color(0xffe4e4e4),
                  width: 1.0))),
    );
  }

  Widget _evaluate() {
    return RectProvider(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "商品评价（13）",
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xff333333)),
                    ),
                    flex: 4,
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "查看全部评价",
                            style: TextStyle(fontSize: 14.0, color: Colors.red),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 24.0,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
            Container(
              height: 1.0,
              margin: EdgeInsets.only(left: 16.0),
              color: Color(0xffe4e4e4),
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://resources.ninghao.org/images/candy-shop.jpg",
                      scale: 0.8)),
              title: Text(
                "185****8422",
                style: TextStyle(fontSize: 18.0, color: Color(0xff333333)),
              ),
              trailing: Text(
                "2018-9-30 14:05",
                style: TextStyle(fontSize: 13.0, color: Color(0xff999999)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text("黏度太高了。小马力车不建议用。转速起来很慢 油门反应慢。这是我淘宝购物来让我最满意的一次购物。",
                  style: TextStyle(fontSize: 14.0, color: Color(0xff333333))),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: _buildGridView(),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0,top: 8.0,bottom: 8.0),
              child: RatingBar(
                clickable: false,
                size: 26,
                color: Colors.red,
                padding: 10,
                value: 4.5,
              ),
            ),
            Container(
              height: 4.0,
              width: double.infinity,
              color: Color(0xfff7f7f7),
            ),
          ],
        ),
        onGetRect: (r) {
          setState(() {
            _rect1 = r;
          });
        });
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 1.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildGridItem(index);
      },
      itemCount: 5,
    );
  }

  Widget _buildGridItem(int index) {
    return Image.network(
      posts[index].imageUrl,
      scale: 0.6,
      fit: BoxFit.fill,
    );
  }

  Widget _detail() {
    return RectProvider(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Text(
                "商品详情",
                style: TextStyle(fontSize: 14.0, color: Color(0xff333333)),
                textAlign: TextAlign.start,
              ),
            ),
            Image.asset(
              "assets/images/screen.jpg",
              fit: BoxFit.fitWidth,
              filterQuality: FilterQuality.high,
            ),

            SizedBox(height: 48.0,),
          ],
        ),
        onGetRect: (r) {
          setState(() {
            _rect0 = r;
          });
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
