import 'package:flutter/material.dart';

class GenderDropdown extends StatefulWidget {
  // Added onSaved
  const GenderDropdown({Key? key, required this.onSaved}) : super(key: key);
  // Declare onSaved
  final void Function(String?) onSaved;

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  // Declare string to load if the data is saved
  String? _selectedGender;
  Future<String?>? _genderFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: _genderFuture,
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.group),
                border: OutlineInputBorder(),
                //
              ),
              hint: const Text('Please select Gender'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              items: [],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            _selectedGender = snapshot.data;
            return DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.group),
                  border: OutlineInputBorder(),
                  //contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                ),
                hint: const Text('Please select Gender'),
                value: _selectedGender,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select Gender';
                  }
                  return null;
                },
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onSaved: widget.onSaved,
                style: const TextStyle(fontSize: 15));
          }
        });
  }
}
