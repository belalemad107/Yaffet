import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:time/time.dart';
import 'package:yaffet/models/metal_model.dart';
import 'package:yaffet/my depot/shared/cubit/cubit.dart';
import 'package:yaffet/my depot/shared/cubit/states.dart';

class GeneralChartScreen extends StatelessWidget {
  const GeneralChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return WillPopScope(
            onWillPop: () async {
              if (isDialOpen.value) {
                isDialOpen.value = false;
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
                //  drawer: buildDrawer(context),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: const Text(
                    'Chart',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  iconTheme: const IconThemeData(color: Colors.black),
                  // flexibleSpace: Container(
                  //   decoration: BoxDecoration(
                  //       color: selectedChartItem.toLowerCase() == "gold"
                  //           ? const Color.fromRGBO(233, 208, 105, 1)
                  //           : selectedChartItem.toLowerCase() == "silver"
                  //               ? Colors.grey
                  //               : selectedChartItem.toLowerCase() == "platinum"
                  //                   ? Colors.orange
                  //                   : null,
                  //       borderRadius: const BorderRadius.only(
                  //         bottomLeft: Radius.circular(20),
                  //         bottomRight: Radius.circular(20),
                  //       )),
                  // ),
                  // actions: const [
                  //   Icon(
                  //     Icons.settings,
                  //     color: Colors.black,
                  //   )
                  // ],
                ),
                body: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          // gradient: const LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.topRight,
                          //   colors: [
                          //     Colors.blue,
                          //     Colors.white,
                          //   ],
                          // ),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      width: MediaQuery.of(context).size.width - 180,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          iconEnabledColor: Colors.white,
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          value: AppCubit.getListen(context).selectedChartItem,
                          onChanged: (value) {
                            AppCubit.get(context).ChangeTypeChart(value);

                            AppCubit.get(context).getData(
                                type: AppCubit.get(context).selectedChartItem);
                          },
                          items: AppCubit.get(context).chartItems.map((item) {
                            return DropdownMenuItem(
                                child: Row(
                                  children: [
                                    Text(item),
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
                    // FLoatingAction Button Select Currency $ type
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Positioned(
                              top: 20,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 10,
                                height: 120,
                                color: Colors.white,
                                child: ListTile(
                                    contentPadding: const EdgeInsets.all(16),
                                    title: Text(
                                      AppCubit.get(context).selectedChartItem,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        getTrailingWidget(context),
                                      ],
                                    )),
                              )),
                          Positioned(
                            child: Stack(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: SpeedDial(
                                    direction: SpeedDialDirection.down,
                                    icon: Icons.twenty_two_mp_rounded,
                                    activeIcon: Icons.twenty_two_mp_rounded,
                                    animatedIcon: AnimatedIcons.pause_play,
                                    openCloseDial: isDialOpen,
                                    backgroundColor: Colors.white,
                                    overlayOpacity: 0.5,
                                    foregroundColor: Colors.black,
                                    spacing: 5,
                                    spaceBetweenChildren: 5,
                                    closeManually: true,
                                    children: [
                                      SpeedDialChild(
                                          // child: AnimatedIcon(
                                          //   progress: AnimationController(
                                          //     vsync: this,
                                          //   ),
                                          //   icon: AppCubit.getListen(context)
                                          //       .currencyIcons['yen']!,
                                          // ),
                                          label: 'Yen',
                                          labelBackgroundColor:
                                              const Color(0xff007FEB),
                                          onTap: () {
                                            print('Yen Tapped');
                                            AppCubit.get(context)
                                                .changePrice("JPY");
                                          }),
                                      SpeedDialChild(
                                          // child: Icon(
                                          //     AppCubit.getListen(context)
                                          //         .currencyIcons['Pound']),
                                          labelBackgroundColor:
                                              const Color(0xff007FEB),
                                          label: 'Pound',
                                          onTap: () {
                                            print('Mail Tapped');
                                            AppCubit.get(context)
                                                .changePrice("EUR");
                                          }),
                                      SpeedDialChild(
                                          // child: Icon(
                                          //     AppCubit.getListen(context)
                                          //         .currencyIcons['Lira']),
                                          label: 'Lira',
                                          labelBackgroundColor:
                                              const Color(0xff007FEB),
                                          onTap: () {
                                            print('Copy Tapped');
                                            AppCubit.get(context)
                                                .changePrice("EGP");
                                          }),
                                      SpeedDialChild(
                                          // child: Icon(
                                          //     AppCubit.getListen(context)
                                          //         .currencyIcons['Euro']),
                                          label: 'Euro',
                                          labelBackgroundColor:
                                              const Color(0xff007FEB),
                                          onTap: () {
                                            print('Copy Tapped');
                                            AppCubit.get(context)
                                                .changePrice("QAR");
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 40,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: SpeedDial(
                                direction: SpeedDialDirection.down,
                                animatedIcon: AnimatedIcons.menu_close,
                                backgroundColor: Colors.white,
                                overlayOpacity: 0.5,
                                foregroundColor: Colors.black,
                                spacing: 5,
                                spaceBetweenChildren: 5,
                                closeManually: true,
                                children: [
                                  SpeedDialChild(
                                      child: const Icon(
                                        Icons.share_rounded,
                                      ),
                                      label: 'Yen',
                                      labelBackgroundColor:
                                          const Color(0xff007FEB),
                                      onTap: () {
                                        print('Share Tapped');
                                      }),
                                  SpeedDialChild(
                                      child: const Icon(Icons.mail),
                                      labelBackgroundColor:
                                          const Color(0xff007FEB),
                                      label: 'Pound',
                                      onTap: () {
                                        print('Mail Tapped');
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                AppCubit.get(context).charDurations.length,
                            itemBuilder: (context, index) =>
                                AppCubit.get(context).buildTimeWidget(
                                    durationLabel: AppCubit.get(context)
                                        .charDurations[index]),
                          ),
                        )),
                    Container(
                      height: MediaQuery.of(context).size.height - 250,
                      child: SfCartesianChart(
                          zoomPanBehavior: ZoomPanBehavior(
                              // Enables pinch zooming
                              enablePanning: true,
                              enablePinching: true,
                              zoomMode: ZoomMode.x),
                          primaryXAxis: CategoryAxis(minimum: 1, maximum: 30),
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<MetalPriceDataModel, String>>[
                            AreaSeries<MetalPriceDataModel, String>(
                                dataSource: AppCubit.get(context).filteredList,
                                xValueMapper: (MetalPriceDataModel sales, _) =>
                                    DateFormat("dd MMM").format(sales.date),
                                /* dataLabelMapper: (MetalPriceDataModel sales, _) =>
                                sales.metalPrice.toString() +
                                " @ " +
                                DateFormat("dd MMM yy hh:mm").format(sales.date),*/
                                yValueMapper: (MetalPriceDataModel sales, _) =>
                                    sales.metalPrice,
                                borderWidth: 2,
                                // onPointTap:
                                //     (ChartPointDetails chartPointDetails) {
                                //   chartPointDetails.dataPoints;
                                // },
                                gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.blue,
                                    Colors.white,
                                  ],
                                ),
                                borderColor: Colors.blue,

                                // AppCubit.get(context)
                                //             .selectedChartItem
                                //             .toLowerCase() ==
                                //         "gold"
                                //     ? Colors.blue
                                //     : AppCubit.get(context).selectedChartItem.toLowerCase() ==
                                //             "silver"
                                //         ? Colors.blue
                                //         : AppCubit.get(context)
                                //                     .selectedChartItem
                                //                     .toLowerCase() ==
                                //                 "platinum"
                                //             ? Colors.blue
                                //             : null,
                                name: '',
                                color: AppCubit.get(context)
                                            .selectedChartItem
                                            .toLowerCase() ==
                                        "gold"
                                    ? const Color.fromRGBO(233, 208, 105, 1)
                                    : AppCubit.get(context)
                                                .selectedChartItem
                                                .toLowerCase() ==
                                            "silver"
                                        ? Colors.grey[400]
                                        : AppCubit.get(context)
                                                    .selectedChartItem
                                                    .toLowerCase() ==
                                                "platinum"
                                            ? Colors.blue
                                            : null,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false)),
                          ]),
                    ),
                  ]),
                )),
          );
        },
      ),
    );
  }

  Widget getTrailingWidget(BuildContext context) {
    if (AppCubit.get(context).selectedChartItem.toLowerCase() == "gold") {
      return SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('24k'),
                Icon(Icons.ac_unit),
                Text("3.321,31")
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('24k'),
                Icon(Icons.ac_unit),
                Text("3.321,31")
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('24k'),
                Icon(Icons.ac_unit),
                Text("3.321,31")
              ],
            )
          ],
        ),
      );
    } else if (AppCubit.get(context).selectedChartItem.toLowerCase() ==
        "platinum") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: const [Text("3.321,31")],
      );
    } else if (AppCubit.get(context).selectedChartItem.toLowerCase() ==
        "silver") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: const [Text("3.321,31")],
      );
    } else {
      return const Text("--");
    }
  }
}
