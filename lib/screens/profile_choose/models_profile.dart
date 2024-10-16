import 'package:json_annotation/json_annotation.dart';
part 'models_profile.g.dart';

@JsonSerializable()
class ProfileChurch {
  String id;
  String typename;
  String name;

  ProfileChurch({
    required this.id,
    required this.typename,
    required this.name,
  });
  factory ProfileChurch.fromJson(Map<String, dynamic> json) => _$ProfileChurchFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileChurchToJson(this);
}

@JsonSerializable()
class Profile {
  String id;
  String firstName;
  String lastName;
  String pictureUrl;
  List<ProfileChurch> leadsBacenta;
  List<ProfileChurch> leadsGovernorship;
  List<ProfileChurch> isAdminForGovernorship;
  List<ProfileChurch> leadsCouncil;
  List<ProfileChurch> isAdminForCouncil;
  List<ProfileChurch> leadsStream;
  List<ProfileChurch> isAdminForStream;
  List<ProfileChurch> leadsCampus;
  List<ProfileChurch> isAdminForCampus;
  List<ProfileChurch> leadsHub;
  List<ProfileChurch> leadsHubCouncil;
  List<ProfileChurch> leadsMinistry;
  List<ProfileChurch> isAdminForMinistry;
  List<ProfileChurch> leadsCreativeArts;
  List<ProfileChurch> isAdminForCreativeArts;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.pictureUrl,
    required this.leadsBacenta,
    required this.leadsGovernorship,
    required this.isAdminForGovernorship,
    required this.leadsCouncil,
    required this.isAdminForCouncil,
    required this.leadsStream,
    required this.isAdminForStream,
    required this.leadsCampus,
    required this.isAdminForCampus,
    required this.leadsHub,
    required this.leadsHubCouncil,
    required this.leadsMinistry,
    required this.isAdminForMinistry,
    required this.leadsCreativeArts,
    required this.isAdminForCreativeArts,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
