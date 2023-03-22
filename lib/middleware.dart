import 'package:get/get.dart';
import 'package:nsg_data/navigator/nsg_middleware.dart';

import 'app_pages.dart';
import 'splash/splash_binding.dart';

class TTMiddleware extends NsgMiddleware {
  TTMiddleware() : super();

  @override
  Future initialBinding(String? route) async {
    super.initialBinding(route);
    SplashBinding().dependencies();
    if (route == null || route == Routes.splashPage) {
      route = Routes.mainPage;
    }

    //Get.find<DataController>().pageAfterSplash = route;
  }

  String getParam(String paramName) {
    if (Get.parameters.containsKey(paramName) && Get.parameters[paramName] != null) {
      return Get.parameters[paramName].toString();
    }
    return '';
  }
  // @override
  // RouteSettings? redirect(String? route) {
  //   return super.redirect(route);
  // }
}
