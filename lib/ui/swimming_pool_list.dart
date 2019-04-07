import 'package:flutter/material.dart';
import 'package:freelane/data/rest_api.dart';
import 'package:freelane/data/swimming_pool_repo.dart';
import 'package:freelane/domain/model/swimming_pool.dart';
import 'package:url_launcher/url_launcher.dart';

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
                return ListView.builder(
                    itemCount: pools.length,
                    itemBuilder: (BuildContext context, int index) {
                      var pool = pools[index];
                      return ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(pool.name),
                        subtitle: Text(pool.url),
                        trailing: Text(pool.peopleCount.people.toString()),
                        onTap: () => _launchUrl(pool.url),
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
