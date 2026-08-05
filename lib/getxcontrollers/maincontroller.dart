import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/storescreen.dart';

class MainController extends GetxController {
  RxBool fristscreen = false.obs;
  RxBool secondscreen = false.obs;
  RxBool thirdscreen = false.obs;
  RxBool fourthscreen = false.obs;
  RxBool fivescreen = false.obs;
  RxInt currentTab = 0.obs;
  Rx<Widget> currentScreen = Rx<Widget>(StoreScreen());
}
