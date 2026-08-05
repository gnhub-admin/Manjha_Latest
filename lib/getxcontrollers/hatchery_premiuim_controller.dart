import 'package:get/get.dart';
import 'package:manjha/services/apiconst.dart';
import '../model/gethitcheryresponse.dart';

class HatcheryController extends GetxController {
  RxBool loading = false.obs;
  RxList<Fish> getHatcheryFish = <Fish>[].obs;

  Future<void> fetchHatcheryFish(state) async {
    loading.value = true;
    await getHatcheryPremium(
      state: state,
    )
        .then((value) {
      loading.value = false;
      getHatcheryFish.value = value.fish!.cast<Fish>();
    }).onError((error, stackTrace) {
      loading.value = false;

      print(error);
    });
  }
}