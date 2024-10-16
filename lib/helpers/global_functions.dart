import 'package:poimen/state/enums.dart';

ChurchLevel getSubChurch(ChurchLevel level) {
  switch (level) {
    case ChurchLevel.bacenta:
      return ChurchLevel.fellowship;
    case ChurchLevel.governorship:
      return ChurchLevel.bacenta;
    case ChurchLevel.council:
      return ChurchLevel.governorship;
    case ChurchLevel.stream:
      return ChurchLevel.council;
    case ChurchLevel.campus:
      return ChurchLevel.stream;
    default:
      return ChurchLevel.fellowship;
  }
}
