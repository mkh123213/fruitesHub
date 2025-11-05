import 'package:ecommercefruiteshub/core/models/review_model.dart';

num getAvgRating(List<ReviewModel> reviews) {
  final sum = reviews.fold<num>(
    0,
    (previousValue, element) => previousValue + element.ratting,
  );

  return sum / reviews.length;
}
