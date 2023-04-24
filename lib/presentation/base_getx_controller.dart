import 'dart:async';
import 'dart:developer';

import 'package:citro_byte_lib/data/remote/resource.dart';
import 'package:chopper/chopper.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class BaseGetXController extends GetxController {}

mixin BasicGetXController<T, R> on BaseGetXController {
  Future<Response<T>> get request;
  Rx<R>? get observable;
  bool get isLog;
  final result = Rx<Result<T?>>(Result(true, null, null, false));
  StreamController<Result<T?>> controller = StreamController<Result<T?>>.broadcast();
  var nextPage = false;

  @override
  void onInit() {
    companions().then((value) {
      if (observable == null) {
        if (isLog) log('CitroByte LIB: launch stream $T without observable');
        fetch();
      } else {
        fetch();
        observable!.listen((p0) {
          if (isLog) log('CitroByte LIB: re-launch stream $T with observable $R');
          fetch();
        });
      }
    });
    super.onInit();
  }

  Future<void> fetch() async {
    stream().listen((event) {
      controller.sink.add(event);
    });
    controller.stream.listen((event) {
      if (isLog) log('CitroByte LIB: listening stream $T ${event.toString()}');
      result(event);
      update();
    });
  }

  Stream<Result<T?>> stream() async* {
    if (nextPage) {
      yield Result(false, null, null, true);
    } else {
      yield Result(true, null, null, false);
    }
    yield await Resource<T?>().handleResponseDto(request);
  }
  
  Future<void> companions();
}
