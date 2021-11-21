class PlatinumPriceData {
  late int id;
  late String metalName;
  late double metalPrice;
  late DateTime date;
  late String created_at;
  late String updated_at;
  late String name;

  PlatinumPriceData(
      {required this.id,
      required this.metalName,
      required this.metalPrice,
      required this.date,
      required this.created_at,
      required this.updated_at,
      required this.name});

  factory PlatinumPriceData.fromJson(Map<String, dynamic> json) {
    return PlatinumPriceData(
      id: int.parse(json['id'].toString()),
      metalName: json['metalName'],
      metalPrice: double.parse(json['metalPrice'].toString()),
      date: DateTime.parse(json['date']),
      updated_at: json['updated_at'],
      created_at: json['created_at'],
      name: json['name'],
    );
  }
}
