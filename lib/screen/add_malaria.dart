import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../database/database_helper.dart';
import '../model/malaria.dart';

class AddMalaria extends StatefulWidget {
  const AddMalaria({super.key});

  @override
  State<AddMalaria> createState() => _AddMalariaState();
}

class _AddMalariaState extends State<AddMalaria> {
  GlobalKey<FormState> _key = GlobalKey();
  //String to save to table
  String? name,
      age,
      address,
      selectedMonth,
      selectedYear,
      rdtPosType,
      symptomType,
      medicine,
      medicineAmount,
      receivedRx,
      selectedJob,
      selectedJobId,
      otherJob;
  DateTime? date;

  //String to display date in date picker button
  String getDateText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return '${date!.day}-${date!.month}-${date!.year}';
    }
  }

  //List variable for dropdowns
  List<dynamic> mthList = [];
  List<dynamic> yearList = [];
  List<dynamic> jobList = [];

  // String for dropdown value id
  String? mthId;
  String? yearId;
  String? jobId;

  // Bool for Pregnancy Checkbox visibility
  bool isFemale = false;
  String selectedGender = '';

  // Bool for RDT Positive Type visibility
  String rdtResult = '';
  bool isRdtPositive = false;

  // Bool for Pregnancy Checkbox Default Value
  bool isPregnancy = false;

  // Bool for Referral Checkbox
  bool isReferred = false;

  // Bool for Death Checkbox
  bool isDeath = false;

  // Bool for Travelling history checkbox
  bool isTravel = false;

  // Bool for other job visibility
  bool isOtherJob = false;

  @override
  void initState() {
    super.initState();
    // Add values to Month List
    this.mthList.add({"id": 1, "mthName": "January"});
    this.mthList.add({"id": 2, "mthName": "February"});
    this.mthList.add({"id": 3, "mthName": "March"});
    this.mthList.add({"id": 4, "mthName": "April"});
    this.mthList.add({"id": 5, "mthName": "May"});
    this.mthList.add({"id": 6, "mthName": "June"});
    this.mthList.add({"id": 7, "mthName": "July"});
    this.mthList.add({"id": 8, "mthName": "August"});
    this.mthList.add({"id": 9, "mthName": "September"});
    this.mthList.add({"id": 10, "mthName": "October"});
    this.mthList.add({"id": 11, "mthName": "November"});
    this.mthList.add({"id": 12, "mthName": "December"});

    // Add values to Year List
    this.yearList.add({"id": 1, "yearName": "2023"});
    this.yearList.add({"id": 2, "yearName": "2024"});
    this.yearList.add({"id": 3, "yearName": "2025"});
    this.yearList.add({"id": 4, "yearName": "2026"});
    this.yearList.add({"id": 5, "yearName": "2027"});
    this.yearList.add({"id": 6, "yearName": "2028"});
    this.yearList.add({"id": 7, "yearName": "2029"});
    this.yearList.add({"id": 8, "yearName": "2030"});
    this.yearList.add({"id": 9, "yearName": "2031"});
    this.yearList.add({"id": 10, "yearName": "2032"});
    this.yearList.add({"id": 11, "yearName": "2033"});
    this.yearList.add({"id": 12, "yearName": "2034"});

    // Add values to Job List
    this.jobList.add({"id": 1, "jobName": "ရာဘာခြံလုပ်ငန်း"});
    this.jobList.add({"id": 2, "jobName": "ဥယျာဉ်ခြံလုပ်ငန်း"});
    this.jobList.add({"id": 3, "jobName": "ဆောက်လုပ်ရေးလုပ်ငန်း"});
    this.jobList.add({"id": 4, "jobName": "တောတောင်နှင့်ဆက်စပ်သောလုပ်ငန်း"});
    this.jobList.add({"id": 5, "jobName": "မိုင်းတွင်းလုပ်ငန်းများ"});
    this.jobList.add({"id": 6, "jobName": "အခြား"});
  }

  // Build Starts here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Start of Appbar
      appBar: AppBar(
        title: const Text(
          'Malaria Case Register\nငှက်ဖျားလူနာဆေးကုသမှုမှတ်တမ်း',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            // Start of Treatment Month
            const Text('Month of Treatment/ဆေးကုသမှုပေးသည့် လ'),
            FormHelper.dropDownWidget(
                context, "Select Month", this.mthId, this.mthList,
                (onChangedVal) {
              this.mthId = onChangedVal;
              selectedMonth = mthList
                  .where((mth) => mth["id"].toString() == onChangedVal)
                  .first["mthName"]
                  .toString();
              setState(() {});
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return 'Please select Month';
              }
              return null;
            },
                borderColor: Colors.grey,
                borderFocusColor: Theme.of(context).primaryColor,
                borderRadius: 5,
                borderWidth: 0.1,
                contentPadding: 10,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.calendar_month),
                prefixIconColor: Colors.grey,
                prefixIconPaddingLeft: 10.0,
                optionValue: "id",
                optionLabel: "mthName"),

            Divider(),

            // Start of Treatment Year
            const Text('Year of Treatment/ဆေးကုသမှုပေးသည့် ခုနှစ်'),
            FormHelper.dropDownWidget(
                context, "Select Year", this.yearId, this.yearList,
                (onChangedVal) {
              this.yearId = onChangedVal;
              selectedYear = yearList
                  .where((year) => year["id"].toString() == onChangedVal)
                  .first["yearName"]
                  .toString();
              setState(() {});
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return 'Please select Year';
              }
              return null;
            },
                borderColor: Colors.grey,
                borderFocusColor: Theme.of(context).primaryColor,
                borderRadius: 5,
                borderWidth: 0.1,
                contentPadding: 10,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.calendar_view_month_outlined),
                prefixIconColor: Colors.grey,
                prefixIconPaddingLeft: 10.0,
                optionValue: "id",
                optionLabel: "yearName"),
            const Divider(),

            // Start of Date Picker
            const Text('Date of RDT/သွေးဖောက်စစ်သည့်ရက်စွဲ'),
            Container(
              width: 10.0,
              child: ElevatedButton.icon(
                onPressed: () {
                  pickDate(context);
                },
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  getDateText(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Divider(),

            //Start of Name
            const Text('Patient Name/အမည်'),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 50.0,
              child: TextFormField(
                style: const TextStyle(fontSize: 15),
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
                    contentPadding: EdgeInsets.only(top: 5, bottom: 5)),
              ),
            ),
            const Divider(),

            // Start of Age
            const Text('Age/အသက်'),
            Container(
              height: 50.0,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15),
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
                    prefixIcon: Icon(Icons.assignment),
                    hintText: 'Enter Age',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(top: 5, bottom: 5)),
              ),
            ),
            const Divider(),

            // Start of Address
            const Text('Address/ နေရပ်လိပ်စာ'),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                maxLines: 3,
                // keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15),
                validator: (str) {
                  if (str == null || str.isEmpty) {
                    return 'Please Enter Address';
                  }
                  return null;
                },
                onSaved: (str) {
                  address = str;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.home),
                    hintText: 'Enter Address',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(top: 5, bottom: 5)),
              ),
            ),
            const Divider(),

            // Start of Gender
            const Text('Gender/လိင်'),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 50,
              child: ListView(
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
                              isFemale = false;
                              isPregnancy = false;
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
              ),
            ),

            // Start of Pregnancy Checkbox
            if (isFemale)
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Pregnancy/ ကိုယ်ဝန်ဆောင်'),
                    value: isPregnancy,
                    onChanged: (preg) => setState(() {
                      isPregnancy = preg!;
                    }),
                  )),
            const Divider(),

            // Start of RDT
            const Text('RDT Test/ RDT ဖြင့်စစ်ဆေး'),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                        value: 'Positive',
                        groupValue: rdtResult,
                        title: const Text('Positive\nပိုးတွေ့'),
                        onChanged: (result) => setState(() {
                              rdtResult = result!;
                              isRdtPositive = true;
                            })),
                  ),
                  SizedBox(
                    width: 160,
                    child: RadioListTile(
                        value: 'Negative',
                        groupValue: rdtResult,
                        title: const Text('Negative\nပိုးမတွေ့'),
                        onChanged: (result) => setState(() {
                              rdtResult = result!;
                              isRdtPositive = false;
                              rdtPosType = null;
                              symptomType = null;
                              medicine = null;
                              isReferred = false;
                              isDeath = false;
                              receivedRx = null;
                              isTravel = false;
                              selectedJob = null;
                            })),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Start of RDT Positive Result
            if (isRdtPositive)
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 150,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'pf',
                          groupValue: rdtPosType,
                          title: const Text('Plasmodium falciparum\nဖယ်ဆီပရမ်'),
                          onChanged: (posType) => setState(() {
                                rdtPosType = posType!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'pv',
                          groupValue: rdtPosType,
                          title: const Text('Plasmodium Vivax\nဗိုင်းဗက်'),
                          onChanged: (posType) => setState(() {
                                rdtPosType = posType!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'mixed',
                          groupValue: rdtPosType,
                          title: const Text('Mixed\nပိုးအရောတွေ့'),
                          onChanged: (posType) => setState(() {
                                rdtPosType = posType!;
                              })),
                    ),
                  ],
                ),
              ),
            if (isRdtPositive) const Divider(),

            // Start of Symptoms
            if (isRdtPositive) const Text('Symptoms/ ရောဂါလက္ခဏာများ'),
            if (isRdtPositive)
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 160,
                      child: RadioListTile(
                          value: 'Moderate',
                          groupValue: symptomType,
                          title: const Text('Moderate\nသာမန်'),
                          onChanged: (type) => setState(() {
                                symptomType = type!;
                                isReferred = false;
                              })),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                          value: 'Severe',
                          groupValue: symptomType,
                          title: const Text('Severe\nပြင်းထန်'),
                          onChanged: (type) => setState(() {
                                symptomType = type!;
                                isReferred = true;
                              })),
                    ),
                  ],
                ),
              ),
            if (isRdtPositive) const Divider(),

            // Start of Treatment
            if (isRdtPositive)
              const Text('Antimalaria prescribed/ ကုသပေးသည့်ငှက်ဖျားဆေး'),
            if (isRdtPositive)
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 360,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'ACT-24',
                          groupValue: medicine,
                          title: const Text('ACT-24/ အေစီတီ-၂၄'),
                          onChanged: (med) => setState(() {
                                medicine = med!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'ACT-18',
                          groupValue: medicine,
                          title: const Text('ACT-18/ အေစီတီ-၁၈'),
                          onChanged: (med) => setState(() {
                                medicine = med!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'ACT-12',
                          groupValue: medicine,
                          title: const Text('ACT-12/ အေစီတီ-၁၂'),
                          onChanged: (med) => setState(() {
                                medicine = med!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'ACT-6',
                          groupValue: medicine,
                          title: const Text('ACT-6/ အေစီတီ-၆'),
                          onChanged: (med) => setState(() {
                                medicine = med!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'Chloroquine',
                          groupValue: medicine,
                          title: const Text('Chloroquine/ ကလိုရိုကွင်း'),
                          onChanged: (med) => setState(() {
                                medicine = med!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'Primaquine',
                          groupValue: medicine,
                          title: const Text('Primaquine/ ပရိုင်မာကွင်း'),
                          onChanged: (med) => setState(() {
                                medicine = med!;
                              })),
                    ),
                    Row(children: [
                      const Expanded(
                        flex: 2,
                        child: Text('Amount prescribed\nဆေးလုံးအရေအတွက်'),
                      ),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 15),
                              validator: (str) {
                                if (isRdtPositive == true && str == null) {
                                  return 'Please enter amount';
                                } else if (isRdtPositive == true &&
                                    str!.isEmpty) {
                                  return 'Please enter amount';
                                }
                                return null;
                              },
                              onSaved: (str) {
                                medicineAmount = str;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ))
                    ]),
                  ],
                ),
              ),
            if (isRdtPositive) const Divider(),

            // Start of Referred Checkbox
            if (isRdtPositive)
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                        'Patient referred with Malaria\nဆေးရုံဆေးခန်းလွှဲပြောင်းငှက်ဖျားလူနာ'),
                    value: isReferred,
                    onChanged: (referred) => setState(() {
                      isReferred = referred!;
                    }),
                  )),
            if (isRdtPositive) const Divider(),

            // Start of death checkbox
            if (isRdtPositive)
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                        'Expired with RDT Positive\nငှက်ဖျားပိုးတွေ့သေဆုံး'),
                    value: isDeath,
                    onChanged: (death) => setState(() {
                      isDeath = death!;
                    }),
                  )),
            if (isRdtPositive) const Divider(),

            // Start of Treatment
            if (isRdtPositive)
              const Text('Received treatment since/ ဆေးကုသမှုခံယူခြင်း'),
            if (isRdtPositive)
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 100,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'Within-24hr',
                          groupValue: receivedRx,
                          title: const Text(
                              'Within 24hr of fever\nဖျားပြီး(၂၄)နာရီအတွင်း'),
                          onChanged: (receive) => setState(() {
                                receivedRx = receive!;
                              })),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                          value: 'After-24hr',
                          groupValue: receivedRx,
                          title: const Text(
                              'After 24hr of fever\nဖျားပြီး(၂၄)နာရီကျော်'),
                          onChanged: (receive) => setState(() {
                                receivedRx = receive!;
                              })),
                    ),
                  ],
                ),
              ),
            if (isRdtPositive) const Divider(),

            // Start of Travelling history Checkbox
            if (isRdtPositive)
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                        'Travelling 2week-1month before\n(၂)ပတ်မှ(၁)လအတွင်းခရီးသွားထားခြင်း'),
                    value: isTravel,
                    onChanged: (travel) => setState(() {
                      isTravel = travel!;
                    }),
                  )),
            if (isRdtPositive) const Divider(),

            // Start of Job Dropdown
            if (isRdtPositive) const Text('Occupation/ အလုပ်အကိုင်'),
            if (isRdtPositive)
              FormHelper.dropDownWidget(
                context,
                "Select Occupation",
                this.jobId,
                this.jobList,
                (onChangedVal) {
                  this.jobId = onChangedVal;
                  selectedJobId = onChangedVal;
                  selectedJob = jobList
                      .where((job) => job["id"].toString() == onChangedVal)
                      .first["jobName"]
                      .toString();
                  setState(() {});
                },
                (onValidateVal) {
                  if (onValidateVal == null) {
                    return 'Please select Occupation';
                  }
                  return null;
                },
                borderColor: Colors.grey,
                borderFocusColor: Theme.of(context).primaryColor,
                borderRadius: 5,
                borderWidth: 0.1,
                contentPadding: 10,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.factory),
                prefixIconColor: Colors.grey,
                prefixIconPaddingLeft: 10.0,
                optionValue: "id",
                optionLabel: "jobName",
              ),
            if (isOtherJob) const Text('Other occupation/ အခြားလုပ်ငန်း'),
            if (isOtherJob)
              Container(
                height: 50.0,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  style: const TextStyle(fontSize: 15),
                  validator: (str) {
                    if (str == null || str.isEmpty) {
                      return 'Please Enter Occupation';
                    }
                    return null;
                  },
                  onSaved: (str) {
                    otherJob = str;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter Other Occupation',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(top: 5, bottom: 5)),
                ),
              ),

            if (isRdtPositive) const Divider(),

            // Start of Save Button
            ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState != null &&
                      _key.currentState!.validate()) {
                    _key.currentState?.save();
                    int id = await DatabaseHelper().insertMalaria(
                        Malaria.insertMalaria(
                            name: name ?? '',
                            age: age ?? '',
                            sex: selectedGender));
                    print(id);
                    Navigator.pop(context, 'success');
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'))
          ],
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }

  Future showOtherJob(BuildContext context) async {
    if (selectedJobId == '6') {
      isOtherJob = true;
    }
  }
}
