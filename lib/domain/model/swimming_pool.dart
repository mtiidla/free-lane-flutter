
class SwimmingPool {
  final int id;
  final String name;
  final String url;
  final PeopleCount peopleCount;

  SwimmingPool({this.id, this.name, this.url, this.peopleCount});

  factory SwimmingPool.fromJson(Map<String, dynamic> json) {
    return SwimmingPool(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        peopleCount: PeopleCount.fromJson(json["latest_count"]));
  }
}

class PeopleCount {
  final String timestamp;
  final int people;

  PeopleCount({this.timestamp, this.people});

  factory PeopleCount.fromJson(Map<String, dynamic> json) {
    return PeopleCount(timestamp: json["timestamp"], people: json["people"]);
  }
}
