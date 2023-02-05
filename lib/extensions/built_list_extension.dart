import 'package:built_collection/built_collection.dart';

extension BuiltListToList<T> on BuiltList<T> {
  List<T> toList() => map((p0) => p0).toList();
}
