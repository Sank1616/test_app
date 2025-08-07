import 'package:json_annotation/json_annotation.dart';

part 'chat_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatModel {
  @JsonKey(name: '_id')
  final String? chatId;
  final bool? isGroupChat;
  final List<UserModel>? participants;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  final LastMessageModel? lastMessage;

  ChatModel({
    this.chatId,
    this.isGroupChat,
    this.participants,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: '_id')
  final String? userId;

  final LocationModel? location;
  final String? name;
  final String? email;
  final String? password;
  final String? gender;
  final String? phone;
  final String? addressLane1;
  final String? addressLane2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final bool? isOnline;
  final List<String>? blockedUsers;
  final String? role;
  final bool? isVerified;
  final bool? isDeleted;
  final String? deletedMessage;
  final bool? isDisabled;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  final DateTime? lastSeen;
  final String? profile;
  final DateTime? deletedTime;
  final String? plan;
  final DateTime? planEndDate;
  final String? previousPlan;
  final List<PaymentHistoryModel>? paymentHistory;
  final DateTime? createdForTTL;

  @JsonKey(name: ' referralId') // note the space in the key
  final String? referralId;

  final String? referralCode;
  final List<String>? fcmTokens;

  UserModel({
    this.userId,
    this.location,
    this.name,
    this.email,
    this.password,
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
    this.version,
    this.lastSeen,
    this.profile,
    this.deletedTime,
    this.plan,
    this.planEndDate,
    this.previousPlan,
    this.paymentHistory,
    this.createdForTTL,
    this.referralId,
    this.referralCode,
    this.fcmTokens,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class LocationModel {
  final double? latitude;
  final double? longitude;

  LocationModel({
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaymentHistoryModel {
  final String? orderId;
  final int? amount;
  final String? currency;
  final String? status;
  final PaymentMethod? method;
  final DateTime? paidAt;

  @JsonKey(name: '_id')
  final String? paymentId;

  PaymentHistoryModel({
    this.orderId,
    this.amount,
    this.currency,
    this.status,
    this.method,
    this.paidAt,
    this.paymentId,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentHistoryModelToJson(this);
}

@JsonSerializable()
class PaymentMethod {
  final UpiPayment? upi;
  final CardPayment? card;

  PaymentMethod({this.upi, this.card});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}

@JsonSerializable()
class UpiPayment {
  final String? channel;
  final String? upi_id;

  UpiPayment({this.channel, this.upi_id});

  factory UpiPayment.fromJson(Map<String, dynamic> json) =>
      _$UpiPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$UpiPaymentToJson(this);
}

@JsonSerializable()
class CardPayment {
  final String? card_bank_name;
  final String? card_country;
  final String? card_network;
  final String? card_network_reference_id;
  final String? card_number;
  final String? card_sub_type;
  final String? card_type;
  final String? channel;

  CardPayment({
    this.card_bank_name,
    this.card_country,
    this.card_network,
    this.card_network_reference_id,
    this.card_number,
    this.card_sub_type,
    this.card_type,
    this.channel,
  });

  factory CardPayment.fromJson(Map<String, dynamic> json) =>
      _$CardPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$CardPaymentToJson(this);
}

@JsonSerializable()
class LastMessageModel {
  @JsonKey(name: '_id')
  final String? messageId;

  final String? senderId;
  final String? content;
  final String? messageType;
  final String? fileUrl;
  final DateTime? createdAt;

  LastMessageModel({
    this.messageId,
    this.senderId,
    this.content,
    this.messageType,
    this.fileUrl,
    this.createdAt,
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageModelToJson(this);
}
