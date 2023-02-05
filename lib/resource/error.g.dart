// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ErrorDto> _$errorDtoSerializer = new _$ErrorDtoSerializer();

class _$ErrorDtoSerializer implements StructuredSerializer<ErrorDto> {
  @override
  final Iterable<Type> types = const [ErrorDto, _$ErrorDto];
  @override
  final String wireName = 'ErrorDto';

  @override
  Iterable<Object?> serialize(Serializers serializers, ErrorDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'error_code',
      serializers.serialize(object.errorCode,
          specifiedType: const FullType(String)),
      'error_message',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ErrorDto deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'error_code':
          result.errorCode = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'error_message':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ErrorDto extends ErrorDto {
  @override
  final String errorCode;
  @override
  final String errorMessage;

  factory _$ErrorDto([void Function(ErrorDtoBuilder)? updates]) =>
      (new ErrorDtoBuilder()..update(updates))._build();

  _$ErrorDto._({required this.errorCode, required this.errorMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(errorCode, r'ErrorDto', 'errorCode');
    BuiltValueNullFieldError.checkNotNull(
        errorMessage, r'ErrorDto', 'errorMessage');
  }

  @override
  ErrorDto rebuild(void Function(ErrorDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorDtoBuilder toBuilder() => new ErrorDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorDto &&
        errorCode == other.errorCode &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, errorCode.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorDto')
          ..add('errorCode', errorCode)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class ErrorDtoBuilder implements Builder<ErrorDto, ErrorDtoBuilder> {
  _$ErrorDto? _$v;

  String? _errorCode;
  String? get errorCode => _$this._errorCode;
  set errorCode(String? errorCode) => _$this._errorCode = errorCode;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  ErrorDtoBuilder();

  ErrorDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _errorCode = $v.errorCode;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ErrorDto;
  }

  @override
  void update(void Function(ErrorDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorDto build() => _build();

  _$ErrorDto _build() {
    final _$result = _$v ??
        new _$ErrorDto._(
            errorCode: BuiltValueNullFieldError.checkNotNull(
                errorCode, r'ErrorDto', 'errorCode'),
            errorMessage: BuiltValueNullFieldError.checkNotNull(
                errorMessage, r'ErrorDto', 'errorMessage'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
