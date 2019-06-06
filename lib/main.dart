import 'package:flutter/material.dart';

import 'goods_indroduce.dart';
import 'shop_list.dart';
import 'shop_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopPage(),
//    home: GoodsIntroduce(),
    );
  }
}

