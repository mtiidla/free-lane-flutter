import 'package:freelane/data/rest_api.dart';
import 'package:freelane/data/swimming_pool_repo.dart';

/// Non-lazy service locator which assumes that all the dependencies are
/// required for the entire runtime of the application.
class ServiceLocator {

  final SwimmingPoolRepository swimmingPoolRepository;

  ServiceLocator._privateConstructor(this.swimmingPoolRepository);

  static final ServiceLocator instance =
      ServiceLocator._privateConstructor(SwimmingPoolRepository(RestApi()));
}
