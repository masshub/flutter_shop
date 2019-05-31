import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'goods_detail.dart';
import 'pagination.dart';
import 'progress_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'shop_item.dart';
import 'post.dart';
import 'shop_list.dart';
import 'styles.dart';

/**
 * Created by Maker on 2019/5/30.
 * Describe:
 */

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController(initialRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        _topBanner(),
        _hotRecommand(),
        _buildList(),
      ],
    ));
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: posts.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _itemBuilder(context, index);
        });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
        onTap: () {
//        NavigatorUtil.pushWeb(context,
//            title: model.title, url: model.link, isHome: isHome);

        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return GoodsDetail();
        }));
        },
        child: Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Container(
              height: 140.0,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  Container(
                    width: 120.0,
                    alignment: Alignment.center,
                    child:
//                  Image.network(model.imageUrl,fit: BoxFit.cover,)
                        new CachedNetworkImage(
                      height: 120.0,
                      width: 120.0,
                      fit: BoxFit.cover,
                      imageUrl: posts[index].imageUrl,
                      placeholder: (context, url) => ProgressView(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  new Expanded(
                      child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        posts[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.listTitle,
                      ),
                      Gaps.vGap10,
                      new Expanded(
                        flex: 1,
                        child: new Text(
                          posts[index].description,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.listContent,
                        ),
                      ),
                      Gaps.vGap5,
                      Text(
                        "${posts[index].author}",
                        style: TextStyle(fontSize: 12.0, color: Colors.red),
                      ),
                    ],
                  )),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 0.33, color: Colors.transparent)),
              ),
            )));
  }

  Widget _topBanner() {
    return Column(
      children: <Widget>[
        Stack(children: <Widget>[
          Pagination(),
        ]),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _hotRecommand() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.whatshot,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "热门推荐",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
              letterSpacing: 4.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
