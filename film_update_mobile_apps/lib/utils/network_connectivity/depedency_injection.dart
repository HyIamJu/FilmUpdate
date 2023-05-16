import 'dart:ffi';

import 'package:film_update_mobile_apps/utils/network_connectivity/network_controller.dart';
import 'package:get/get.dart';

class DepedencyInjection {
  static Void? init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    return null;
  }
}
