import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_service_reports.g.dart';

@JsonSerializable()
class MemberForListWithFellowship extends MemberForList {
  Church fellowship;

  MemberForListWithFellowship({
    required this.fellowship,
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

  factory MemberForListWithFellowship.fromJson(Map<String, dynamic> json) =>
      _$MemberForListWithFellowshipFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberForListWithFellowshipToJson(this);
}

@JsonSerializable()
class ServicesForReport {
  String id = '';
  String typename = '';
  TimeGraph serviceDate = TimeGraph();
  List<String> membersPicture = [];
  List<MemberForList> membersPresentFromFellowship = [];
  List<MemberForList> membersAbsentFromFellowship = [];
  List<MemberForListWithFellowship> membersPresent = [];
  List<MemberForListWithFellowship> membersAbsent = [];

  ServicesForReport({
    required this.id,
    required this.typename,
    required this.serviceDate,
    required this.membersPicture,
    required this.membersPresentFromFellowship,
    required this.membersAbsentFromFellowship,
    required this.membersAbsent,
    required this.membersPresent,
  });

  factory ServicesForReport.fromJson(Map<String, dynamic> json) =>
      _$ServicesForReportFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesForReportToJson(this);
}

@JsonSerializable()
class RehearsalsForReport {
  String id = '';
  String typename = '';
  TimeGraph serviceDate = TimeGraph();
  List<String> membersPicture = [];
  List<MemberForListWithFellowship> membersAbsent = [];
  List<MemberForListWithFellowship> membersPresent = [];
  List<MemberForList> membersAbsentFromHub = [];
  List<MemberForList> membersPresentFromHub = [];

  RehearsalsForReport({
    required this.id,
    required this.typename,
    required this.serviceDate,
    required this.membersPicture,
    required this.membersAbsent,
    required this.membersPresent,
    required this.membersAbsentFromHub,
    required this.membersPresentFromHub,
  });

  factory RehearsalsForReport.fromJson(Map<String, dynamic> json) =>
      _$RehearsalsForReportFromJson(json);
  Map<String, dynamic> toJson() => _$RehearsalsForReportToJson(this);
}
