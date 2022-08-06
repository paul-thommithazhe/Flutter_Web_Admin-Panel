import 'package:admin_panel_take_it/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          //dialog box for adding the data
                         
                        },
                        child: const Text(
                          'Add Product',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
                kHeight20,
                Expanded(
                  flex: 5,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DataTable2(
                        columnSpacing: 2,
                        horizontalMargin: 50,
                        minWidth: 100,
                        columns: const [
                          DataColumn2(
                            label: Text('Index'),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('User'),
                          ),
                          DataColumn(
                            label: Text('prodcut'),
                          ),
                          DataColumn(
                            label: Text('Quantity'),
                          ),
                          DataColumn(
                            label: Text('Price'),
                          ),
                          DataColumn(
                            label: Text('Delivered Status'),
                          ),
                          
                        ],
                        rows: List<DataRow>.generate(
                          snapshot.data!.docs.length,
                          (index) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(index.toString()),
                                ),
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.network(
                                        snapshot.data!.docs[index]['image']),
                                  ),
                                ),
                                DataCell(
                                  Text(snapshot.data!.docs[index]['name']),
                                ),
                                DataCell(Text(snapshot
                                    .data!.docs[index]['price']
                                    .toString())),
                                DataCell(
                                  Text(snapshot.data!.docs[index]['quantity']
                                      .toString()),
                                ),
                                DataCell(
                                  Text(snapshot.data!.docs[index]['offer']
                                      .toString()),
                                ),
                               
                              
                               
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
