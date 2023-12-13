import 'package:equatable/equatable.dart';

abstract class DataType extends Equatable {
  const DataType();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}