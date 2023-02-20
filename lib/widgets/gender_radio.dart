import 'package:flutter/material.dart';

import '../screen/add_malaria.dart';

class GenderRadio extends StatefulWidget {
  const GenderRadio({super.key});

  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  String selectedGender = '';
  bool isFemale = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width: 150,
          child: RadioListTile(
              value: 'Male',
              groupValue: selectedGender,
              title: const Text('Male/ ကျား'),
              onChanged: (gender) => setState(() {
                    selectedGender = gender!;
                  })),
        ),
        SizedBox(
          width: 150,
          child: RadioListTile(
              value: 'Female',
              groupValue: selectedGender,
              title: const Text('Female/ မ'),
              onChanged: (gender) => setState(() {
                    selectedGender = gender!;
                    isFemale = true;
                  })),
        ),
      ],
    );
  }
}
