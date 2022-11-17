import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_membership_upgrades.g.dart';

@JsonSerializable()
class MemberWithUpgrades extends MemberForList {
  bool hasHolyGhostBaptism;
  DateTime? hasHolyGhostBaptismDate;
  bool hasWaterBaptism;
  DateTime? hasWaterBaptismDate;
  List<String> graduatedUnderstandingSchools;
  bool hasAudioCollections;
  bool hasBibleTranslations;
  List<String> attendedCampsWithProphet;
  List<String> attendedCampsWithOtherBishops;

  MemberWithUpgrades({
    required this.hasHolyGhostBaptism,
    required this.hasWaterBaptism,
    required this.graduatedUnderstandingSchools,
    required this.hasAudioCollections,
    required this.hasBibleTranslations,
    required this.attendedCampsWithProphet,
    required this.attendedCampsWithOtherBishops,
    this.hasHolyGhostBaptismDate,
    this.hasWaterBaptismDate,
  }) : super(
          id: '',
          typename: '',
          status: '',
          firstName: '',
          lastName: '',
          pictureUrl: '',
        );

  factory MemberWithUpgrades.fromJson(Map<String, dynamic> json) =>
      _$MemberWithUpgradesFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberWithUpgradesToJson(this);
}
