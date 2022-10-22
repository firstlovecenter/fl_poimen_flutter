class ChurchWithPaginatedMemberQueries {
  final String id;
  final String name;
  final String typename;
  final int sheepCount;
  final dynamic sheepQuery;
  final int goatCount;
  final dynamic goatQuery;
  final int deerCount;
  final dynamic deerQuery;

  ChurchWithPaginatedMemberQueries({
    required this.id,
    required this.typename,
    required this.name,
    required this.sheepCount,
    required this.sheepQuery,
    required this.goatCount,
    required this.goatQuery,
    required this.deerCount,
    required this.deerQuery,
  });
}
