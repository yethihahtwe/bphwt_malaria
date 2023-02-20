import 'package:bphwt/database/shared_pref_helper.dart';
import 'package:flutter/material.dart';

class StateDropdown extends StatefulWidget {
  const StateDropdown({Key? key, required this.onSaved}) : super(key: key);
  final void Function(String?) onSaved;

  @override
  State<StateDropdown> createState() => _StateDropdownState();
}

class _StateDropdownState extends State<StateDropdown> {
  String? _selectedState;
  Future<String?>? _userStateFuture;

  @override
  void initState() {
    super.initState();
    _userStateFuture = SharedPrefHelper.getUserState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: _userStateFuture,
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.map),
                border: OutlineInputBorder(),
              ),
              hint: Text('Please select User State/Division'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedState = newValue;
                });
              },
              items: [],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            _selectedState = snapshot.data;
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.map),
                border: OutlineInputBorder(),
              ),
              hint: Text('Please select User State/Division'),
              value: _selectedState,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedState = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select user state/division';
                }
                return null;
              },
              items: <String>['Karen', 'Karenni', 'Shan', 'Tanintharyi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onSaved: widget.onSaved,
            );
          }
        });
  }
}
