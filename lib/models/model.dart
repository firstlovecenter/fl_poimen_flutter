import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class Neo4jPoint {
  double latitude;
  double longitude;

  Neo4jPoint({required this.latitude, required this.longitude});

  factory Neo4jPoint.fromJson(Map<String, dynamic> json) =>
      _$Neo4jPointFromJson(json);
  Map<String, dynamic> toJson() => _$Neo4jPointToJson(this);
}

@JsonSerializable()
class User {
  String userId;
  String name;
  List<Review> reviews;
  double avgStars;
  int numReviews;
  List<Business> recommendations;

  User(
      {required this.userId,
      required this.name,
      required this.reviews,
      required this.avgStars,
      required this.numReviews,
      required this.recommendations});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Business {
  String businessId;
  String name;
  String address;
  String city;
  String state;
  Neo4jPoint location;
  double avgStars;
  List<Review> reviews;
  List<Category> categories;

  Business(
      {required this.businessId,
      required this.name,
      required this.address,
      required this.city,
      required this.state,
      required this.location,
      required this.avgStars,
      required this.reviews,
      required this.categories});

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}

@JsonSerializable()
class Review {
  String reviewId;
  double stars;
  String text;
  String date;
  Business business;
  User user;

  Review({
    required this.reviewId,
    required this.stars,
    required this.text,
    required this.date,
    required this.business,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class Category {
  String name;
  List<Business> businesses;

  Category({required this.name, required this.businesses});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class RatingCount {
  double stars;
  int count;

  RatingCount({required this.stars, required this.count});

  factory RatingCount.fromJson(Map<String, dynamic> json) =>
      _$RatingCountFromJson(json);
  Map<String, dynamic> toJson() => _$RatingCountToJson(this);
}
