import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'post.dart';
import 'progress_view.dart';

/**
 * Created by Maker on 2019/6/5.
 * Describe:
 */
class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var _data = 23;
  double _money = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车",
            style: TextStyle(
              color: Colors.black,
            )),
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (_data == null) {
      return _noData();
    } else {
      return _hasData();
    }
  }

  // 空视图
  Widget _noData() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 96.0,
            color: Colors.lightBlueAccent,
          ),
          Text(
            "购物车是空的",
            style: TextStyle(fontSize: 17.0, color: Color(0xff999999)),
          ),
        ],
      ),
    );
  }

  // 有数据
  Widget _hasData() {
    return Stack(
      children: <Widget>[
        _topControl(),
        _buttomButton(),
        _content(),
      ],
    );
  }

  // 顶部控制按钮
  bool _allCheck = false;

  Widget _topControl() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  _allCheck
                      ? Icons.check_circle_outline
                      : Icons.radio_button_unchecked,
                  color: _allCheck ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  if (_allCheck) {
                    _setState();
                  } else {
                    _selecteAll();
                  }
                  _countMoney();
                  setState(() {
                    _allCheck = !_allCheck;
                  });
                },
                label: Text(
                  "全选",
                  style: TextStyle(fontSize: 14.0, color: Color(0xff333333)),
                ),
                highlightColor: Colors.transparent,
              ),
              FlatButton(
                onPressed: () {
                  _deleteItem();
                  setState(() {});
                },
                child: Text("删除",
                    style: TextStyle(fontSize: 14.0, color: Color(0xff999999))),
                highlightColor: Colors.transparent,
              ),
            ],
          ),
          Container(
            height: 8.0,
            decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                border: Border(
                    top: BorderSide(
                  width: 1.0,
                  color: Color(0xffededed),
                ))),
          ),
        ],
      ),
    );
  }

  // 底部按钮
  Widget _buttomButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xffededed), width: 0.6)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                    text: "¥",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                          text: "${_money.toString().split(".")[0]}.",
                          style: TextStyle(fontSize: 24.0, color: Colors.red)),
                      TextSpan(
                        text: "${_money.toString().split(".")[1]}",
                        style: TextStyle(fontSize: 18.0, color: Colors.red),
                      ),
                    ]),
              ),
              flex: 5,
            ),
            Expanded(
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text(
                      "结算",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  )),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      margin: EdgeInsets.only(top: 56.0, bottom: 48.0),
      child: _cartList(),
    );
  }

  // 中间购物车内容
  Widget _cartList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _cartItem(index);
      },
      itemCount: posts.length,
    );
  }

  bool _itemCheck = false;
  List<bool> _state = List();
  List<Post> _carts = posts;

  void _setState() {
    _state.clear();
    for (int i = 0; i < posts.length; i++) {
      _state.add(false);
    }
  }

  void _selecteAll() {
    _state.clear();
    for (int i = 0; i < posts.length; i++) {
      _state.add(true);
    }
  }

  Widget _cartItem(int index) {
    return Card(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              _state[index]
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked,
              color: _state[index] ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _state[index] = !_state[index];
                _countMoney();
              });
            },
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: CachedNetworkImage(
              height: 100.0,
              width: 100.0,
              fit: BoxFit.fill,
              imageUrl: posts[index].imageUrl,
              placeholder: (context, url) => ProgressView(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    _carts[index].description,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xff333333),
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: "¥",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.red,
                              ),
                              children: [
                                TextSpan(
                                    text:
                                        "${_carts[index].price.toString().split(".")[0]}.",
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.red)),
                                TextSpan(
                                  text:
                                      "${_carts[index].price.toString().split(".")[1]}",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.red),
                                ),
                              ]),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _countMoney();
                            setState(() {
                              if (_carts[index].count - 1 < 0) {
                                return;
                              } else {
                                _carts[index].count--;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '${_carts[index].count}',
                            style: TextStyle(
                                fontSize: 13.0, color: Color(0xff333333)),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              _countMoney();
                              setState(() {
                                _carts[index].count++;
                              });
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            flex: 9,
          )
        ],
      ),
    );
  }

  void _countMoney() {
    _money = 0.0;
    for (int i = 0; i < _carts.length; i++) {
      if (_state[i]) {
        _money += _carts[i].price * _carts[i].count;
      }
    }
  }


  void _deleteItem() {
    print(_state);
    for (int i = 0; i < _carts.length; i++) {
      if (_state[i]) {
        _state.removeAt(i);
        _carts.removeAt(i);
      }
    }


    _countMoney();
  }

  @override
  void initState() {
    _setState();
    super.initState();
  }
}
