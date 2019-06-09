class SwimmingPool {
  final int id;
  final String name;
  final String url;
  final String coverImageUrl;
  final PeopleCount peopleCount;
  final List<OpeningHours> openingHours;

  SwimmingPool(
      {this.id,
      this.name,
      this.url,
      this.coverImageUrl,
      this.peopleCount,
      this.openingHours});

  factory SwimmingPool.fromJson(Map<String, dynamic> json) {
    var openingHoursJson = json['opening_hours'] as List;
    return SwimmingPool(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        coverImageUrl: json["cover_image_url"],
        peopleCount: PeopleCount.fromJson(json["latest_count"]),
        openingHours: openingHoursJson
            .map((item) => OpeningHours.fromJson(item))
            .toList());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SwimmingPool &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              url == other.url &&
              coverImageUrl == other.coverImageUrl &&
              peopleCount == other.peopleCount &&
              openingHours == other.openingHours;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      url.hashCode ^
      coverImageUrl.hashCode ^
      peopleCount.hashCode ^
      openingHours.hashCode;
}

class PeopleCount {
  final String timestamp;
  final int people;

  PeopleCount({this.timestamp, this.people});

  factory PeopleCount.fromJson(Map<String, dynamic> json) {
    return PeopleCount(timestamp: json["timestamp"], people: json["people"]);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PeopleCount &&
              runtimeType == other.runtimeType &&
              timestamp == other.timestamp &&
              people == other.people;

  @override
  int get hashCode =>
      timestamp.hashCode ^
      people.hashCode;
}

class OpeningHours {
  final int dayOfWeek;
  final String open;
  final String closed;
  final String label;

  OpeningHours({this.dayOfWeek, this.open, this.closed, this.label});

  String toRangeString() {
    return "$open - $closed";
  }

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
        dayOfWeek: json["day"], open: json["open"], closed: json["closed"]);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OpeningHours &&
              runtimeType == other.runtimeType &&
              dayOfWeek == other.dayOfWeek &&
              open == other.open &&
              closed == other.closed &&
              label == other.label;

  @override
  int get hashCode =>
      dayOfWeek.hashCode ^
      open.hashCode ^
      closed.hashCode ^
      label.hashCode;
}
