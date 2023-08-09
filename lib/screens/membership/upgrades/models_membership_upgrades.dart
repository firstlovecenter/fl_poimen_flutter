import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_membership_upgrades.g.dart';

@JsonSerializable()
class SpiritualProgression {
  bool salvation;
  bool waterBaptism;
  bool holyGhostBaptism;
  bool newBelieversSchool;
  bool strongChristiansAcademy;
  bool understandingSchools1;
  bool understandingSchools2;
  bool understandingSchools3;
  bool attendedCamp1;
  bool attendedCamp2;
  bool attendedCamp3;
  bool foundersIntimateCounselling;
  bool leadPastorIntimateCounselling;
  bool bacentaLeader;
  bool basontaLeader;
  bool creativeArtsLeader;
  bool pastor;
  bool hasMakariosCollection;
  bool hasAudioCollection;
  bool onBacentaWhatsappGroup;

  SpiritualProgression({
    required this.salvation,
    required this.waterBaptism,
    required this.holyGhostBaptism,
    required this.newBelieversSchool,
    required this.strongChristiansAcademy,
    required this.understandingSchools1,
    required this.understandingSchools2,
    required this.understandingSchools3,
    required this.attendedCamp1,
    required this.attendedCamp2,
    required this.attendedCamp3,
    required this.foundersIntimateCounselling,
    required this.leadPastorIntimateCounselling,
    required this.bacentaLeader,
    required this.basontaLeader,
    required this.creativeArtsLeader,
    required this.pastor,
    required this.hasMakariosCollection,
    required this.hasAudioCollection,
    required this.onBacentaWhatsappGroup,
  });

  factory SpiritualProgression.fromJson(Map<String, dynamic> json) =>
      _$SpiritualProgressionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SpiritualProgressionToJson(this);
}

@JsonSerializable()
class MemberWithSpiritualProgression extends MemberForList {
  SpiritualProgression? spiritualProgression;

  MemberWithSpiritualProgression({this.spiritualProgression})
      : super(
          id: '',
          typename: '',
          status: '',
          firstName: '',
          lastName: '',
          pictureUrl: '',
          phoneNumber: '',
          whatsappNumber: '',
        );

  factory MemberWithSpiritualProgression.fromJson(Map<String, dynamic> json) =>
      _$MemberWithSpiritualProgressionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberWithSpiritualProgressionToJson(this);
}

@JsonSerializable()
class MemberWithLifeProgression extends MemberForList {
  bool married;
  bool childbirth;
  bool universityEducation;
  bool ownsHouseOrBuildingProject;

  MemberWithLifeProgression({
    required this.married,
    required this.childbirth,
    required this.universityEducation,
    required this.ownsHouseOrBuildingProject,
  }) : super(
          id: '',
          typename: '',
          status: '',
          firstName: '',
          lastName: '',
          pictureUrl: '',
          phoneNumber: '',
          whatsappNumber: '',
        );

  factory MemberWithLifeProgression.fromJson(Map<String, dynamic> json) =>
      _$MemberWithLifeProgressionFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberWithLifeProgressionToJson(this);
}
