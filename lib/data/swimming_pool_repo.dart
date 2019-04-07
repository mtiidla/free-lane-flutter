
import 'dart:convert';
import 'package:freelane/data/rest_api.dart';
import 'package:freelane/domain/model/swimming_pool.dart';

class SwimmingPoolRepository {

  final RestApi restApi;

  SwimmingPoolRepository(this.restApi);

  Future<List<SwimmingPool>> getSwimmingPools() async {

    // TODO: find out how to use async await properly
    final response = await restApi.getSwimmingPools();

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((item) => SwimmingPool.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load swimming pools');
    }
  }

}
