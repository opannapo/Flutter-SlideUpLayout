import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slideup/base/R.dart';
import 'package:slideup/entities/PropertyEntity.dart';


class SuggestedItem extends StatelessWidget {
  const SuggestedItem(this.entity, this.clicked);

  final PropertyEntity entity;
  final VoidCallback clicked;

  @override
  Widget build(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      width: 250,
      color: Colors.transparent,
      child: InkWell(
        onTap: clicked,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Card(
              margin: EdgeInsets.all(0),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.black,
              elevation: 10,
              child: new CachedNetworkImage(
                //imageUrl: entity.images[0].url,
                imageUrl: entity.images[0],
                fadeInDuration: Duration(milliseconds: 500),
                imageBuilder: (context, imageProvider) => new Container(
                  width: 250,
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new Container(
                    padding: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.1, 0.7, 1.0],
                        colors: [
                          const Color(0x00000000),
                          const Color(0xAA000000),
                          const Color(0xEE000000),
                        ],
                      ),
                    ),
                    child: new Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              entity.title ?? '-',
                              style: Style.textMediumBold(color: ColorsBase.white),
                            ),
                            new Row(
                              children: <Widget>[
                                new Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.fromLTRB(0, 4, 5, 0),
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: ColorsBase.base, width: 1),
                                    image: new DecorationImage(
                                      image: new NetworkImage(entity.seller.imageProfile),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      entity.seller.fullName ?? '-',
                                      style: Style.textMediumBold(color: ColorsBase.whiteDisable),
                                    ),
                                    new Text(
                                      'Rp.${new NumberFormat("#,###").format(entity.price)}',
                                      style: Style.textMediumBold(color: ColorsBase.whiteDisable),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
