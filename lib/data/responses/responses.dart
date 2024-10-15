import 'package:json_annotation/json_annotation.dart';


part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? baseResponseStatus;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  CustomerResponse(this.id, this.name, this.numOfNotifications);
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  //FROM JSON
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
//TO JSON
  Map<String, dynamic> toJson() =>_$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  ContactResponse(this.email, this.phone, this.link);

  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;


  //FROM JSON
  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);
//TO JSON
  Map<String, dynamic> toJson() =>_$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationsResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;

  @JsonKey(name: "contacts")
  ContactResponse? contacts;

  AuthenticationsResponse(this.customer, this.contacts);
//FROM JSON
  factory AuthenticationsResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationsResponseFromJson(json);
//TO JSON
  Map<String, dynamic> toJson() =>_$AuthenticationsResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse(this.support);

// toJson
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

//fromJson
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}
