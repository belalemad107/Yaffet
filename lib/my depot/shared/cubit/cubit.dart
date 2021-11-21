import 'dart:convert';
import 'package:yaffet/models/metal_model.dart';
import 'package:yaffet/my depot/shared/cubit/states.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:time/src/extensions.dart';
import '../../last_price.dart';
import '../../todo_app/task/task_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  Map<String, AnimatedIconData> currencyIcons = {
    "yen": AnimatedIcons.pause_play,
    "Pound": AnimatedIcons.home_menu,
    "Lira": AnimatedIcons.add_event,
    "Euro": AnimatedIcons.search_ellipsis,
  };

  AppCubit() : super(AppInitialState()) {
    selectedDurationLabel = charDurations[0];
    getData();
    getCurrencyPriceDataModel();
    getLastPrice();
  }

  static AppCubit get(context) => BlocProvider.of(context);

  static AppCubit getListen(context) => BlocProvider.of(context, listen: true);

  int currentIndex = 0;

  List<Widget> screens = [
    TaskScreen(),
  ];

  List<String> chartItems = ['Gold', 'Silver', 'Platinum'];
  double goldPrice = 0;
  double platinumPrice = 0;
  double silverPrice = 0;
  String selectedChartItem = 'Silver';
  String selectedGoldPrice = '18';
  double result = 0;
  double totalResult = 0;

  List<String> GoldDurations = [
    ("24"),
    ("21"),
    ("18"),
  ];

  void calculation(num) {
    print('calculation');
    if (selectedChartItem == 'Gold' && selectedGoldPrice == '24') {
      result = goldPrice * num / (31.1034768);
    }
    if (selectedChartItem == 'Gold' && selectedGoldPrice == '21') {
      result = goldPrice * num * .875 / 31.1034768;
    }
    if (selectedChartItem == 'Gold' && selectedGoldPrice == '18') {
      result = goldPrice * num * .75 / (31.1034768);
    }
    if (selectedChartItem == 'Silver') {
      result = silverPrice / 31.1034768;
    }
    if (selectedChartItem == 'Platinum') {
      result = platinumPrice / 31.1034768;
    }
    emit(AppChangeCalculateState());

    print('Result : $result');
  }

  void addToTotal(num) {
    totalResult += num;
    emit(AppChangeTotalResultState());
  }

  void subtractFromTotal(num) {
    totalResult -= num;
    emit(AppChangeTotalResultState());
    getDataFromDataBase(database);
  }

  late String selectedDurationLabel;

  Future<http.Response> getLastPrice() async {
    http.Response metaPrice =
        await http.get(Uri.parse('https://yaffet.com/mobile/api/getLastprice'));
    print('csdcsdc' + metaPrice.statusCode.toString());
    if (metaPrice.statusCode == 200) {
      var priceMap = jsonDecode(metaPrice.body);

      print("resMap = $priceMap");
      List<dynamic> temp = priceMap as List;
      List<GetLastPrice> list = [];
      list = temp
          .map((e) => GetLastPrice.fromJson(e as Map<String, dynamic>))
          .toList();
      goldPrice =
          list.singleWhere((element) => element.name == 'GOLD').metalPrice;
      silverPrice =
          list.singleWhere((element) => element.name == 'SILVER').metalPrice;
      platinumPrice =
          list.singleWhere((element) => element.name == 'PLATINUM').metalPrice;
      print(list[0]);
      emit(BlocChangeState());
    }
    return http.Response("Error", metaPrice.statusCode);
  }

  late Database database;

  List<Map> newTasks = [];

  void createDatabase() {
    openDatabase(
      'yaffet.db',
      version: 1,
      onCreate: (database, version) {
        print('DataBase Created');
        database
            .execute(
                'CREATE TABLE yaffet (id INTEGER PRIMARY KEY ,name TEXT ,type TEXT ,gram TEXT,price TEXT ,status TEXT  )')
            .then((value) {
          print('Inserted Created');
        }).catchError((error) {
          print('Error when creating table $error.toString()');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print('DataBase Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future<bool> insertToDatabase({
    required String name,
    required String type,
    required String gram,
    required String price,
  }) async {
    return database.transaction((txn) async {
      return txn
          .rawInsert(
              'INSERT INTO yaffet (name,type,gram,price,status) VALUES ("$name","$type","$gram","$price","new")')
          .then((value) {
        print('Inserted to db');
        emit(AppInsertDataBaseState());
        getDataFromDataBase(database);
        return true;
      }).catchError((error) {
        print('Error when Insert  db $error.toString()');
        return false;
      });
    });
  }

  void getDataFromDataBase(database) {
    newTasks = [];
    double sum = 0;

    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM yaffet').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
          sum += double.parse(element['price']);
        }
      });
      totalResult = sum;
      emit(AppGetDataBaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE yaffet SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseLoadingState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM yaffet WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBaseLoadingState());
    });
  }

  bool isBottomSheet = false;
  IconData fabIcon = Icons.add;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }

