class GetLastPrice {
  String metalName;
  double metalPrice;
  DateTime date;
  String name;

  GetLastPrice(
      {required this.metalName,
      required this.metalPrice,
      required this.date,
      required this.name});

  factory GetLastPrice.fromJson(Map<String, dynamic> json) {
    return GetLastPrice(
      metalName: json['metalName'],
      metalPrice: double.parse(json['metalPrice'].toString()),
      date: DateTime.parse(json['date']),
      name: json['name'],
    );
  }
}
