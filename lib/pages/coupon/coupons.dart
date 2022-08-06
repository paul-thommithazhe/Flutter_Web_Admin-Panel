import 'dart:developer';

import 'package:admin_panel_take_it/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

final TextEditingController couponNameController = TextEditingController();

final TextEditingController couponOfferController = TextEditingController();

final formCouponKey = GlobalKey<FormState>();

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key}) : super(key: key);

  openCouponDialog(context) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // contentPadding: EdgeInsets.all(10),
          title: const Text('Add Coupon'),
          content: SizedBox(
            width: 600,
            child: Form(
              key: formCouponKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Enter  the coupon';
                      }
                      return null;
                    },
                    controller: couponNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Coupon Name'),
                  ),
                  kHeight20,
                  TextFormField(
                    validator: (couponOffer) {
                      if (couponOffer == null || couponOffer.isEmpty) {
                        return 'Enter  the offer';
                      }
                      return null;
                    },
                    controller: couponOfferController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Offer'),
                  ),
                  kHeight20,
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final form = formCouponKey.currentState;
                          if (form!.validate()) {
                            log('form is valid');
                            Map<String, dynamic> data = {
                              'coupon': couponNameController.text,
                              'offer': couponOfferController.text,
                            };
                            FirebaseFirestore.instance
                                .collection('coupon')
                                .doc()
                                .set(data);
                                Navigator.pop(context);
                          } else {
                            log('not valid');
                          }
                        },
                        style:
                            ElevatedButton.styleFrom(fixedSize: Size(150, 40)),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('coupon').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        
                        onPressed: () {
                          openCouponDialog(context);
                        },
                        child: const Text('Add Coupon'),
                      ),
                    )
                  ],
                ),
                kHeight20,
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DataTable2(
                        columnSpacing: 5,
                        horizontalMargin: 0,
                        minWidth: 20,
                        columns: const [
                          DataColumn2(
                            label: Text('Index'),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('Coupon'),
                          ),
                          DataColumn(
                            label: Text('Offer'),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          snapshot.data!.docs.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text(index.toString())),
                              DataCell(Text(snapshot.data!.docs[index]['coupon']
                                  .toString())),
                              DataCell(Text(snapshot.data!.docs[index]['offer']
                                  .toString())),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
