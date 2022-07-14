import 'package:admin_panel_take_it/constants/style.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);

  final TextEditingController productNameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController sizeController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController offerController = TextEditingController();

  final formProductKey = GlobalKey<FormState>();

  int initialOfferValue = 0;

  // dialog box for adding the product date detials
  openDialog(context) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // contentPadding: EdgeInsets.all(10),
          title: const Text('Add Product'),
          content: SizedBox(
            width: 600,
            child: Form(
              key: formProductKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Enter  the name';
                      }
                      return null;
                    },
                    controller: productNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Product Name'),
                  ),
                  kHeight20,
                  TextFormField(
                    validator: (price) {
                      if (price == null || price.isEmpty) {
                        return 'Enter  the Price';
                      }
                      return null;
                    },
                    controller: priceController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Price'),
                  ),
                  kHeight20,
                  TextFormField(
                    validator: (stock) {
                      if (stock == null || stock.isEmpty) {
                        return 'Enter  the stock';
                      }
                      return null;
                    },
                    controller: stockController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Stock'),
                    keyboardType: TextInputType.number,
                  ),
                  kHeight20,
                  TextFormField(
                    validator: (price) {
                      if (price == null || price.isEmpty) {
                        return 'Enter  the Brand';
                      }
                      return null;
                    },
                    controller: brandController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Brand'),
                  ),
                  kHeight20,
                  TextFormField(
                    validator: (size) {
                      if (size == null || size.isEmpty) {
                        return 'Enter  the Size';
                      }
                      return null;
                    },
                    controller: sizeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Size'),
                  ),
                  kHeight20,
                  TextFormField(
                    validator: (description) {
                      if (description == null || description.isEmpty) {
                        return 'Please fill the description field';
                      }
                      return null;
                    },
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                  ),
                  kHeight20,
                  TextFormField(
                    validator: (offer) {
                      if (offer == null || offer.isEmpty) {
                        return 'Enter  the offer';
                      }
                      return null;
                    },
                    initialValue: initialOfferValue.toString(),
                    onChanged: (value) {
                      initialOfferValue = int.parse(value);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Offer'),
                    keyboardType: TextInputType.number,
                  ),
                  kHeight20,
                  GestureDetector(
                    onTap: () {
                      print('image image');
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Text(
                          'Select Image',
                          textAlign: TextAlign.start,
                        )),
                  ),
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final form = formProductKey.currentState;
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
           
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  //dialog box for adding the data
                  openDialog(context);
                },
                child: const Text(
                  'Add Product',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  label: Text('Image'),
                ),
                DataColumn(
                  label: Text('Name'),
                ),
                DataColumn(
                  label: Text('Price'),
                ),
                DataColumn(
                  label: Text('Stock'),
                ),
                DataColumn(
                  label: Text('Status'),
                  numeric: true,
                ),
              ],
              rows: List<DataRow>.generate(
                10,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    )),
                    DataCell(Text('A')),
                    DataCell(Text('B')),
                    DataCell(Text('C')),
                    DataCell(Text('D')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
