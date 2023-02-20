import 'package:bphwt/widgets/state_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../database/shared_pref_helper.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  //User Name Text Edit Controller
  TextEditingController _userNameController = TextEditingController();

  // User Area Text Edit Controller
  TextEditingController _userAreaController = TextEditingController();

  // User Region Text Edit Controller
  TextEditingController _userRegionController = TextEditingController();

  //List for dropdown
  List<dynamic> stateList = [];
  List<dynamic> tspMimuMasterList = [];
  List<dynamic> tspMimuList = [];
  List<dynamic> tspEhoMasterList = [];
  List<dynamic> tspEhoList = [];
  List<dynamic> vilMasterList = [];
  List<dynamic> vilList = [];

  //String for dropdown value id
  String? stateId;
  String? tspMimuId;
  String? tspEhoId;
  String? vilId;

// String for later use
  String _userName = '';
  String _userArea = '';
  String _userRegion = '';
  String _selectedState = '';
  String _selectedTspMimu = '';
  String _selectedTspEho = '';
  String _selectedVil = '';
  GlobalKey<FormState> _key = GlobalKey();

// Future to load existing data into dropdown
  Future<String?>? _userStateFuture;

// Future to save data
  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userNameController.text);
    await prefs.setString('userArea', _userAreaController.text);
    await prefs.setString('userRegion', _userRegionController.text);
    await prefs.setString('userState', _selectedState);
    await prefs.setString('userTspMimu', _selectedTspMimu);
    await prefs.setString('userTspEho', _selectedTspEho);
    await prefs.setString('userVil', _selectedVil);
    await prefs.setBool('isComplete', true);
  }

  @override
  void initState() {
    super.initState();
    // Load existing user name
    SharedPrefHelper.getUserName().then((name) {
      print('UserName: $name');
      setState(() {
        _userNameController = TextEditingController(text: name);
      });
    });

    // Load existing user state/division
    _userStateFuture = SharedPrefHelper.getUserState();

    // Add values to State List
    this.stateList.add({"id": 1, "stateName": "Karenni"});
    this.stateList.add({"id": 2, "stateName": "Karen"});

    // Add values to MIMU township List
    this.tspMimuMasterList = [
      {"ID": 1, "Name": "Loikaw", "ParentId": 1},
      {"ID": 2, "Name": "Demoso", "ParentId": 1},
      {"ID": 3, "Name": "Pruso", "ParentId": 1},
      {"ID": 4, "Name": "Pyinmana", "ParentId": 1},
      {"ID": 1, "Name": "Thandaunggyi", "ParentId": 2},
    ];

    // Add values to EHO townsship List
    this.tspEhoMasterList = [
      {"ID": 1, "Name": "Loikaw", "ParentId": 1},
      {"ID": 2, "Name": "Demoso", "ParentId": 1},
      {"ID": 3, "Name": "Pruso", "ParentId": 1},
      {"ID": 1, "Name": "Daw Hpa Koh", "ParentId": 2},
    ];

    // Add values to village List. ParentId is the id of MMU Township
    this.vilMasterList = [
      {"ID": 1, "Name": "Aik San", "ParentId": 1},
      {"ID": 2, "Name": "Nan Lwar", "ParentId": 1},
      {"ID": 3, "Name": "Pain Chit (Kayan)", "ParentId": 1},
      {"ID": 4, "Name": "Pain Chit (Shan)", "ParentId": 1},
      {"ID": 1, "Name": "Kwai Ngan (New)", "ParentId": 2},
    ];
  }

// Dispose text controller here
  @override
  void dispose() {
    _userNameController.dispose();
    _userAreaController.dispose();
    _userRegionController.dispose();
    super.dispose();
  }

