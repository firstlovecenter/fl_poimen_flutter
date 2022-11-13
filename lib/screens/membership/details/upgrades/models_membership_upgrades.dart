import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_membership_upgrades.g.dart';

@JsonSerializable()
class MemberWithUpgrades extends MemberForList {
  bool hasHolyGhostBaptism;
  bool hasWaterBaptism;
  List<String> graduatedUnderstandingSchools;
  bool hasAudioCollections;
  List<String> hasBibleTranslations;
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
