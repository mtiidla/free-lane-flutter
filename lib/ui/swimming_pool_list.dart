import 'package:flutter/material.dart';
import 'package:freelane/data/swimming_pool_repo.dart';
import 'package:freelane/domain/model/swimming_pool.dart';
import 'package:freelane/ui/widget/opening_hours_widget.dart';
import 'package:freelane/ui/widget/swimming_pool_widget.dart';

import 'localization/strings.dart';

class SwimmingPoolsWidget extends StatefulWidget {

  final SwimmingPoolRepository repository;

  SwimmingPoolsWidget(this.repository);

  @override
  State<StatefulWidget> createState() {
    return SwimmingPoolsState(repository);
  }
}

class SwimmingPoolsState extends State<SwimmingPoolsWidget> {
  final SwimmingPoolRepository repository;

  SwimmingPoolsState(this.repository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.of(context).homeScreenTitle,
              style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
        ),
        body: FutureBuilder<List<SwimmingPool>>(
            future: repository.getSwimmingPools(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                          child: Text("Failed to load pools ${snapshot.error}",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.red))));
                }
                return SwimmingPoolList(snapshot.data);
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }
}

class SwimmingPoolList extends StatelessWidget {
  final List<SwimmingPool> pools;
  final List<Color> colors = [
    Colors.indigo,
    Colors.orange,
    Colors.cyan,
    Colors.deepOrange,
    Colors.green,
    Colors.purple,
    Colors.teal
  ];

  SwimmingPoolList(this.pools);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: pools.length,
        itemBuilder: (BuildContext context, int index) {
          var pool = pools[index];
          bool isLast = index == (pools.length - 1);
          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            margin: isLast
                ? EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 24)
                : EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: <Widget>[
                SwimmingPoolWidget(pool, colors[index % colors.length]),
                ExpandingOpeningHours(pool.openingHours),
              ],
            ),
          );
        });
  }
}
