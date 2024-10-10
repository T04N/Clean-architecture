import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freezed_data_class.freezed.dart';
part 'freezed_data_class.g.dart';

@freezed
class LoginObject with _$LoginObject {
  const factory LoginObject({
    required String username,
    required String password,
  }) = _LoginObject;

  factory LoginObject.fromJson(Map<String, dynamic> json) => _$LoginObjectFromJson(json);
}
