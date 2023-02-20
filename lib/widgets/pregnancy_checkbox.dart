import 'package:flutter/material.dart';

class PregnancyCheckbox extends StatefulWidget {
  const PregnancyCheckbox({super.key});

  @override
  State<PregnancyCheckbox> createState() => _PregnancyCheckboxState();
}

class _PregnancyCheckboxState extends State<PregnancyCheckbox> {
  bool isPregnancy = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text('Pregnancy/ ကိုယ်ဝန်ဆောင်'),
      value: isPregnancy,
      onChanged: (preg) => setState(() {
        this.isPregnancy = preg!;
      }),
    );
  }
}
