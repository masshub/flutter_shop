import 'package:flutter/material.dart';

/**
 * Created by Maker on 2019/6/3.
 * Describe:
 */
class GoodsIntroduce extends StatelessWidget {
  final GlobalKey globalKey = GlobalKey();
  final GlobalKey globalKey0 = GlobalKey();

  getHeight() {
    final double height = globalKey.currentContext.size.height;
    final double height0 = globalKey0.currentContext.size.height;
    print("height：$height &&^&&&&$height0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("test"),
        ),
        body: Column(
          children: <Widget>[
            _container(),
            Container(
              key: globalKey0,
              color: Colors.blue,
              height: 100.0,
              child: FlatButton(
                onPressed: () {
                  getHeight();
                },
                child: Text("商品1"),
              ),
            ),
          ],
        ));
  }

  Widget _container() {
    return Container(
      key: globalKey,
      color: Colors.blue,
      height: 300.0,
      child: FlatButton(
        onPressed: () {
          getHeight();
        },
        child: Text("商品"),
      ),
    );
  }
}
