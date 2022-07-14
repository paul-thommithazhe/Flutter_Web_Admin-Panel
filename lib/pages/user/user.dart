import 'package:admin_panel_take_it/widgets/custom_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: (DataTable2(
        columnSpacing: 5,
        horizontalMargin: 0,
        minWidth: 100,
        columns: const [
          DataColumn2(
            label: Text('Index'),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text('Name'),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text('User ID'),
          ),
          DataColumn(
            label: Text('Email'),
          ),
          DataColumn(
            label: Text('Phone Number'),
          ),
          DataColumn(
            label: Text('Status'),
          ),
          DataColumn(
            label: Text('Block/ UnBlock'),
          ),
        ],
        rows: List<DataRow>.generate(
          10,
          (index) => DataRow(
            cells: [
              DataCell(Text(index.toString())),
              DataCell(Text('Thushad T')),
              DataCell(Text('dhufuifdfs ')),
              DataCell(Text('thush@gmail.com')),
              DataCell(Text('31234567890')),
              DataCell(Text('active')),
              DataCell(ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {},
                child: Text('Block'),
              )),
            ],
          ),
        ),
      )),
    );
  }
}
