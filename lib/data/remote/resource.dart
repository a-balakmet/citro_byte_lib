// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';

import 'error.dart';


class Resource<T> {
  Future<Result> handleResponse(Future<Response<T>> request) async {
    try {
      final response = await request;
      if (response.isSuccessful) {
        if (response.body != null) {
          final Result success = Result(false, response.body!, null, false);
          return success;
        } else {
          final errorMessage = ErrorMessage(backEndCode: 'empty', isTranslatable: true, error: 'no_data');
          final Result error = Result(false, null, errorMessage, false);
          return error;
        }
      } else {
        return parseError(response);
      }
    } on TimeoutException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'timeout', isTranslatable: false, error: '$e');
      final Result error = Result(false, null, errorMessage, false);
      return error;
    } on SocketException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'socket_exception', isTranslatable: false, error: '$e');
      final Result error = Result(false, null, errorMessage, false);
      return error;
    } on Exception catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'exception', isTranslatable: false, error: '$e');
      final Result error = Result(false, null, errorMessage, false);
      return error;
    }
  }

  Future<Result<T?>> handleResponseDto(Future<Response<T>> request) async {
    try {
      final response = await request;
      if (response.isSuccessful) {
        if (response.body != null) {
          final result = Result(false, (response.body as T), null, false);
          return result;
        } else {
          final errorMessage = ErrorMessage(backEndCode: 'empty', isTranslatable: true, error: 'no_data');
          final error = Result(false, null, errorMessage, false);
          return error;
        }
      } else {
        return parseError(response);
      }
    } on TimeoutException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'timeout', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    } on SocketException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'socket_exception', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    } on Exception catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'exception', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    }
  }

  Future<Result<R?>> mapResponse<R>(Future<Response<T>> request, R Function(T) mapper) async {
    try {
      final response = await request;
      if (response.isSuccessful) {
        if (response.body != null) {
          final result = Result(false, mapper(response.body as T), null, false);
          return result;
        } else {
          final errorMessage = ErrorMessage(backEndCode: 'empty', isTranslatable: true, error: 'no_data');
          final error = Result(false, null, errorMessage, false);
          return error;
        }
      } else {
        return parseError(response);
      }
    } on TimeoutException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'timeout', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    } on SocketException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'socket_exception', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    } on Exception catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'exception', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    }
  }

  Future<Result<List<R>?>> mapResponseToList<R>(Future<Response<T>> request, R Function(T) mapper) async {
    try {
      final response = await request;
      if (response.isSuccessful) {
        if (response.body != null) {
          final list = (response.body! as BuiltList<T>).map((e) => mapper(e)).toList();
          final result = Result(false, list, null, false);
          return result;
        } else {
          final errorMessage = ErrorMessage(backEndCode: 'empty', isTranslatable: true, error: 'no_data');
          final error = Result(false, null, errorMessage, false);
          return error;
        }
      } else {
        return parseError(response);
      }
    } on TimeoutException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'timeout', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    } on SocketException catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'socket_exception', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    } on Exception catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'exception', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    }
  }

  Result<R?> parseError<R>(Response<T> response) {
    try {
      final errorMessage = (response.error as ErrorDto).errorFromDto();
      final error = Result(false, null, errorMessage, false);
      return error;
    } catch (e) {
      final errorMessage = ErrorMessage(backEndCode: 'error_exception', isTranslatable: false, error: '$e');
      final error = Result(false, null, errorMessage, false);
      return error;
    }
  }
}

class Result<T> extends Resource<T> {
  final bool isLoading;
  final T? value;
  late final ErrorMessage? error;
  final bool isLoadingMore;
  Result(this.isLoading, this.value, this.error, this.isLoadingMore);

  @override
  String toString() {
    return 'is loading = $isLoading\nvalue = $value\nbackend = ${error?.backEndCode}\nerror = ${error?.error}\nis loading more = $isLoadingMore';
  }
}
