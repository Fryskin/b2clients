// ignore: unused_import, avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b2clients/services/firestore.dart';
// import 'package:flutter/widgets.dart';

class MyWorksheetsListPage extends StatefulWidget {
  const MyWorksheetsListPage({super.key});

  @override
  State<MyWorksheetsListPage> createState() => _MyWorksheetsListPageState();
}

class _MyWorksheetsListPageState extends State<MyWorksheetsListPage> {
  FirestoreService firestoreService = FirestoreService();

  final TextEditingController worksheettextController = TextEditingController();
  final TextEditingController serviceTypetextController =
      TextEditingController();
  final TextEditingController areatextController = TextEditingController();
  final TextEditingController pricetextController = TextEditingController();
  final TextEditingController workCalendartextController =
      TextEditingController();
  final TextEditingController emailtextController = TextEditingController();
  final TextEditingController phonetextController = TextEditingController();
  final TextEditingController addresstextController = TextEditingController();
  final TextEditingValue textValue = const TextEditingValue();
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print('no user');
      } else {
        // ignore: avoid_print
        print('user $user');
      }
    });
  }

  void openWorksheetBox({String? documentId}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Title'),
                    controller: worksheettextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Type of service'),
                    controller: serviceTypetextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Area'),
                    controller: areatextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Price'),
                    controller: pricetextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Work calendar'),
                    controller: workCalendartextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    controller: emailtextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Phone'),
                    controller: phonetextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Address'),
                    controller: addresstextController,
                    validator: (value) {
                      if (value == null) return 'Fill the field';
                      return null;
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // add worksheet
                    // if (documentId == null) {
                    //   firestoreService.addWorksheet(
                    //       worksheettextController.text,
                    //       serviceTypetextController.text,
                    //       areatextController.text,
                    //       pricetextController.text,
                    //       workCalendartextController.text,
                    //       emailtextController.text,
                    //       phonetextController.text,
                    //       addresstextController.text);
                    // }
                    // // update worksheet
                    // else {
                    //   firestoreService.updateWorksheet(
                    //       documentId,
                    //       worksheettextController.text,
                    //       serviceTypetextController.text,
                    //       areatextController.text,
                    //       pricetextController.text,
                    //       workCalendartextController.text,
                    //       emailtextController.text,
                    //       phonetextController.text,
                    //       addresstextController.text);
                    // }

                    // worksheettextController.clear();
                    // serviceTypetextController.clear();
                    // areatextController.clear();
                    // pricetextController.clear();
                    // workCalendartextController.clear();
                    // emailtextController.clear();
                    // phonetextController.clear();
                    // addresstextController.clear();

                    // Navigator.pop(context);
                  },
                  child: const Text("Confirm"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final appBarTheme = AppBarTheme.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        toolbarHeight: appBarTheme.toolbarHeight,
        centerTitle: appBarTheme.centerTitle,
        title: const Text('Your worksheets'),
        backgroundColor: appBarTheme.backgroundColor,
      ),
      backgroundColor: theme.primaryColor,
      // body: ListView.separated(
      //   separatorBuilder: (context, index) => Divider(
      //       thickness: theme.dividerTheme.thickness,
      //       color: theme.dividerTheme.color),
      //   itemCount: 10,
      //   itemBuilder: (context, i) {
      //     const worksheetTitle = 'Slesar';
      //     return const WorksheetsListTile(worksheetTitle: worksheetTitle);
      // },
      // ),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: firestoreService.getWorksheetsStream(),
      //   builder: (context, snapshot) {
      //     // if we have data, get all the docs.
      //     if (snapshot.hasData) {
      //       List worksheetsList = snapshot.data!.docs;

      //       // display as a list.
      //       return ListView.builder(
      //         itemCount: worksheetsList.length,
      //         itemBuilder: (context, index) {
      //           // get each individual doc.
      //           DocumentSnapshot document = worksheetsList[index];
      //           String documentId = document.id;

      //           // get worksheet from every doc.
      //           Map<String, dynamic> data =
      //               document.data() as Map<String, dynamic>;
      //           String worksheetTitle = data['title'];

      //           // display as a list tile.
      //           return Card.outlined(
      //             child: Column(
      //               children: [
      //                 ListTile(
      //                     title: Text(worksheetTitle),
      //                     trailing: Row(
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: [
      //                         IconButton(
      //                           onPressed: () =>
      //                               openWorksheetBox(documentId: documentId),
      //                           icon: const Icon(Icons.edit),
      //                         ),
      //                         IconButton(
      //                           onPressed: () => firestoreService
      //                               .deleteWorksheet(documentId),
      //                           icon: const Icon(Icons.delete),
      //                         ),
      //                       ],
      //                     ))
      //               ],
      //             ),
      //           );

      //           // return ListTile(
      //           //   title: Text(worksheetTitle),
      //         },
      //       );
      //     }
      //     // if there is no data return message
      //     else {
      //       return const Text("Empty");
      //     }
      //   },
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: openWorksheetBox,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
