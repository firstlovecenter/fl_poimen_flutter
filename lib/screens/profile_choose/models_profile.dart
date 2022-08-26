import 'package:json_annotation/json_annotation.dart';
part 'models_profile.g.dart';

@JsonSerializable()
class ProfileChurch {
  String typename;
  String id;
  String name;

  ProfileChurch({
    required this.typename,
    required this.id,
    required this.name,
  });
  factory ProfileChurch.fromJson(Map<String, dynamic> json) =>
      _$ProfileChurchFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileChurchToJson(this);
}

@JsonSerializable()
class Profile {
  String id;
  String firstName;
  String lastName;
  String pictureUrl;
  List<ProfileChurch> leadsFellowship;
  List<ProfileChurch> leadsBacenta;
  List<ProfileChurch> leadsConstituency;
  List<ProfileChurch> leadsSonta;
  List<ProfileChurch> leadsCouncil;
  List<ProfileChurch> leadsGatheringService;
  List<ProfileChurch> isAdminForGatheringService;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.pictureUrl,
    required this.leadsFellowship,
    required this.leadsBacenta,
    required this.leadsConstituency,
    required this.leadsSonta,
    required this.leadsCouncil,
    required this.leadsGatheringService,
    required this.isAdminForGatheringService,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}