import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool checkboxValue = true;
  List<String> weightUnitsList = ['Troy oz', 'Killos'];
  List<String> currancyList = ['Dollars', 'Pounds', 'Euros'];
  List<String> karatList = ['24K', '21K', '18K'];
  String selectedKarat = '24K';
  String selectedCurrancy = 'Dollars';
  String selectedUnit = 'Troy oz';
  List<String> languages = [
    'English',
    'Arabic',
    'Germany',
    'Italy',
    'Spanish',
    'Frensh'
  ];
  String selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(children: [
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
                'Settings',
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
          height: 100,
        ),
        Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Language',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                      DropdownButton(
                          underline: const SizedBox(),
                          // style: const TextStyle(
                          //     fontSize: 18, fontWeight: FontWeight.bold),
                          value: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value.toString();
                            });
                          },
                          items: languages
                              .map((item) => DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 150,
                                        ),
                                        Text(item),
                                        SizedBox(
                                          width: 7,
                                        ),
                                      ],
                                    ),
                                    value: item,
                                  ))
                              .toList()),
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
                        child: Container(
                          child: Center(
                            child: Text(
                              'Weight Units',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      DropdownButton(
                          underline: const SizedBox(),
                          // style: const TextStyle(
                          //     fontSize: 18, fontWeight: FontWeight.bold),
                          value: selectedUnit,
                          onChanged: (value) {
                            setState(() {
                              selectedUnit = value.toString();
                            });
                          },
                          items: weightUnitsList
                              .map((item) => DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 150,
                                        ),
                                        Text(item),
                                        SizedBox(
                                          width: 17,
                                        )
                                      ],
                                    ),
                                    value: item,
                                  ))
                              .toList()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Default Currency',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),

                        ),

                      ),
                      DropdownButton(
                          underline: const SizedBox(),
                          // style: const TextStyle(
                          //     fontSize: 18, fontWeight: FontWeight.bold),
                          value: selectedCurrancy,
                          onChanged: (value) {
                            setState(() {
                              selectedCurrancy = value.toString();
                            });
                          },
                          items: currancyList
                              .map((item) => DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 140,
                                        ),
                                        Text(item),
                                        SizedBox(width: 5,),
                                      ],
                                    ),
                                    value: item,
                                  ))
                              .toList()),
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
                            'Karat',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),

                        ),

                      ),
                      DropdownButton(
                          underline: const SizedBox(),
                          // style: const TextStyle(
                          //     fontSize: 18, fontWeight: FontWeight.bold),
                          value: selectedKarat,
                          onChanged: (value) {
                            setState(() {
                              selectedKarat = value.toString();
                            });
                          },
                          items: karatList
                              .map((item) => DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 180,
                                        ),
                                        Text(item),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    value: item,
                                  ))
                              .toList()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 130,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Push Notification',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),

                        ),

                      ),
                      SizedBox(
                        width: 115,
                      ),
                      Checkbox(
                          value: checkboxValue,
                          onChanged: (value) {
                            setState(() {
                              checkboxValue = value!;
                            });
                          }),
                      Text(
                        checkboxValue == true ? 'Enabled' : 'Disabled',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ))
      ]),
    )));
  }
}
