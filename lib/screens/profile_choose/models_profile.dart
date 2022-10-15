import 'package:json_annotation/json_annotation.dart';
part 'models_profile.g.dart';

@JsonSerializable()
class PastoralCycle {
  final String typename;
  final String startDate;
  final String endDate;
  final int numberOfDays;

  PastoralCycle({
    required this.typename,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
  });

  factory PastoralCycle.fromJson(Map<String, dynamic> json) => _$PastoralCycleFromJson(json);
  Map<String, dynamic> toJson() => _$PastoralCycleToJson(this);
}

@JsonSerializable()
class ProfileChurch {
  String id;
  String typename;
  String name;
  int? imclTotal;
  PastoralCycle? currentPastoralCycle;

  ProfileChurch({
    required this.id,
    required this.typename,
    required this.name,
    this.imclTotal,
    this.currentPastoralCycle,
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
  List<ProfileChurch> leadsBacenta;
  List<ProfileChurch> leadsConstituency;
  List<ProfileChurch> leadsSonta;
  List<ProfileChurch> leadsCouncil;
  List<ProfileChurch> leadsStream;
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
    required this.leadsStream,
    required this.leadsGatheringService,
    required this.isAdminForGatheringService,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
