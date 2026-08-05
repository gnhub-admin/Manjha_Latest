import 'package:get/get.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixpanelController extends GetxController {
  static Mixpanel? mixpanel;
  static const String PageProductList = "Product List";
  static const String PageLanguage = "Language List";
  static const String PageStore = "Store Screen";
  static const String PageProductDetail = "Product Detail";
  static const String PageCart = "Cart";
  static const String PageCheckout = "Checkout";
  static const String PageChatGPT = "Chat GPT";
  static const String PageVideoBlog = "Video Blog";
  static const String PageDiscover = "Discover";
  static const String PageCharcha = "Charcha";
  static const String PageNewsList = "News List";
  static const String PageNewsDetails = "News Details";

  static Future<void> initMixpanel(
      String id, String email, String mobile) async {
    mixpanel = await Mixpanel.init("cf7cf8f43345327839f884889d207e11",
        trackAutomaticEvents: false);

    mixpanel?.identify(id);
    mixpanel?.getPeople().set("Email", email);
    mixpanel?.getPeople().set("Name", mobile);

    // mixpanel?.identify(saveUser()?.data?.id.toString() ?? "");
    // mixpanel?.getPeople().set("Email", "${saveUser()?.data?.emailid}");
    // mixpanel?.getPeople().set("Name", "${saveUser()?.data?.mobileno}");
    print(mixpanel);
  }

  static void logScreen(String screenName, {Map<String, dynamic>? properties}) {
    mixpanel?.track(screenName, properties: properties);
  }
}
