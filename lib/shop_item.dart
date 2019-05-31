import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'banner_model.dart';
import 'post.dart';
import 'progress_view.dart';
import 'styles.dart';

/**
 * Created by Maker on 2019/5/30.
 * Describe:
 */
class ShopItem extends StatelessWidget {
  final Post model;

  const ShopItem(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
//        NavigatorUtil.pushWeb(context,
//            title: model.title, url: model.link, isHome: isHome);
      },
      child: new Container(
          height: 160.0,
          padding: EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              Container(
                width: 128,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10.0),
                child:
//                  Image.network(model.imageUrl,fit: BoxFit.cover,)
                new CachedNetworkImage(
                  width: 128,
                  height: 128,
                  fit: BoxFit.fill,
                  imageUrl: model.imageUrl,
                  placeholder: (context, url) => ProgressView(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.listTitle,
                  ),
                  Gaps.vGap10,
                  new Expanded(
                    flex: 1,
                    child: new Text(
                      model.description,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.listContent,
                    ),
                  ),
                  Gaps.vGap5,
                  new Row(
                    children: <Widget>[
                      new Text(
                        "${model.author}",
                        style: TextStyles.listExtra,
                      ),
                      Gaps.hGap10,
                      new Text(
                        "${model.author}",
                        style: TextStyles.listExtra,
                      ),
                    ],
                  )
                ],
              )),
            ],
          ),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom:
                      new BorderSide(width: 0.33, color: Color(0xffe5e5e5))))),
    );
  }
}
