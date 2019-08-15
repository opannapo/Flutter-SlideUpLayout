import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slideup/base/R.dart';
import 'package:slideup/entities/PropertyEntity.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem(this.entity, this.clicked);

  final PropertyEntity entity;
  final VoidCallback clicked;

  @override
  Widget build(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      width: 120,
      color: Colors.transparent,
      child: InkWell(
        onTap: clicked,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Card(
              margin: EdgeInsets.all(0),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.black,
              elevation: 5,
              child: new CachedNetworkImage(
                //imageUrl: entity.images[0].url,
                imageUrl: entity.images[0],
                fadeInDuration: Duration(milliseconds: 500),
                imageBuilder: (context, imageProvider) => new Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    "${entity.title}",
                    style: Style.textBigBold(letterSpacing: 1, color: ColorsBase.black),
                  ),
                  new Divider(
                    height: 10,
                  ),
                  new Text(
                    "Seller ${entity.seller.fullName}",
                    style: Style.textMediumBold(letterSpacing: 1, color: ColorsBase.black),
                  ),
                  new Text(
                    'Price Rp.${new NumberFormat("#,###").format(entity.price)}',
                    style: Style.textMediumBold(color: ColorsBase.black),
                  ),
                  new Divider(
                    height: 10,
                  ),
                  new Text(
                    'View ${new NumberFormat("#,###").format(entity.viewCount)}',
                    style: Style.textMedium(color: ColorsBase.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
