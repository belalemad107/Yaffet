import 'dart:convert';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:yaffet/my depot/shared/cubit/states.dart';
import 'package:yaffet/my depot/todo_app/shared/component.dart';
import 'package:yaffet/my depot/todo_app/task/task_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared/cubit/cubit.dart';

class BottomNavigation extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var typeController = TextEditingController();
  var dateController = TextEditingController();
  var titleController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          var x = AppCubit.get(context).result;
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              body: ConditionalBuilder(
                condition: state is! AppGetDataBaseLoadingState,
                builder: (context) => TaskScreen(),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                  child: Icon(cubit.fabIcon),
                  onPressed: () async {
                    if (cubit.isBottomSheet) {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        bool res = await cubit.insertToDatabase(
                          name: titleController.text,
                          type: AppCubit.get(context).selectedChartItem,
                          gram: titleController2.text,
                          price:
                              AppCubit.get(context).result.toStringAsFixed(3),
                        );

                        if (res) {
                          AppCubit.get(context)
                              .addToTotal(AppCubit.get(context).result);
                          titleController.clear();
                          titleController2.clear();
                        }
                      }
                    } else {
                      scaffoldKey.currentState
                          ?.showBottomSheet(
                              (context) => Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(20),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          defaultFormField(
                                            readOnly: false,
                                            controller: titleController,
                                            type: TextInputType.text,
                                            validate: (String? value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return 'gram must be not empty';
                                              }
                                              return null;
                                            },
                                            label: 'Name',
                                            prefix: Icons.title,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                iconEnabledColor: Colors.black,
                                                dropdownColor: Colors.white,
                                                style: const TextStyle(
                                                    // color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                value: AppCubit.get(context)
                                                    .selectedChartItem,
                                                onChanged: (value) {
                                                  AppCubit.get(context)
                                                          .selectedChartItem =
                                                      value.toString();
                                                },
                                                items: AppCubit.get(context)
                                                    .chartItems
                                                    .map((item) {
                                                  return DropdownMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            item,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const SizedBox(
                                                            width: 100,
                                                          ),
                                                        ],
                                                      ),
                                                      value: item);
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          if (AppCubit.get(context)
                                                  .selectedChartItem ==
                                              'Gold')
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              height: 60,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  underline: const SizedBox(),
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  dropdownColor: Colors.white,
                                                  style: const TextStyle(
                                                      // color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  value: AppCubit.get(context)
                                                      .selectedGoldPrice,
                                                  onChanged: (value) {
                                                    AppCubit.get(context)
                                                            .selectedGoldPrice =
                                                        value.toString();
                                                  },
                                                  items: AppCubit.get(context)
                                                      .GoldDurations
                                                      .map((item) {
                                                    return DropdownMenuItem(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              item,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            const SizedBox(
                                                              width: 100,
                                                            ),
                                                          ],
                                                        ),
                                                        value: item);
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          defaultFormField(
                                              readOnly: false,
                                              controller: titleController2,
                                              type: TextInputType.phone,
                                              validate: (String? value) {
                                                if (value != null &&
                                                    value.isEmpty) {
                                                  return 'gram must be not empty';
                                                }
                                                return null;
                                              },
                                              label: 'gram',
                                              prefix: Icons.title),
                                          TextButton(
                                            onPressed: () {
                                              AppCubit.get(context).calculation(
                                                  double.parse(
                                                      titleController2.text));
                                            },
                                            child: Text('Price'),
                                          ),
                                          Text(
                                              'Your Money ${BlocProvider.of<AppCubit>(context, listen: true).result.toStringAsFixed(3)}'),
                                        ],
                                      ),
                                    ),
                                  ),
                              elevation: 20)
                          .closed
                          .then((value) {
                        cubit.changeBottomSheetState(
                            isShow: false, icon: Icons.done);
                      });

                      cubit.changeBottomSheetState(
                          isShow: true, icon: Icons.add);
                    }
                  }),
            ),
          );
        },
      ),
    );
  }
}
