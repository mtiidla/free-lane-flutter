import 'package:http/http.dart' as http;

class RestApi {

  static const String ENDPOINT = "https://free-lane-backend.herokuapp.com/api";

  Future<http.Response> getSwimmingPools() async {
    return http.get('$ENDPOINT/pools');
  }
}
