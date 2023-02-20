import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../database/database_helper.dart';
import '../model/malaria.dart';

class UpdateMalaria extends StatefulWidget {
  final int id;
  final String name;
  final String age;
  final String sex;

  const UpdateMalaria(
      {required this.id,
      required this.name,
      required this.age,
      required this.sex});

  @override
  State<UpdateMalaria> createState() => _UpdateMalariaState();
}

class _UpdateMalariaState extends State<UpdateMalaria> {
  int? id;
  String? name, age, sex;
  GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    name = widget.name;
    age = widget.age;
    sex = widget.sex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Malaria Data'),
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Text('Name:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: name,
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter Name';
                }
                return null;
              },
              onSaved: (str) {
                name = str;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            const Text('Age:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: age,
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter Age';
                }
                return null;
              },
              onSaved: (str) {
                age = str;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.numbers),
                hintText: 'Enter Age',
                border: OutlineInputBorder(),
              ),
            ),
            const Text('Sex:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: sex,
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter Sex';
                }
                return null;
              },
              onSaved: (str) {
                sex = str;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Enter Sex',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState != null &&
                      _key.currentState!.validate()) {
                    _key.currentState?.save();
                    int result = await DatabaseHelper().updateMalaria(
                        Malaria.insertMalaria(
                            name: name ?? '', age: age ?? '', sex: sex ?? ''),
                        id!);
                    print(result);
                    Navigator.pop(context, 'success');
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'))
          ],
        ),
      ),
    );
  }
}
