import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  final bool? encrypted;
  final LoginData? data;

  LoginResponse({this.encrypted, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginData {
  final String? token;
  final User? user;

  LoginData({this.token, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: '_id')
  final String? userId;

  final String? name;
  final String? email;
  final String? gender;
  final String? phone;
  final String? addressLane1;
  final String? addressLane2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final bool? isOnline;
  final List<dynamic>? blockedUsers;
  final String? role;
  final bool? isVerified;
  final bool? isDeleted;
  final String? deletedMessage;
  final bool? isDisabled;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  final String? lastSeen;
  final String? profile;
  final String? deletedTime;
  final String? plan;
  final String? previousPlan;
  final String? createdForTTL;
  final List<PaymentHistory>? paymentHistory;
  final String? referralCode;
  final String? planEndDate;
  final List<String>? fcmTokens;
  final Location? location;

  User({
    this.userId,
    this.name,
    this.email,
    this.gender,
    this.phone,
    this.addressLane1,
    this.addressLane2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isOnline,
    this.blockedUsers,
    this.role,
    this.isVerified,
    this.isDeleted,
    this.deletedMessage,
    this.isDisabled,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastSeen,
    this.profile,
    this.deletedTime,
    this.plan,
    this.previousPlan,
    this.createdForTTL,
    this.paymentHistory,
    this.referralCode,
    this.planEndDate,
    this.fcmTokens,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Location {
  final double? latitude;
  final double? longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class PaymentHistory {
  final String? orderId;
  final int? amount;
  final String? currency;
  final String? status;
  final PaymentMethod? method;
  final String? paidAt;

  @JsonKey(name: '_id')
  final String? paymentId;

  PaymentHistory({
    this.orderId,
    this.amount,
    this.currency,
    this.status,
    this.method,
    this.paidAt,
    this.paymentId,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => _$PaymentHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentHistoryToJson(this);
}

@JsonSerializable()
class PaymentMethod {
  final Upi? upi;

  PaymentMethod({this.upi});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}

@JsonSerializable()
class Upi {
  final String? channel;

  @JsonKey(name: 'upi_id')
  final String? upiId;

  Upi({this.channel, this.upiId});

  factory Upi.fromJson(Map<String, dynamic> json) => _$UpiFromJson(json);
  Map<String, dynamic> toJson() => _$UpiToJson(this);
}
