import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaffet/my depot/shared/cubit/cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  // required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  bool readOnly = false,
  String? Function(String? value)? validate,
}) =>
    TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

Widget buildTotalItems(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
              'My Depot',
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
      Padding(
        padding: const EdgeInsets.only(top: 30,right: 10,left: 10),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Balance'),
                const SizedBox(
                  height: 7,
                ),
                Text(
                    AppCubit.getListen(context).totalResult.toStringAsFixed(3)),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            Text(
              'Stocks',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              'view all',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildDepotItems(
  Map model,
  BuildContext context, {
  required List<Map> tasks,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[800]),
            ),
            const SizedBox(width: 10),
            Text(
              '${model['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 80,
            ),
            Text(
              '${model['type']}',
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              width: 52,
            ),
            Text(
              '${model['gram']}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget tasksBuilderName({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              buildDepotItems(tasks[index], context, tasks: []),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.menu,
                size: 60,
                color: Colors.grey,
              ),
              Text(
                'Nothing to see',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
