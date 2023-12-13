import 'package:flutter/material.dart';

import 'data_type.dart';

@immutable
abstract class ApiState extends DataType {}

class InitialState extends ApiState {}

class LoadingState extends ApiState {}

class SuccessState extends ApiState {
  final dynamic data;
  SuccessState(this.data);
}

/// This state under 200 Status code with status false value.
class OtherState extends ApiState {
  final dynamic other;

  OtherState(this.other);
}

class ErrorState extends ApiState {
  final dynamic error;

  ErrorState(this.error);
}

/// Client's error catch specifically 400.
class BadState extends ApiState {
  final dynamic errors;

  BadState(this.errors);
}

class TimeoutState extends ApiState {
  final dynamic error;

  TimeoutState(this.error);
}

void listenState(ApiState state, Function(dynamic) success, {Function(dynamic)? badError}) {
  if (state is SuccessState) {
    // log("Sign IN Success");
    success(state.data);
  }
  if (state is OtherState) {
    String? message = state.other['message'];
    // AppUtils.showSnackBar(text: message, status: StatusColor.warning);
  }

  /// [BadState] will return Map data type with 'errors' key.
  if (state is BadState) {
    badError?.call(state.errors);
  }
  if (state is ErrorState) {
    //AppUtils.showSnackBar(text: state.error, status: StatusColor.error);
  }
}
