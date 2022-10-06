import 'package:poimen/state/enums.dart';

ChurchLevel getSubChurch(ChurchLevel level) {
  switch (level) {
    case ChurchLevel.bacenta:
      return ChurchLevel.fellowship;
    case ChurchLevel.constituency:
      return ChurchLevel.bacenta;
    case ChurchLevel.council:
      return ChurchLevel.constituency;
    case ChurchLevel.stream:
      return ChurchLevel.council;
    case ChurchLevel.gathering:
      return ChurchLevel.stream;
    default:
      return ChurchLevel.fellowship;
  }
}
