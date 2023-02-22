import 'package:bphwt/database/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../database/database_helper.dart';
import '../model/malaria.dart';

class AddMalaria extends StatefulWidget {
  const AddMalaria({Key? key}) : super(key: key);

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
      selectedMedicine,
      medicineAmount,
      receivedRx,
      selectedJob,
      otherJob,
      remark;

  // String to display
  String userName = '';
  String userState = '';
  String userTspMimu = '';
  String userTspEho = '';
  String userArea = '';
  String userRegion = '';
  String userVil = '';
  DateTime? date;

  //String to display date in date picker button
  String getDateText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return '${date!.day}-${date!.month}-${date!.year}';
    }
  }

  // String to convert date format to mm/dd/yy
  String saveDateText() {
    if (date == null) {
      return '';
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
  String rdtResult = 'Negative';
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

  // Items for Job Dropdown
  final jobListItems = [
    'ရာဘာခြံလုပ်ငန်း',
    'ဥယျာဉ်ခြံလုပ်ငန်း',
    'ဆောက်လုပ်ရေးလုပ်ငန်း',
    'တောတောင်နှင့်ဆက်စပ်သောလုပ်ငန်း',
    'မိုင်းတွင်းလုပ်ငန်း',
    'အခြားလုပ်ငန်း'
  ];

  // Items for Antimalarial Dropdown
  final medicineListItems = [
    'ACT-24 (အေစီတီ-၂၄)',
    'ACT-18 (အေစီတီ-၁၈)',
    'ACT-12 (အေစီတီ-၁၂)',
    'ACT-6 (အေစီတီ-၆)',
    'Chloriquine (ကလိုရိုကွင်း)',
    'Primaquine (ပရိုင်မာကွင်း)'
  ];

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

    //Get values from Shared Preferences
    //Get User Name if present
    // Get User Name if present
    SharedPrefHelper.getUserName().then((name) {
      setState(() {
        userName = name ?? 'Please Update';
      });
    });
    // Get User State if present
    SharedPrefHelper.getUserState().then((state) {
      setState(() {
        userState = state ?? 'Please Update';
      });
    });
    // Get User MIMU Township if present
    SharedPrefHelper.getUserTspMimu().then((tspmimu) {
      setState(() {
        userTspMimu = tspmimu ?? 'Please Update';
      });
    });
    // Get User EHO Township if present
    SharedPrefHelper.getUserTspEho().then((tspeho) {
      setState(() {
        userTspEho = tspeho ?? 'Please Update';
      });
    });
    // Get User Area if present
    SharedPrefHelper.getUserArea().then((area) {
      setState(() {
        userArea = area ?? 'Please Update';
      });
    });
    // Get User Region if present
    SharedPrefHelper.getUserRegion().then((region) {
      setState(() {
        userRegion = region ?? 'Please Update';
      });
    });
    // Get User Village if present
    SharedPrefHelper.getUserVil().then((vil) {
      setState(() {
        userVil = vil ?? 'Please Update';
      });
    });
  }

// Build Starts here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Start of AppBar
        appBar: AppBar(
          title: const Text(
            'Malaria Case Register\nငှက်ဖျားလူနာဆေးကုသမှုမှတ်တမ်း',
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: Form(
            key: _key,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

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
                      optionLabel: "mthName",
                      paddingLeft: 0,
                      paddingRight: 0),

                  // Start of Treatment Year
                  const Divider(),
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
                      prefixIcon:
                          const Icon(Icons.calendar_view_month_outlined),
                      prefixIconColor: Colors.grey,
                      prefixIconPaddingLeft: 10.0,
                      optionValue: "id",
                      optionLabel: "yearName",
                      paddingLeft: 0,
                      paddingRight: 0),

                  // Start of Date Picker
                  const Divider(),
                  const Text('Date of RDT/သွေးဖောက်စစ်သည့်ရက်စွဲ'),
                  Container(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        pickDate(context);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50)),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        getDateText(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  //Start of Name
                  const Divider(),
                  const Text('Patient Name/အမည်'),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 15),
                      validator: (enteredName) {
                        if (enteredName == null || enteredName == '') {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      onChanged: (enteredName) => name,
                      onSaved: (enteredName) {
                        setState(() {
                          name = enteredName;
                        });
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter Name',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(top: 5, bottom: 5)),
                    ),
                  ),

                  // Start of Age
                  const Divider(),
                  const Text('Age/အသက်'),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 15),
                      validator: (enteredAge) {
                        if (enteredAge == null || enteredAge == '') {
                          return 'Please Enter Age';
                        }
                        return null;
                      },
                      onChanged: (enteredAge) => age,
                      onSaved: (enteredAge) {
                        age = enteredAge;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.assignment),
                          hintText: 'Enter Age',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(top: 5, bottom: 5)),
                    ),
                  ),

                  // Start of Address
                  const Divider(),
                  const Text('Address/ နေရပ်လိပ်စာ'),
                  Container(
                    child: TextFormField(
                      style: const TextStyle(fontSize: 15),
                      validator: (enteredAddress) {
                        if (enteredAddress == null || enteredAddress == '') {
                          return 'Please Enter Address';
                        }
                        return null;
                      },
                      onChanged: (enteredAddress) => address,
                      onSaved: (enteredAddress) {
                        address = enteredAddress;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          hintText: 'Enter Address',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(top: 5, bottom: 5)),
                    ),
                  ),

                  // Start of Gender
                  const Divider(),
                  const Text('Gender/လိင်'),
                  SizedBox(
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
                            }),
                          ),
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
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Pregnancy/ ကိုယ်ဝန်ဆောင်'),
                      value: isPregnancy,
                      onChanged: (preg) => setState(() {
                        isPregnancy = preg!;
                      }),
                    ),

                  // Start of RDT Test
                  const Divider(),
                  const Text('RDT Test/ RDT ဖြင့်စစ်ဆေး'),
                  Container(
                      height: 60,
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
                                      isOtherJob = false;
                                    })),
                          ),
                        ],
                      )), // End of RDT
                  // Start of RDT Positive Type
                  if (isRdtPositive)
                    SizedBox(
                      height: 210,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const Text(
                              'Malaria Parasite/ ငှက်ဖျားပိုးအမျိုးအစား'),
                          RadioListTile(
                              value: 'pf',
                              groupValue: rdtPosType,
                              title: const Text(
                                  'Plasmodium falciparum\nဖယ်ဆီပရမ်'),
                              onChanged: (posType) => setState(() {
                                    rdtPosType = posType!;
                                  })),
                          RadioListTile(
                              value: 'pv',
                              groupValue: rdtPosType,
                              title: const Text('Plasmodium Vivax\nဗိုင်းဗက်'),
                              onChanged: (posType) => setState(() {
                                    rdtPosType = posType!;
                                  })),
                          RadioListTile(
                              value: 'mixed',
                              groupValue: rdtPosType,
                              title: const Text('Mixed\nပိုးအရောတွေ့'),
                              onChanged: (posType) => setState(() {
                                    rdtPosType = posType!;
                                  })),
                        ],
                      ),
                    ), // End of RDT Positive Type
                  // Start of Symptoms
                  if (isRdtPositive)
                    SizedBox(
                        height: 100,
                        child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const Divider(),
                              const Text('Symptoms/ ရောဂါလက္ခဏာများ'),
                              SizedBox(
                                  height: 400,
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: RadioListTile(
                                              value: 'Moderate',
                                              groupValue: symptomType,
                                              title:
                                                  const Text('Moderate\nသာမန်'),
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
                                              title: const Text(
                                                  'Severe\nပြင်းထန်'),
                                              onChanged: (type) => setState(() {
                                                    symptomType = type!;
                                                    isReferred = true;
                                                  })),
                                        )
                                      ])),
                            ])), // End of Symptoms
                  // Start of Treatment
                  if (isRdtPositive)
                    SizedBox(
                      height: 120,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const Divider(),
                          const Text(
                              'Antimalaria prescribed/ ကုသပေးသည့်ငှက်ဖျားဆေး'),
                          DropdownButtonFormField<String>(
                              value: selectedMedicine,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.medication_rounded),
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(top: 5, bottom: 5),
                              ),
                              hint: const Text('Please select medicine'),
                              items: medicineListItems
                                  .map(buildMedicineListMenuItem)
                                  .toList(),
                              onChanged: (medicine) => setState(() {
                                    selectedMedicine = medicine;
                                  })),
                        ],
                      ),
                    ), // End of Antimalaria Dropdown
                  // Start of Medicine Amount
                  if (isRdtPositive)
                    const Text('Amount prescribed\nဆေးလုံးအရေအတွက်'),
                  if (isRdtPositive)
                    FormHelper.inputFieldWidget(
                        showPrefixIcon: true,
                        prefixIcon: const Icon(Icons.numbers),
                        prefixIconColor: Colors.grey,
                        borderColor: Colors.grey,
                        borderFocusColor: Colors.grey,
                        borderWidth: 1,
                        focusedBorderWidth: 1,
                        borderRadius: 5,
                        context,
                        medicineAmount ?? '',
                        'Amount',
                        isNumeric: true,
                        paddingLeft: 0,
                        paddingRight: 0, (onValidateVal) {
                      if (onValidateVal == null) {
                        return 'Please enter amount';
                      }
                      return null;
                    }, (onSavedVal) {
                      setState(() {
                        medicineAmount = onSavedVal;
                      });
                    }), // End of Medicine Amount
                  // Start of Referred Checkbox
                  if (isRdtPositive) const Divider(),
                  if (isRdtPositive)
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                          'Patient referred with Malaria\nဆေးရုံဆေးခန်းလွှဲပြောင်းငှက်ဖျားလူနာ'),
                      value: isReferred,
                      onChanged: (referred) => setState(() {
                        isReferred = referred!;
                      }),
                    ), // End of Referred Checkbox
                  // Start of death checkbox
                  if (isRdtPositive) const Divider(),
                  if (isRdtPositive)
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                          'Expired with RDT Positive\nငှက်ဖျားပိုးတွေ့သေဆုံး'),
                      value: isDeath,
                      onChanged: (death) => setState(() {
                        isDeath = death!;
                      }),
                    ), // End of death checkbox
                  // Start of Treatment
                  if (isRdtPositive)
                    SizedBox(
                      height: 170,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const Divider(),
                          const Text(
                              'Received treatment since/ ဆေးကုသမှုခံယူခြင်း'),
                          RadioListTile(
                              value: 'Within-24hr',
                              groupValue: receivedRx,
                              title: const Text(
                                  'Within 24hr of fever\nဖျားပြီး(၂၄)နာရီအတွင်း'),
                              onChanged: (receive) => setState(() {
                                    receivedRx = receive!;
                                  })),
                          RadioListTile(
                              value: 'After-24hr',
                              groupValue: receivedRx,
                              title: const Text(
                                  'After 24hr of fever\nဖျားပြီး(၂၄)နာရီကျော်'),
                              onChanged: (receive) => setState(() {
                                    receivedRx = receive!;
                                  })),
                        ],
                      ),
                    ), // End of Treatment
                  // Start of Travelling History Checkbox
                  if (isRdtPositive)
                    SizedBox(
                      height: 80,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const Divider(),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text(
                                'Travelling 2week-1month before\n(၂)ပတ်မှ(၁)လအတွင်းခရီးသွားထားခြင်း'),
                            value: isTravel,
                            onChanged: (travel) => setState(() {
                              isTravel = travel!;
                            }),
                          ),
                        ],
                      ),
                    ), // End of Travelling history checkbox
                  // Start of Job Dropdown
                  if (isRdtPositive)
                    SizedBox(
                      height: 100,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          const Divider(),
                          const Text('Occupation/ အလုပ်အကိုင်'),
                          DropdownButtonFormField<String>(
                            value: selectedJob,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.factory),
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(top: 5, bottom: 5)),
                            hint: const Text('Please select occupation'),
                            items:
                                jobListItems.map(buildJobListMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              selectedJob = value;
                              isOtherJob = value == 'အခြားလုပ်ငန်း';
                            }),
                          ),
                        ],
                      ),
                    ), // End of Job Dropdown
                  // Start of Other Job Text Form Field
                  if (isOtherJob)
                    SizedBox(
                      height: 100,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          const Divider(),
                          const Text('Other occupation/ အခြားလုပ်ငန်း'),
                          TextFormField(
                            style: const TextStyle(fontSize: 15),
                            validator: (enteredJob) {
                              if (enteredJob == null || enteredJob.isEmpty) {
                                return 'Please Enter Occupation';
                              }
                              return null;
                            },
                            onSaved: (enteredJob) {
                              otherJob = enteredJob;
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.factory_outlined),
                                hintText: 'Enter Other Occupation',
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.only(top: 5, bottom: 5)),
                          ),
                        ],
                      ),
                    ), // End of Other Job Text Form Field
                  // Start of Remark
                  if (isRdtPositive)
                    SizedBox(
                      height: 110,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          const Divider(),
                          const Text('Remark/ မှတ်ချက်'),
                          TextFormField(
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.list),
                              border: OutlineInputBorder(),
                              hintText: 'Enter remark if any',
                            ),
                            onSaved: (enteredRemark) {
                              setState(() {
                                remark = enteredRemark;
                              });
                            },
                          ),
                        ],
                      ),
                    ), // End of Remark
                  // Start of User Profile Information
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'စေတနာ့ဝန်ထမ်းအမည်: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(child: Text(userName))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'MIMU မြို့နယ်: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(child: Text(userTspMimu))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'EHO မြို့နယ်: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(child: Text(userTspEho))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'ဧရိယာအမည်: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(child: Text(userArea))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'လှုပ်ရှားဒေသအမည်: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(child: Text(userRegion))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            'ကျေးရွာ: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(child: Text(userVil))
                    ],
                  ),
                  // End of user profile
                  const SizedBox(
                    height: 10,
                  ),
                  // Start of Save Button
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (_key.currentState != null &&
                            _key.currentState!.validate()) {
                          _key.currentState?.save();
                          int id = await DatabaseHelper().insertMalaria(
                              Malaria.insertMalaria(
                                  rxMonth: selectedMonth ?? '',
                                  rxYear: selectedYear ?? '',
                                  testDate: saveDateText(),
                                  name: name ?? '',
                                  age: age ?? '',
                                  address: address ?? '',
                                  sex: selectedGender,
                                  pregnancy: isPregnancy.toString(),
                                  rdtBool: rdtResult,
                                  rdtPosResult: rdtPosType ?? '',
                                  symptom: symptomType ?? '',
                                  medicine: selectedMedicine ?? '',
                                  medicineAmount: medicineAmount ?? '',
                                  refer: isReferred.toString(),
                                  death: isDeath.toString(),
                                  receiveRx: receivedRx ?? '',
                                  travel: isTravel.toString(),
                                  job: selectedJob ?? '',
                                  remark: remark ?? '',
                                  state: userState,
                                  tspMimu: userTspMimu,
                                  tspEho: userTspEho,
                                  area: userArea,
                                  region: userRegion,
                                  vil: userVil,
                                  usrName: userName));
                          print(id);
                          Navigator.pop(context, 'success');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50)),
                      icon: const Icon(Icons.save),
                      label: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16),
                      )), // End of Save Button
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )));
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

  DropdownMenuItem<String> buildJobListMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 15),
        ),
      );

  DropdownMenuItem<String> buildMedicineListMenuItem(String item) =>
      DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 15),
          ));
}
