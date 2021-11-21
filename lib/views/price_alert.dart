import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yaffet/models/metal_model.dart';

class PriceAlert extends StatefulWidget {
  const PriceAlert({Key? key}) : super(key: key);

  @override
  _PriceAlertState createState() => _PriceAlertState();
}

class _PriceAlertState extends State<PriceAlert> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
  }

  // Future submitData() async {
  //   var response = await http.post(
  //       Uri.https('yaffet.com',
  //           '/mobile/api/userPrice'),
  //       body: {
  //         'price': priceController.text,
  //       });
  //   if (response.statusCode == 200) {
  //     print('data inserted');
  //   } else {
  //     print('data not been inserted');
  //   }
  // }
  // late MetalPriceDataModel metalData ;

  int count = 663;
  List bullionList = ['Gold', 'Silver', 'Platinum'];
  List currencyList = ['Pounds', 'Dollars', 'Euros'];
  List unitsList = ['Troy Oz', 'Killos'];
  String selectedBullion = 'Gold';
  String? selectedCurrency = 'Pounds';
  String? selectedUnits = 'Troy Oz';
  // var priceController =  TextEditingController(text: '$count');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                    const Text(
                      'Price Alert',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.save_alt_sharp,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width - 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Bullion',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 50,
                              ),
                              DropdownButton(
                                underline: SizedBox(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBullion = value.toString();
                                  });
                                },
                                items: bullionList
                                    .map((item) => DropdownMenuItem(
                                          child: Row(
                                            children: [
                                              Text(item),
                                              SizedBox(
                                                width: 50,
                                              ),
                                            ],
                                          ),
                                          value: item,
                                        ))
                                    .toList(),
                                value: selectedBullion,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Divider(),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Currency',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 50,
                              ),
                              DropdownButton(
                                underline: SizedBox(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCurrency = value.toString();
                                  });
                                },
                                items: currencyList
                                    .map((item) => DropdownMenuItem(
                                          child: Row(
                                            children: [
                                              Text(item),
                                              SizedBox(
                                                width: 60,
                                              ),
                                            ],
                                          ),
                                          value: item,
                                        ))
                                    .toList(),
                                value: selectedCurrency,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Divider(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Weight Units',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 50,
                              ),
                              DropdownButton(
                                underline: SizedBox(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedUnits = value.toString();
                                  });
                                },
                                items: unitsList
                                    .map((item) => DropdownMenuItem(
                                          child: Row(
                                            children: [
                                              Text(item),
                                              SizedBox(
                                                width: 60,
                                              ),
                                            ],
                                          ),
                                          value: item,
                                        ))
                                    .toList(),
                                value: selectedUnits,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Divider(),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Price Per Oz',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 50,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                width: 30,
                                height: 30,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                       // int.parse(priceController.text)+1;
                                        count--;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 70,
                                  height: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return ('you should insert value');
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller:
                                          TextEditingController(text: '$count'),

                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      // int.parse(priceController.text)-1;
                                      count--;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Center(child: Text('Gold spot price: E1,313,oz')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 140,
              ),
              Card(
                color: Colors.blue,
                child: Container(
                  width: MediaQuery.of(context).size.width - 25,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(80)),
                  child: TextButton(
                    child: const Text(
                      'Set Alert',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      String? token =
                          await FirebaseMessaging.instance.getToken();
                      print('this is token ' + token!);
                      // int price = controller;
                      // submitData();
                      // MetalPriceDataModel? data = await submitData(price: price);
                      // setState(() {
                      //   metalData = data!;
                      // });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
