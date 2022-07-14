import 'package:admin_panel_take_it/constants/style.dart';
import 'package:admin_panel_take_it/widgets/custom_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

final TextEditingController couponNameController = TextEditingController();

final TextEditingController couponOfferController= TextEditingController();



final formCouponKey = GlobalKey<FormState>();

class CouponPage extends StatelessWidget {
  const CouponPage({Key? key}) : super(key: key);

  openCouponDialog(context) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
                    decoration: InputDecoration(
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
                            print('form is valid');
                          } else {
                            print('not valid');
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                        style:
                            ElevatedButton.styleFrom(fixedSize: Size(150, 40)),
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
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  openCouponDialog(context);
                },
                child: Text('Add Coupon'),
              )
            ],
          ),
          Expanded(
            child: DataTable2(
              columnSpacing: 5,
              horizontalMargin: 0,
              minWidth: 100,
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
                10,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text('takeitgo4545')),
                    DataCell(Text('dfdfdf')),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
