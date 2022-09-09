import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_services.g.dart';

@JsonSerializable()
class ChurchForServicesList extends Church {
  List<ServicesForList> services = [];

  ChurchForServicesList({
    required this.services,
  }) : super(id: '', typename: '', name: '');

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
  }) : super(id: '', typename: '', name: '');

  factory ChurchForBussingList.fromJson(Map<String, dynamic> json) =>
      _$ChurchForBussingListFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChurchForBussingListToJson(this);
}

@JsonSerializable()
class ServicesForList {
  String id = '';
  String typename = 'ServiceRecord';
  int attendance = 0;
  bool markedAttendance = false;
  TimeGraph serviceDate = TimeGraph();

  ServicesForList({
    required this.id,
    required this.typename,
    required this.attendance,
    required this.markedAttendance,
    required this.serviceDate,
  });

  factory ServicesForList.fromJson(Map<String, dynamic> json) => _$ServicesForListFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesForListToJson(this);
}
