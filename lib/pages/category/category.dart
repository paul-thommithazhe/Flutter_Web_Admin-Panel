import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_panel_take_it/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController categoryNameController = TextEditingController();

final formCouponKey = GlobalKey<FormState>();

Uint8List? bytes;

String? url;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
          .collection("category")
          .doc(productId)
          .delete();
    } catch (e) {
      return false;
    }
  }

  openCouponDialog(context) => showDialog(
        // useRootNavigator: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          // contentPadding: EdgeInsets.all(10),
          title: const Text('Add Category'),
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
                        return 'Enter  the Category Name';
                      }
                      return null;
                    },
                    controller: categoryNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Category Name'),
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
                          final form = formCouponKey.currentState;
                          if (form!.validate()) {
                            log('valid form');

                            Reference ref = FirebaseStorage.instance.ref().child(
                                "${categoryNameController.text}/${DateTime.now()}.jpg");
                            UploadTask uploadTask = ref.putData(bytes!);
                            final taskSnapshot =
                                await uploadTask.whenComplete(() {
                              log('done');
                            });

                            url = await taskSnapshot.ref.getDownloadURL();
                            log(url!);
                            Map<String, dynamic> data = {
                              'image': url,
                              'name': categoryNameController.text
                            };

                            FirebaseFirestore.instance
                                .collection('category')
                                .doc()
                                .set(data);

                            categoryNameController.clear();
                            Navigator.pop(context);
                          } else {
                            log('not valid');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 40),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
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
        stream: FirebaseFirestore.instance.collection('category').snapshots(),
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
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          openCouponDialog(context);
                        },
                        child: const Text('Add Category'),
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
                        minWidth: 50,
                        columns: const [
                          DataColumn2(
                            label: Text('Index'),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('Category'),
                          ),
                          DataColumn(
                            label: Text('Updata/Edit'),
                          ),
                          DataColumn(
                            label: Text('Delete'),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          snapshot.data!.docs.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text(index.toString())),
                              DataCell(
                                  Text(snapshot.data!.docs[index]['name'])),
                              DataCell(TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit,color: Colors.black,),
                                  label: Text(''))),
                              DataCell(TextButton.icon(
                                  onPressed: () {
                                    String categoryId =
                                        snapshot.data!.docs[index].id;
                                    deleteData(categoryId);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  label: Text(''))),
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
