library citro_byte_lib;

import 'package:package_info_plus/package_info_plus.dart';

class CBDataProvider {
  Future<String> getVersion() async {
    final package = await PackageInfo.fromPlatform();
    return package.version;
  }
}
