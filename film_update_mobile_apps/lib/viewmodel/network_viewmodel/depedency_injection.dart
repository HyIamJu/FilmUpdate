import 'dart:ffi';

import 'package:film_update_mobile_apps/viewmodel/network_viewmodel/network_controller.dart';
import 'package:get/get.dart';

class DepedencyInjection {
  static Void? init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    return null;
  }
}
