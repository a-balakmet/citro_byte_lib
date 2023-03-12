library cb_data_provider;

import 'package:package_info_plus/package_info_plus.dart';

class CBDataProvider {
  Future<String> getPackageVersion() async {
    final package = await PackageInfo.fromPlatform();
    return package.version;
  }

  Future<String> getPackageName() async {
    final package = await PackageInfo.fromPlatform();
    return package.packageName;
  }

  List<T> listDiff<T>(List<T> l1, List<T> l2) => (l1.toSet()..addAll(l2)).where((i) => !l1.contains(i) || !l2.contains(i)).toList();
}
