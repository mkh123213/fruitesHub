class OrderTrack {
  final String uid;
  final String date;
  final String? svgImg;
  final int currentStep;
  final int orderCounts;
  final double totalPrice;

  OrderTrack({
    required this.orderCounts,
    required this.totalPrice,
    required this.currentStep,
    required this.uid,
    required this.date,
    this.svgImg,
  });
}

List<OrderTrack> getDummyTrackList() {
  return List.generate(
    5,
    (index) => OrderTrack(
      uid: "uid-$index",
      date: DateTime.now().toIso8601String(),
      svgImg: null,
      currentStep: index,
      orderCounts: 5,
      totalPrice: 100.0 * (index + 1),
    ),
  );
}
