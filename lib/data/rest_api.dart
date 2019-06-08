import 'package:http/http.dart' as http;

class RestApi {

  static const String ENDPOINT = "https://free-lane-backend.herokuapp.com/api";
  static const String TEST_ENDPOINT = "http://localhost:8080/api";
  static const String ANDROID_EMULATOR_TEST_ENDPOINT = "http://10.0.2.2:8080/api";

  Future<http.Response> getSwimmingPools() async {
    return http.get('$ANDROID_EMULATOR_TEST_ENDPOINT/pools');
  }
}
