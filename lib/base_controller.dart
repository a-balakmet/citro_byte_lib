import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'resource/resource.dart';

abstract class BaseController extends GetxController {}

mixin BasicController<T, R> on BaseController {
  final result = Rx<Result<T>>(Result(true, null, null, false));
  Stream<Result<T>>? stream;
  Rx<R>? observable;

  @override
  void onInit() {
    observable = initObservable();
    stream = initStream();
    if (observable == null) {
      debugPrint('CitroByte LIB: launch stream without observable');
      fetch();
    } else {
      observable!.listen((p0) {
        debugPrint('CitroByte LIB: re-launch stream on change of observable');
        fetch();
      });
    }
    super.onInit();
  }

  Future<void> fetch() async {
    stream?.listen((event) {
      result(event);
      update();
    });
  }

  Stream<Result<T>> initStream();
  Rx<R>? initObservable();
  void postLoadingHandler();
}