////// General Chart Screen

  List<MetalPriceDataModel> data = [];
  List<MetalPriceDataModel> filteredList = [];
  List<String> charDurations = [
    ("1h"),
    ("6h"),
    ("1d"),
    ("1m"),
    ("1y"),
  ];
  // late CurrencyPriceDataModel modelCurrency;
  late String selectChartType;
  late MetalPriceDataModel model;
  late double yen = 0;
  late double pound = 0;
  late double lira = 0;
  late double euro = 0;
  String selctedCurrency = '';

  Map<String, String> apiMap = {
    "gold": 'https://yaffet.com/mobile/api/getHistPrice/gold',
    "silver": 'https://yaffet.com/mobile/api/getHistPrice/silver',
    "platinum": 'https://yaffet.com/mobile/api/getHistPrice/platinum',
  };

  void ChangeTypeChart(value) {
    selectedChartItem = value.toString();
    emit(AppChangeGoldChartState());
  }

  buildTimeWidget({required String durationLabel}) {
    return InkWell(
      onTap: () {
        DateTime now = DateTime.now();
        Duration dur = 1.hours;
        selectedDurationLabel = durationLabel;
        switch (selectedDurationLabel) {
          case "1h":
            dur = 1.hours;
            break;
          case "6h":
            dur = 6.hours;
            break;
          case "1d":
            dur = 24.hours;
            break;
          case "1m":
            dur = 30.days;
            break;
          case "1y":
            dur = 365.days;
            break;
        }
        var x = now - dur;
        filteredList =
            data.where((element) => element.date.isAfter(x)).toList();
        emit(AppChangeTimeChartState());
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Container(
          width: 50,
          height: 35,
          decoration: BoxDecoration(
            color: selectedDurationLabel == durationLabel
                ? Colors.black
                : selectedChartItem.toLowerCase() == "gold"
                    ? const Color.fromRGBO(233, 208, 105, 1)
                    : selectedChartItem.toLowerCase() == "silver"
                        ? Colors.grey
                        : selectedChartItem.toLowerCase() == "platinum"
                            ? Colors.orange
                            : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              durationLabel,
              style: TextStyle(
                  color: selectedDurationLabel == durationLabel
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response?> getData({String type = "gold"}) async {
    type = type.toLowerCase();
    http.Response futureGet = await http.get(Uri.parse(apiMap[type]!));
    if (futureGet.statusCode == 200) {
      var resMap = jsonDecode(futureGet.body);
      if (resMap[type] != null) {
        List<dynamic> temp = resMap[type];
        data = temp
            .map((e) => MetalPriceDataModel.fromJson(e as Map<String, dynamic>))
            .toList();
        filteredList = data;
        // setState(() {});
      } else {
        print("Data is null");
      }
    } else {
      throw Exception('can\'t load platinum data');
    }
  }

  Future<http.Response?> getCurrencyPriceDataModel() async {
    http.Response getCurrency = await http
        .get(Uri.parse('https://yaffet.com/mobile/api/getLastCurrency'));
    if (getCurrency.statusCode == 200) {
      var resMap = jsonDecode(getCurrency.body);
      print("resMap = $resMap");
      List<dynamic> temp = resMap as List;

      yen = temp.singleWhere(
          (element) => element['currency_code'] == 'ZMK')['price_rate'];
    } else {
      throw Exception('can\'t load currency data');
    }
  }

  void changePrice(String s) {
    selctedCurrency = s;
    filteredList = data; //USD
    for (var element in filteredList) {
      if (selctedCurrency == "JPY") {
        element.metalPrice *= yen;
      }
      if (selctedCurrency == "EUR") {
        element.metalPrice *= euro;
      }
      if (selctedCurrency == "EGP") {
        element.metalPrice *= pound;
      }
      if (selctedCurrency == "QAR") {
        element.metalPrice *= lira;
      }
    }
    emit(AppChangeCurrencyState());
  }
}
