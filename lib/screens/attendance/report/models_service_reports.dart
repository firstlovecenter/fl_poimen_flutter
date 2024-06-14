import 'package:json_annotation/json_annotation.dart';
import 'package:poimen/models/neo4j.dart';
import 'package:poimen/screens/membership/models_membership.dart';
part 'models_service_reports.g.dart';

@JsonSerializable()
class MemberForListWithBacenta extends MemberForList {
  Church bacenta;

  MemberForListWithBacenta({
    required this.bacenta,
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

  factory MemberForListWithBacenta.fromJson(Map<String, dynamic> json) =>
      _$MemberForListWithBacentaFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberForListWithBacentaToJson(this);
}

@JsonSerializable()
class ServicesForReport {
  String id = '';
  String typename = '';
  TimeGraph serviceDate = TimeGraph();
  List<String> membersPicture = [];
  List<MemberForList> membersPresentFromBacenta = [];
  List<MemberForList> membersAbsentFromBacenta = [];
  List<MemberForListWithBacenta> membersPresent = [];
  List<MemberForListWithBacenta> membersAbsent = [];

  ServicesForReport({
    required this.id,
    required this.typename,
    required this.serviceDate,
    required this.membersPicture,
    required this.membersPresentFromBacenta,
    required this.membersAbsentFromBacenta,
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
  List<MemberForListWithBacenta> membersAbsent = [];
  List<MemberForListWithBacenta> membersPresent = [];
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
