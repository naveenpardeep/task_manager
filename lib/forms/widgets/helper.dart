import '../../model/options/server_options.dart';

abstract class Helper {
  static imageUri(String name) {
    if (name.isEmpty) {
      return '${NsgServerOptions.serverUriDataController}/no_photo.jpg';
    }

    return '${NsgServerOptions.serverUriDataController}/$name';
  }
}
