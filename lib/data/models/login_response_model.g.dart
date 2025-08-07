// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      encrypted: json['encrypted'] as bool?,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'encrypted': instance.encrypted,
      'data': instance.data?.toJson(),
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user?.toJson(),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      addressLane1: json['addressLane1'] as String?,
      addressLane2: json['addressLane2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      isOnline: json['isOnline'] as bool?,
      blockedUsers: json['blockedUsers'] as List<dynamic>?,
      role: json['role'] as String?,
      isVerified: json['isVerified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      deletedMessage: json['deletedMessage'] as String?,
      isDisabled: json['isDisabled'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['v'] as num?)?.toInt(),
      lastSeen: json['lastSeen'] as String?,
      profile: json['profile'] as String?,
      deletedTime: json['deletedTime'] as String?,
      plan: json['plan'] as String?,
      previousPlan: json['previousPlan'] as String?,
      createdForTTL: json['createdForTTL'] as String?,
      paymentHistory: (json['paymentHistory'] as List<dynamic>?)
          ?.map((e) => PaymentHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      referralCode: json['referralCode'] as String?,
      planEndDate: json['planEndDate'] as String?,
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'phone': instance.phone,
      'addressLane1': instance.addressLane1,
      'addressLane2': instance.addressLane2,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'isOnline': instance.isOnline,
      'blockedUsers': instance.blockedUsers,
      'role': instance.role,
      'isVerified': instance.isVerified,
      'isDeleted': instance.isDeleted,
      'deletedMessage': instance.deletedMessage,
      'isDisabled': instance.isDisabled,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
      'lastSeen': instance.lastSeen,
      'profile': instance.profile,
      'deletedTime': instance.deletedTime,
      'plan': instance.plan,
      'previousPlan': instance.previousPlan,
      'createdForTTL': instance.createdForTTL,
      'paymentHistory':
          instance.paymentHistory?.map((e) => e.toJson()).toList(),
      'referralCode': instance.referralCode,
      'planEndDate': instance.planEndDate,
      'fcmTokens': instance.fcmTokens,
      'location': instance.location?.toJson(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) =>
    PaymentHistory(
      orderId: json['orderId'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      method: json['method'] == null
          ? null
          : PaymentMethod.fromJson(json['method'] as Map<String, dynamic>),
      paidAt: json['paidAt'] as String?,
      paymentId: json['_id'] as String?,
    );

Map<String, dynamic> _$PaymentHistoryToJson(PaymentHistory instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'method': instance.method,
      'paidAt': instance.paidAt,
      '_id': instance.paymentId,
    };

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      upi: json['upi'] == null
          ? null
          : Upi.fromJson(json['upi'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'upi': instance.upi,
    };

Upi _$UpiFromJson(Map<String, dynamic> json) => Upi(
      channel: json['channel'] as String?,
      upiId: json['upi_id'] as String?,
    );

Map<String, dynamic> _$UpiToJson(Upi instance) => <String, dynamic>{
      'channel': instance.channel,
      'upi_id': instance.upiId,
    };
