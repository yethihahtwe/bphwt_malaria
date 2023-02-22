import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/database_helper.dart';

class MalariaDetail extends StatefulWidget {
  // Parameters of the MalariaDetail Screen
  final int id;
  final String rxMonth;
  final String rxYear;
  final String testDate;
  final String name;
  final String age;
  final String address;
  final String sex;
  final String pregnancy;
  final String rdtBool;
  final String rdtPosResult;
  final String symptom;
  final String medicine;
  final String medicineAmount;
  final String refer;
  final String death;
  final String receiveRx;
  final String travel;
  final String job;
  final String remark;
  final String state;
  final String tspMimu;
  final String tspEho;
  final String area;
  final String region;
  final String vil;
  final String usrName;

  const MalariaDetail(
      {required this.id,
      required this.name,
      required this.age,
      required this.sex,
      required this.rxMonth,
      required this.rxYear,
      required this.testDate,
      required this.address,
      required this.pregnancy,
      required this.rdtBool,
      required this.rdtPosResult,
      required this.symptom,
      required this.medicine,
      required this.medicineAmount,
      required this.refer,
      required this.death,
      required this.receiveRx,
      required this.travel,
      required this.job,
      required this.remark,
      required this.state,
      required this.tspMimu,
      required this.tspEho,
      required this.area,
      required this.region,
      required this.vil,
      required this.usrName});

  @override
  State<MalariaDetail> createState() => _MalariaDetailState();
}

class _MalariaDetailState extends State<MalariaDetail> {
  // variables to display value to widget
  int? id;
  String? rxMonth,
      rxYear,
      testDate,
      name,
      age,
      address,
      sex,
      pregnancy,
      rdtBool,
      rdtPosResult,
      symptom,
      medicine,
      medicineAmount,
      refer,
      death,
      receiveRx,
      travel,
      job,
      remark,
      state,
      tspMimu,
      tspEho,
      area,
      region,
      vil,
      usrName;

  // initState
  @override
  void initState() {
    super.initState();
    id = widget.id;
    rxMonth = widget.rxMonth;
    rxYear = widget.rxYear;
    testDate = widget.testDate;
    name = widget.name;
    age = widget.age;
    address = widget.address;
    sex = widget.sex;
    pregnancy = widget.pregnancy;
    rdtBool = widget.rdtBool;
    rdtPosResult = widget.rdtPosResult;
    symptom = widget.symptom;
    medicine = widget.medicine;
    medicineAmount = widget.medicineAmount;
    refer = widget.refer;
    death = widget.death;
    receiveRx = widget.receiveRx;
    travel = widget.travel;
    job = widget.job;
    remark = widget.remark;
    state = widget.state;
    tspMimu = widget.tspMimu;
    tspEho = widget.tspEho;
    area = widget.area;
    region = widget.region;
    vil = widget.vil;
    usrName = widget.usrName;
  }

// Build starts here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Record Detail')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  alignment: Alignment.topCenter,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(3.0)),
                  child: Column(children: [
                    // Start of Treatment Month
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('လ အမည်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(rxMonth ?? '')),
                      ],
                    ), // End of Treatment Month
                    // Start of Treatment Year
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ခုနှစ်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(rxYear ?? '')),
                      ],
                    ), // End of Treatment Year
                    // Start of Test Date

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ရက်စွဲ',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(testDate ?? '')),
                      ],
                    ), // End of Test Date
                    // Start of Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('အမည်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(name ?? '')),
                      ],
                    ),
                    // End of Name
                    // Start of Age Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('အသက်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(age ?? '')),
                      ],
                    ),
                    // End of Age
                    // Start of Address

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('လိပ်စာ',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(address ?? '')),
                      ],
                    ), // End of Address
                    // Start of Gender
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ကျား/မ',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(sex ?? '')),
                      ],
                    ), // End of Gender
                    // Start of Pregnancy

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ကိုယ်ဝန်ဆောင်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(pregnancy ?? '')),
                      ],
                    ), // End of Pregnancy
                    // Start of RDT Bool

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('RDT ဖြင့်စစ်ဆေး',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(rdtBool ?? '')),
                      ],
                    ), // End of RDT Bool
                    // Start of RDT Pos Result

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ပိုးတွေ့',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(rdtPosResult ?? '')),
                      ],
                    ), // End of RDT Pos Result
                    // Start of Symptom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ပြင်ပလက္ခဏာ',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(symptom ?? '')),
                      ],
                    ), // End of Symptom
                    // Start of Medicine
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ငှက်ဖျားဆေး',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(medicine ?? '')),
                      ],
                    ), // End of Medicine
                    // Start of Medicine Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ဆေးလုံးအရေအတွက်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(medicineAmount ?? '')),
                      ],
                    ), // End of Medicine Amount
                    // Start of Refer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ဆေးရုံဆေးခန်းလွှဲပြောင်း',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(refer ?? '')),
                      ],
                    ), // End of Refer
                    // Start of Death
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ငှက်ဖျားပိုးတွေ့သေဆုံး',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(death ?? '')),
                      ],
                    ), // End of Death
                    // Start of Receive Rx
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ဆေးကုသမှုခံယူခြင်း',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(receiveRx ?? '')),
                      ],
                    ), // End of Receive Rx
                    // Start of Travel

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ခရီးသွားခြင်း',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(travel ?? '')),
                      ],
                    ), // End of Travel
                    // Start of Job

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('အလုပ်အကိုင်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(job ?? '')),
                      ],
                    ), // End of Job
                    // Start of Remark

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('မှတ်ချက်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(remark ?? '')),
                      ],
                    ), // End of Remark
                    // Start of State

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('တိုင်းဒေသကြီး၊ ပြည်နယ်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(state ?? '')),
                      ],
                    ), // End of State
                    // Start of MIMU Township

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('MIMU မြို့နယ်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(tspMimu ?? '')),
                      ],
                    ), // End of MIMU Township
                    // Start of EHO Township

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('EHO မြို့နယ်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(tspEho ?? '')),
                      ],
                    ), // End of EHO Township
                    // Start of Area

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ဧရိယာအမည်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(area ?? '')),
                      ],
                    ), // End of Area
                    // Start of Region

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('လှုပ်ရှားဒေသအမည်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(region ?? '')),
                      ],
                    ), // End of Region
                    // Start of Vil

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('ကျေးရွာ:',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(vil ?? '')),
                      ],
                    ), // End of Vil
                    // Start of User Name

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('စေတနာ့ဝန်ထမ်းအမည်',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(flex: 1, child: Text(usrName ?? '')),
                      ],
                    ), // End of User Name
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
          ),
        ));
  }
}
