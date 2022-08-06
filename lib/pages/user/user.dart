import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  const DataCell(Text('Thushad T')),
                  const DataCell(Text('dhufuifdfs ')),
                  const DataCell(Text('thush@gmail.com')),
                  const DataCell(Text('31234567890')),
                  const DataCell(Text('active')),
                  DataCell(ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {},
                    child: Text('Block'),
                  ),),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
