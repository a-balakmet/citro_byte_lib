import 'dart:async';
import 'dart:developer';

import 'package:citro_byte_lib/data/remote/resource.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class BaseController extends GetxController {}

mixin BasicController<T, R> on BaseController {
  final result = Rx<Result<T>>(Result(true, null, null, false));
  StreamController<Result<T>> controller = StreamController<Result<T>>.broadcast();
  Rx<R>? observable;
  var isLogin = false;

  @override
  void onInit() {
    isLogin = setLogin();
    observable = initObservable();
    companions().then((value) {
      if (observable == null) {
        if (isLogin) log('CitroByte LIB: launch stream $T without observable');
        fetch();
      } else {
        fetch();
        observable!.listen((p0) {
          if (isLogin) log('CitroByte LIB: re-launch stream $T with observable $R');
          fetch();
        });
      }
    });
    super.onInit();
  }

  Future<void> fetch() async {
    initStream().listen((event) {
      controller.sink.add(event);
    });
    controller.stream.listen((event) {
      if (isLogin) log('CitroByte LIB: listening stream $T ${event.toString()}');
      result(event);
      update();
    });
  }

  Stream<Result<T>> initStream();
  Rx<R>? initObservable();
  bool setLogin();
  Future<void> companions();
}
