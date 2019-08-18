import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freelane/domain/model/swimming_pool.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:freelane/ui/localization/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class SwimmingPoolWidget extends StatelessWidget {
  final SwimmingPool pool;
  final Color foregroundColor;

  SwimmingPoolWidget(this.pool, this.foregroundColor);

  @override
  Widget build(BuildContext context) {
    var imageHeight = 140.0;
    return InkWell(
      onTap: () => _launchUrl(pool.url),
      child: Stack(children: <Widget>[
        CachedNetworkImage(
            imageUrl: pool.coverImageUrl,
            height: imageHeight,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(color: Colors.black12, height: imageHeight)),
        Container(
          height: imageHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                  colors: [
                foregroundColor.withOpacity(0.8),
                foregroundColor.withOpacity(0.5)
              ])),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(pool.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "${Strings.of(context).people}: ${pool.peopleCount.people}",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                            children: _peopleIcons(pool.peopleCount.people)))
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  List<Widget> _peopleIcons(int peopleCount) {
    if (peopleCount < 5) {
      return new List<Widget>();
    } else {
      return List.generate(min((peopleCount / 15).ceil(), 15),
          (i) => new Icon(Icons.person, size: 14, color: Colors.white));
    }
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
