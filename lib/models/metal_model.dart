class MetalPriceDataModel {
  late String metalName;
  late double metalPrice;
  late DateTime date;
  late String name;

  MetalPriceDataModel(
      {required this.metalName,
      required this.metalPrice,
      required this.date,
      required this.name});

  factory MetalPriceDataModel.fromJson(Map<String, dynamic> json) {
    return MetalPriceDataModel(
      metalName: json['metalName'],
      metalPrice: double.parse(json['metalPrice'].toString()),
      date: DateTime.parse(json['date']),
      name: json['name'],
    );
  }
}
