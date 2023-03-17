import 'package:app_with_getx/services/location_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationService());
  }
}
