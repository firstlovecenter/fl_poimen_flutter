import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_service_reports.g.dart';

@JsonSerializable()
class ServicesForReport {
  String id = '';
  String typename = '';
  TimeGraph serviceDate = TimeGraph();
  List<String> membersPicture = [];
  List<MemberForList> membersPresent = [];
  List<MemberForList> membersAbsent = [];

  ServicesForReport({
    required this.id,
    required this.typename,
    required this.serviceDate,
    required this.membersPicture,
    required this.membersPresent,
    required this.membersAbsent,
  });

  factory ServicesForReport.fromJson(Map<String, dynamic> json) =>
      _$ServicesForReportFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesForReportToJson(this);
}
