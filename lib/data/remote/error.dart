import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error.g.dart';

abstract class ErrorDto implements Built<ErrorDto, ErrorDtoBuilder> {
  static Serializer<ErrorDto> get serializer => _$errorDtoSerializer;

  @BuiltValueField(wireName: "error_code")
  String get errorCode;
  @BuiltValueField(wireName: "error_message")
  String get errorMessage;

  ErrorDto._();

  factory ErrorDto([void Function(ErrorDtoBuilder) updates]) = _$ErrorDto;
}

class ErrorMessage {
  String backEndCode;
  bool? isTranslatable;
  String error;

  ErrorMessage({required this.backEndCode, this.isTranslatable, required this.error});
}

extension ErrorMessageConvert on ErrorDto {
  ErrorMessage errorFromDto() {
    return ErrorMessage(backEndCode: errorCode, isTranslatable: false, error: errorMessage);
  }
}
