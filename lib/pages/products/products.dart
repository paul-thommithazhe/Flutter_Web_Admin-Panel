import 'dart:developer';

import 'dart:typed_data';
import 'package:admin_panel_take_it/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController sizeController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController offerController = TextEditingController();

  final formProductKey = GlobalKey<FormState>();

  int initialOfferValue = 0;

  Image? fromPicker;

  Future? imagePath;

  String? selectCategory = 'select category';

  String? url;

  String? value, brandValue;

  Uint8List? bytes;

  PlatformFile? pickefFile;
  Future selectFile() async {
    final picker = ImagePicker();
    final PickedFile? image =
        await picker.getImage(source: ImageSource.gallery);
    setState(() async {
      bytes = await image!.readAsBytes();
    });
  }

  Future deleteData(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .delete();
    } catch (e) {
      return false;
    }
  }

  openDialog(context) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
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
                    decoration: const InputDecoration(
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
                  SizedBox(
                    width: double.infinity,
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('brands')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return DropdownButton<String>(
                            value: snapshot.data!.docs[0]['brandName'],
                            items: snapshot.data!.docs
                                .map(
                                  (QueryDocumentSnapshot item) =>
                                      DropdownMenuItem<String>(
                                    value: item['brandName'],
                                    child: Text(item['brandName']),
                                  ),
                                )
                                .toList(),
                            onChanged: (item) => setState(() {
                              brandValue = item;
                            }),
                          );
                        }),
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
                  SizedBox(
                    width: double.infinity,
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('category')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return DropdownButton<String>(
                            value: snapshot.data!.docs[0]['name'],
                            items: snapshot.data!.docs
                                .map(
                                  (QueryDocumentSnapshot item) =>
                                      DropdownMenuItem<String>(
                                    value: item['name'],
                                    child: Text(item['name']),
                                  ),
                                )
                                .toList(),
                            onChanged: (item) => setState(() {
                              value = item;
                            }),
                          );
                        }),
                  ),
                  kHeight20,
                  GestureDetector(
                    onTap: selectFile,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Text(
                            'Select Image',
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final form = formProductKey.currentState;

                          Reference ref = FirebaseStorage.instance
                              .ref()
                              .child("$value/${DateTime.now()}.jpg");
                          UploadTask uploadTask = ref.putData(bytes!);
                          final taskSnapshot =
                              await uploadTask.whenComplete(() {
                            log('done');
                          });

                          url = await taskSnapshot.ref.getDownloadURL();

                          if (form!.validate()) {   
                            Map<String, dynamic> data = {
                              'name': productNameController.text,
                              'price': int.parse(priceController.text),
                              'quantity': int.parse(stockController.text),
                              'brand': brandValue,
                              'size': sizeController.text,
                              'description': descriptionController.text,
                              'offer': offerController.text,
                              'category': value,
                              'image': url,
                            };

                            FirebaseFirestore.instance
                                .collection('products')
                                .doc()
                                .set(data);
                            productNameController.clear();
                            priceController.clear();
                            stockController.clear();
                            brandController.clear();
                            sizeController.clear();
                            descriptionController.clear();
                            offerController.clear();

                            Navigator.pop(context);
                          } else {
                            log('form is not valid');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 40)),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

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
                        dataRowHeight: 100,
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
                            label: Text('Quantity'),
                          ),
                          DataColumn(
                            label: Text('Offer'),
                          ),
                          DataColumn(
                            label: Text('Status'),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('Edit/Update'),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('Delete'),
                            numeric: true,
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
                                  SizedBox(
                                    height: 90,
                                    width: 70,
                                    child: Image.network(
                                        snapshot.data!.docs[index]['image'],fit: BoxFit.fill,),
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
                                DataCell(
                                  snapshot.data!.docs[index]['quantity'] == 0
                                      ? const Text(
                                          'Out Of Stock',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const Text('Active'),
                                ),
                                DataCell(
                                  TextButton.icon(
                                    onPressed: () {
                                      openDialog(context);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 38, 36, 36),
                                    ),
                                    label: const Text(''),
                                  ),
                                ),
                                DataCell(
                                  TextButton.icon(
                                    onPressed: () {
                                      String productId =
                                          snapshot.data!.docs[index].id;
                                      deleteData(productId);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: const Text(''),
                                  ),
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
