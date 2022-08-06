import 'package:admin_panel_take_it/constants/style.dart';

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<PieChartSectionData> data = [
    PieChartSectionData(title: 'A', color: Colors.red),
    PieChartSectionData(title: 'B', color: Colors.green),
    PieChartSectionData(title: 'C', color: Colors.blue),
    PieChartSectionData(title: 'D', color: Colors.yellow),
    PieChartSectionData(title: 'E ', color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomPageGrids(
                  title: 'TOTAL USERS',
                  number: 10,
                ),
                HomPageGrids(
                  title: 'TOTAL ORDERS',
                  number: 10,
                ),
                HomPageGrids(
                  title: 'TOTAL PRODUCTS',
                  number: 10,
                ),
              ],
            ),
            kHeight20,
          ],
        ),
      ),
    );
  }
}

class HomPageGrids extends StatelessWidget {
  HomPageGrids({
    Key? key,
    required this.title,
    required this.number,
    this.color,
  }) : super(key: key);

  final String title;
  final int number;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 250,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 24, 141, 236),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              number.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            )
          ],
        ),
      ),
    );
  }
}
