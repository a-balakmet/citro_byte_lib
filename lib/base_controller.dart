import 'dart:async';
import 'dart:developer';

import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'resource/resource.dart';

abstract class BaseController extends GetxController {}

mixin BasicController<T, R> on BaseController {
  final result = Rx<Result<T>>(Result(true, null, null, false));
  //StreamController<Result<T>> controller = StreamController<Result<T>>();
  StreamSubscription<Result<T>>? subscription;
  Stream<Result<T>>? stream;
  Rx<R>? observable;
  var isLogin = false;

  @override
  void onInit() {
    isLogin = setLogin();
    observable = initObservable();
    stream = initStream();
    if (observable == null) {
      if (isLogin) log('CitroByte LIB: launch stream $T without observable');
      fetch();
    } else {
      observable!.listen((p0) {
        if (isLogin) log('CitroByte LIB: re-launch stream $T with observable $R');
        fetch();
      });
    }
    supplementaryInit();
    super.onInit();
  }

  Future<void> fetch() async {
    subscription?.cancel();
    subscription = stream?.listen((event) {
      if (isLogin) log('CitroByte LIB: listening stream $T ${event.toString()}');
      result(event);
      update();
    });

    // if (isLogin) log('CitroByte LIB: listening stream $stream');
    // StreamSubscription<Result<T>>? subscription = stream?.listen((event) {
    //   if (isLogin) log('CitroByte LIB: listening stream $T ${event.toString()}');
    //   result(event);
    //   update();
    // });
    // subscription?.onData((data) {
    //   if (isLogin) log('!!!! CitroByte LIB: listening stream $T ${data.toString()}');
    //   result(data);
    //   update();
    // });
    // subscription?.cancel();
  }

  Stream<Result<T>> initStream();
  Rx<R>? initObservable();
  bool setLogin();
  void supplementaryInit();
}
