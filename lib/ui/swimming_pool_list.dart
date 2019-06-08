import 'package:flutter/material.dart';
import 'package:freelane/data/rest_api.dart';
import 'package:freelane/data/swimming_pool_repo.dart';
import 'package:freelane/domain/model/swimming_pool.dart';
import 'package:freelane/ui/widget/opening_hours_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SwimmingPoolsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SwimmingPoolsState();
  }
}

class SwimmingPoolsState extends State<SwimmingPoolsWidget> {
  final SwimmingPoolRepository repository = SwimmingPoolRepository(RestApi());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Free Lane pools"),
        ),
        body: FutureBuilder<List<SwimmingPool>>(
            future: repository.getSwimmingPools(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                          child: Text("Failed to load pools ${snapshot.error}",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.red))));
                }

                var pools = snapshot.data;
                final ThemeData theme = Theme.of(context);
                return ListView.builder(
                    itemCount: pools.length,
                    itemBuilder: (BuildContext context, int index) {
                      var pool = pools[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () => _launchUrl(pool.url),
                              child: CachedNetworkImage(
                                  imageUrl: pool.coverImageUrl,
                                  placeholder: (context, url) => Container(
                                        color: Colors.black12,
                                        height: 100,
                                      )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(pool.name, style: theme.textTheme.title),
                                  Text("People: ${pool.peopleCount.people}")
                                ],
                              ),
                            ),
                            ExpandingOpeningHours(pool.openingHours),
                          ],
                        ),
                      );
                    });
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
