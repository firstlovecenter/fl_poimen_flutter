import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';

part 'models_prayer.g.dart';

@JsonSerializable()
class OutstandingPrayerForList extends MemberForList {
  OutstandingPrayerForList({
    required String id,
    required String typename,
    required String firstName,
    required String lastName,
    required String pictureUrl,
    required String phoneNumber,
    required String whatsappNumber,
    String? status,
  }) : super(
          id: id,
          typename: typename,
          firstName: firstName,
          lastName: lastName,
          pictureUrl: pictureUrl,
          status: status,
          phoneNumber: phoneNumber,
          whatsappNumber: whatsappNumber,
        );

  factory OutstandingPrayerForList.fromJson(Map<String, dynamic> json) =>
      _$OutstandingPrayerForListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OutstandingPrayerForListToJson(this);
}

@JsonSerializable()
class CompletedPrayerForList extends MemberForList {
  CompletedPrayerForList({
    required String id,
    required String typename,
    required String firstName,
    required String lastName,
    required String pictureUrl,
    required String phoneNumber,
    required String whatsappNumber,
    String? status,
  }) : super(
          id: id,
          typename: typename,
          firstName: firstName,
          lastName: lastName,
          pictureUrl: pictureUrl,
          status: status,
          phoneNumber: phoneNumber,
          whatsappNumber: whatsappNumber,
        );

  factory CompletedPrayerForList.fromJson(Map<String, dynamic> json) =>
      _$CompletedPrayerForListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompletedPrayerForListToJson(this);
}

@JsonSerializable()
class ChurchForOutstandingPrayerList extends Church {
  int completedPrayerCount = 0;
  List<OutstandingPrayerForList> outstandingPrayer = [];

  ChurchForOutstandingPrayerList({
    required this.outstandingPrayer,
    required this.completedPrayerCount,
  });

  factory ChurchForOutstandingPrayerList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForOutstandingPrayerListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForOutstandingPrayerListToJson(this);
}

@JsonSerializable()
class ChurchForCompletedPrayerList extends Church {
  int outstandingPrayerCount = 0;
  List<CompletedPrayerForList> completedPrayer = [];

  ChurchForCompletedPrayerList({
    required this.completedPrayer,
    required this.outstandingPrayerCount,
  });

  factory ChurchForCompletedPrayerList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForCompletedPrayerListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForCompletedPrayerListToJson(this);
}
