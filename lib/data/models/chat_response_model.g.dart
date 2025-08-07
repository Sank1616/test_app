// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      chatId: json['_id'] as String?,
      isGroupChat: json['isGroupChat'] as bool?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
      lastMessage: json['lastMessage'] == null
          ? null
          : LastMessageModel.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      '_id': instance.chatId,
      'isGroupChat': instance.isGroupChat,
      'participants': instance.participants?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'lastMessage': instance.lastMessage?.toJson(),
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['_id'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      addressLane1: json['addressLane1'] as String?,
      addressLane2: json['addressLane2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      isOnline: json['isOnline'] as bool?,
      blockedUsers: (json['blockedUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      role: json['role'] as String?,
      isVerified: json['isVerified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      deletedMessage: json['deletedMessage'] as String?,
      isDisabled: json['isDisabled'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      profile: json['profile'] as String?,
      deletedTime: json['deletedTime'] == null
          ? null
          : DateTime.parse(json['deletedTime'] as String),
      plan: json['plan'] as String?,
      planEndDate: json['planEndDate'] == null
          ? null
          : DateTime.parse(json['planEndDate'] as String),
      previousPlan: json['previousPlan'] as String?,
      paymentHistory: (json['paymentHistory'] as List<dynamic>?)
          ?.map((e) => PaymentHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdForTTL: json['createdForTTL'] == null
          ? null
          : DateTime.parse(json['createdForTTL'] as String),
      referralId: json[' referralId'] as String?,
      referralCode: json['referralCode'] as String?,
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.userId,
      'location': instance.location?.toJson(),
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
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
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'profile': instance.profile,
      'deletedTime': instance.deletedTime?.toIso8601String(),
      'plan': instance.plan,
      'planEndDate': instance.planEndDate?.toIso8601String(),
      'previousPlan': instance.previousPlan,
      'paymentHistory':
          instance.paymentHistory?.map((e) => e.toJson()).toList(),
      'createdForTTL': instance.createdForTTL?.toIso8601String(),
      ' referralId': instance.referralId,
      'referralCode': instance.referralCode,
      'fcmTokens': instance.fcmTokens,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

PaymentHistoryModel _$PaymentHistoryModelFromJson(Map<String, dynamic> json) =>
    PaymentHistoryModel(
      orderId: json['orderId'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      method: json['method'] == null
          ? null
          : PaymentMethod.fromJson(json['method'] as Map<String, dynamic>),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      paymentId: json['_id'] as String?,
    );

Map<String, dynamic> _$PaymentHistoryModelToJson(
        PaymentHistoryModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'method': instance.method?.toJson(),
      'paidAt': instance.paidAt?.toIso8601String(),
      '_id': instance.paymentId,
    };

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      upi: json['upi'] == null
          ? null
          : UpiPayment.fromJson(json['upi'] as Map<String, dynamic>),
      card: json['card'] == null
          ? null
          : CardPayment.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'upi': instance.upi,
      'card': instance.card,
    };

UpiPayment _$UpiPaymentFromJson(Map<String, dynamic> json) => UpiPayment(
      channel: json['channel'] as String?,
      upi_id: json['upi_id'] as String?,
    );

Map<String, dynamic> _$UpiPaymentToJson(UpiPayment instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'upi_id': instance.upi_id,
    };

CardPayment _$CardPaymentFromJson(Map<String, dynamic> json) => CardPayment(
      card_bank_name: json['card_bank_name'] as String?,
      card_country: json['card_country'] as String?,
      card_network: json['card_network'] as String?,
      card_network_reference_id: json['card_network_reference_id'] as String?,
      card_number: json['card_number'] as String?,
      card_sub_type: json['card_sub_type'] as String?,
      card_type: json['card_type'] as String?,
      channel: json['channel'] as String?,
    );

Map<String, dynamic> _$CardPaymentToJson(CardPayment instance) =>
    <String, dynamic>{
      'card_bank_name': instance.card_bank_name,
      'card_country': instance.card_country,
      'card_network': instance.card_network,
      'card_network_reference_id': instance.card_network_reference_id,
      'card_number': instance.card_number,
      'card_sub_type': instance.card_sub_type,
      'card_type': instance.card_type,
      'channel': instance.channel,
    };

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) =>
    LastMessageModel(
      messageId: json['_id'] as String?,
      senderId: json['senderId'] as String?,
      content: json['content'] as String?,
      messageType: json['messageType'] as String?,
      fileUrl: json['fileUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$LastMessageModelToJson(LastMessageModel instance) =>
    <String, dynamic>{
      '_id': instance.messageId,
      'senderId': instance.senderId,
      'content': instance.content,
      'messageType': instance.messageType,
      'fileUrl': instance.fileUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
