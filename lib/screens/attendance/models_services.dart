import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_services.g.dart';

@JsonSerializable()
class ChurchForMeetingsList extends Church {
  List<ServicesForList> poimenMeetings = [];

  ChurchForMeetingsList({
    required this.poimenMeetings,
  });

  factory ChurchForMeetingsList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForMeetingsListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForMeetingsListToJson(this);
}

@JsonSerializable()
class ChurchForServicesList extends Church {
  List<ServicesForList> services = [];
  List<ServicesForList>? meetings = [];

  ChurchForServicesList({
    required this.services,
  });

  factory ChurchForServicesList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForServicesListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForServicesListToJson(this);
}

@JsonSerializable()
class ChurchForBussingList extends Church {
  List<ServicesForList> bussing = [];

  ChurchForBussingList({
    required this.bussing,
  });

  factory ChurchForBussingList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForBussingListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForBussingListToJson(this);
}

@JsonSerializable()
class ServicesForList {
  String id = '';
  String typename = 'ServiceRecord';
  int? attendance = 0;
  bool markedAttendance = false;
  TimeGraph serviceDate = TimeGraph();

  ServicesForList({
    required this.id,
    required this.typename,
    this.attendance,
    required this.markedAttendance,
    required this.serviceDate,
  });

  factory ServicesForList.fromJson(Map<String, dynamic> json) => _$ServicesForListFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesForListToJson(this);
}

@JsonSerializable()
class ServiceWithPicture {
  String id = '';
  String typename = 'ServiceRecord';
  List<String> membersPicture = [];
  TimeGraph serviceDate = TimeGraph();

  ServiceWithPicture({
    required this.id,
    required this.typename,
    required this.membersPicture,
    required this.serviceDate,
  });

  factory ServiceWithPicture.fromJson(Map<String, dynamic> json) =>
      _$ServiceWithPictureFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceWithPictureToJson(this);
}
