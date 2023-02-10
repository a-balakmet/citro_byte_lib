import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'resource/resource.dart';

abstract class BaseController extends GetxController {}

mixin BasicController<T, R> on BaseController {
  final result = Rx<Result<T>>(Result(false, null, null, false));
  Stream<Result<T>>? stream;
  Rx<R>? observable;

  @override
  void onInit() {
    stream = initStream();
    if (initObservable() == null) {
      fetch();
    } else {
      observable = initObservable();
      observable!.listen((p0) {
        fetch();
      });
    }
    super.onInit();
  }

  Future<void> fetch() async {
    if (stream != null) {
      stream?.listen((event) {
        result(event);
        update();
      });
    }
  }

  Stream<Result<T>> initStream();
  Rx<R>? initObservable();
  void postLoadingHandler();
}
