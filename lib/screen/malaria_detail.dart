import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/database_helper.dart';

class MalariaDetail extends StatefulWidget {
  // Parameters of the MalariaDetail Screen
  final int id;
  final String name;
  final String age;
  final String sex;

  const MalariaDetail(
      {required this.id,
      required this.name,
      required this.age,
      required this.sex});

  @override
  State<MalariaDetail> createState() => _MalariaDetailState();
}

class _MalariaDetailState extends State<MalariaDetail> {
  // variables to display value to widget
  int? id;
  String? name, age, sex;

  // initState
  @override
  void initState() {
    super.initState();
    id = widget.id;
    name = widget.name;
    age = widget.age;
    sex = widget.sex;
  }

// Build starts here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Record Detail')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0)),
                child: Column(children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Name Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Name: ',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(flex: 1, child: Text(name ?? '')),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Age Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Age: ',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(flex: 1, child: Text(age ?? '')),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Sex Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Gender: ',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(flex: 1, child: Text(sex ?? '')),
                    ],
                  ),
                ]),
              ),
            ),
            // Delete Record Button
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Delete'),
                          content:
                              const Text('Are you sure you want to delete?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            )
                          ],
                        );
                      });
                  if (confirmDelete == true) {
                    DatabaseHelper().deleteMalaria(id!);
                    Navigator.pop(context, 'success');
                  }
                },
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete'),
              ),
            ),
          ],
        ));
  }
}
