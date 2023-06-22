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
  List<ProfileChurch> leadsFellowship;
  List<ProfileChurch> leadsConstituency;
  List<ProfileChurch> isAdminForConstituency;
  List<ProfileChurch> leadsSonta;
  List<ProfileChurch> leadsCouncil;
  List<ProfileChurch> isAdminForCouncil;
  List<ProfileChurch> leadsStream;
  List<ProfileChurch> isAdminForStream;
  List<ProfileChurch> leadsCampus;
  List<ProfileChurch> isAdminForCampus;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.pictureUrl,
    required this.leadsFellowship,
    required this.leadsConstituency,
    required this.isAdminForConstituency,
    required this.leadsSonta,
    required this.leadsCouncil,
    required this.isAdminForCouncil,
    required this.leadsStream,
    required this.isAdminForStream,
    required this.leadsCampus,
    required this.isAdminForCampus,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