// Widget Build Starts here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            // Start of User Name Form Fields
            const Text('User Name:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _userNameController,
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter User Name';
                }
                return null;
              },
              onSaved: (str) {
                _userNameController.text = str!;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Enter User Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),

            //Start of State/Division Form Fields
            const Text('User State/Division:'),
            SizedBox(
              height: 10.0,
            ),

            FormHelper.dropDownWidget(
                context, "Select State/Division", this.stateId, this.stateList,
                (onChangedVal) {
              this.stateId = onChangedVal;
              // Assign onChangedVal to _selectedState to save to shared pref
              _selectedState = stateList
                  .where((state) => state["id"].toString() == onChangedVal)
                  .first["stateName"]
                  .toString();
              print("Selected State: $onChangedVal");
              // Set MIMU Township List according to State Value
              this.tspMimuList = this
                  .tspMimuMasterList
                  .where((tspMimuListItem) =>
                      tspMimuListItem["ParentId"].toString() ==
                      onChangedVal.toString())
                  .toList();
              this.tspMimuId = null;
              // Set EHO Township List according to State Value
              this.tspEhoList = this
                  .tspEhoMasterList
                  .where((tspEhoListItem) =>
                      tspEhoListItem["ParentId"].toString() ==
                      onChangedVal.toString())
                  .toList();
              this.tspEhoId = null;
              setState(() {});
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return 'Please select State/Division';
              }
              return null;
            },
                borderColor: Theme.of(context).primaryColor,
                borderFocusColor: Theme.of(context).primaryColor,
                borderRadius: 10,
                optionValue: "id",
                optionLabel: "stateName"),

            SizedBox(height: 10.0),

            // Start of MIMU Township Form Field
            const Text('User MIMU Township:'),
            const SizedBox(
              height: 10,
            ),
            FormHelper.dropDownWidget(context, "Select MIMU Township",
                this.tspMimuId, this.tspMimuList, (onChangedVal) {
              this.tspMimuId = onChangedVal;
              // Assign onChangedVal to _selectedTspMimu to save to shared pref
              _selectedTspMimu = tspMimuMasterList
                  .where((tspmimu) => tspmimu["ID"].toString() == onChangedVal)
                  .first["Name"]
                  .toString();
              print("Selected TspMimu: $onChangedVal");

              // Set Village List according to MIMU Township Value
              this.vilList = this
                  .vilMasterList
                  .where((vilListItem) =>
                      vilListItem["ParentId"].toString() ==
                      onChangedVal.toString())
                  .toList();
              this.vilId = null;
              setState(() {});
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return 'Please select MIMU Township';
              }
              return null;
            },
                borderColor: Theme.of(context).primaryColor,
                borderFocusColor: Theme.of(context).primaryColor,
                borderRadius: 10,
                optionValue: "ID",
                optionLabel: "Name"),
            SizedBox(height: 10),

            // Start of EHO Township Form Field
            const Text("EHO Township"),
            SizedBox(
              height: 10.0,
            ),
            FormHelper.dropDownWidget(
                context, "Select EHO Township", this.tspEhoId, this.tspEhoList,
                (onChangedVal) {
              this.tspEhoId = onChangedVal;
              // Assign onChangedVal to _selectedTspEho to save to shared pref
              _selectedTspEho = tspEhoMasterList
                  .where((tspeho) => tspeho["ID"].toString() == onChangedVal)
                  .first["Name"]
                  .toString();
              print("Selected TspEho: $onChangedVal");
              setState(() {});
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return 'Please select EHO Township';
              }
              return null;
            },
                borderColor: Theme.of(context).primaryColor,
                borderFocusColor: Theme.of(context).primaryColor,
                borderRadius: 10,
                optionValue: "ID",
                optionLabel: "Name"),
            const SizedBox(
              height: 10,
            ),

            // Start of User Area Form Fields
            const Text('User Area:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _userAreaController,
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter User Area';
                }
                return null;
              },
              onSaved: (str) {
                _userAreaController.text = str!;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.add_location),
                hintText: 'Enter User Area',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),

            // Start of User Region Form Fields
            const Text('User Region:'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _userRegionController,
              validator: (str) {
                if (str == null || str.isEmpty) {
                  return 'Please Enter User Region';
                }
                return null;
              },
              onSaved: (str) {
                _userRegionController.text = str!;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.explore_rounded),
                hintText: 'Enter User Region',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),

            // Start of Village Form Field
            const Text("User Village"),
            SizedBox(
              height: 10.0,
            ),
            FormHelper.dropDownWidget(
                context, "Select Village", this.vilId, this.vilList,
                (onChangedVal) {
              this.vilId = onChangedVal;
              // Assign onChangedVal to _selectedVil to save to shared pref
              _selectedVil = vilMasterList
                  .where((vil) => vil["ID"].toString() == onChangedVal)
                  .first["Name"]
                  .toString();
              print("Selected vil: $onChangedVal");
              setState(() {});
            }, (onValidateVal) {
              if (onValidateVal == null) {
                return 'Please select Village';
              }
              return null;
            },
                borderColor: Theme.of(context).primaryColor,
                borderFocusColor: Theme.of(context).primaryColor,
                borderRadius: 10,
                optionValue: "ID",
                optionLabel: "Name"),
            const SizedBox(
              height: 10,
            ),
            // Start of Save Button
            ElevatedButton.icon(
              onPressed: () async {
                if (_key.currentState != null &&
                    _key.currentState!.validate()) {
                  _key.currentState?.save();
                  await updateProfile();
                  Navigator.pop(context, 'success');
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
