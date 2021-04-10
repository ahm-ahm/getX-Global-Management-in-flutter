import 'package:get/get.dart';

import '../Controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<FirstController>(FirstController(), tag: 'first tag');
    Get.put<SecondController>(SecondController());
  }
}
