import 'package:bphwt/database/shared_pref_helper.dart';
import 'package:bphwt/screen/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/nav_bar.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  // String to display value to widget
  String _userId = '';
  String _userName = '';
  String _userState = '';
  String _userTspMimu = '';
  String _userTspEho = '';
  String _userArea = '';
  String _userRegion = '';
  String _userVil = '';

// Bool to check profile setup
  bool _isComplete = true;

  @override
  void initState() {
    super.initState();
    // Get Values from Shared Preferences
    // Get User Name if present
    SharedPrefHelper.getUserId().then((id) {
      setState(() {
        _userId = id ?? '';
      });
    });
    // Get User Name if present
    SharedPrefHelper.getUserName().then((name) {
      setState(() {
        _userName = name ?? '';
      });
    });
    // Get User State if present
    SharedPrefHelper.getUserState().then((state) {
      setState(() {
        _userState = state ?? '';
      });
    });
    // Get User MIMU Township if present
    SharedPrefHelper.getUserTspMimu().then((tspmimu) {
      setState(() {
        _userTspMimu = tspmimu ?? '';
      });
    });
    // Get User EHO Township if present
    SharedPrefHelper.getUserTspEho().then((tspeho) {
      setState(() {
        _userTspEho = tspeho ?? '';
      });
    });
    // Get User Area if present
    SharedPrefHelper.getUserArea().then((area) {
      setState(() {
        _userArea = area ?? '';
      });
    });
    // Get User Region if present
    SharedPrefHelper.getUserRegion().then((region) {
      setState(() {
        _userRegion = region ?? '';
      });
    });
    // Get User Village if present
    SharedPrefHelper.getUserVil().then((vil) {
      setState(() {
        _userVil = vil ?? '';
      });
    });
  }

// State for Bottom Navigation Bar
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// Build starts here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('User Profile'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
              width: 100.0,
              height: 100.0,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(71, 158, 158, 158),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5.0))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Image.asset('assets/images/logo.png')),
        ),
        const SizedBox(height: 20.0),
        Center(
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              children: [
                // User ID Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User ID: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 2, child: Text(_userId)),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // User Name Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User Name: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 1, child: Text(_userName)),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // User State/Division Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User State/Division: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 1, child: Text(_userState)),
                  ],
                ),
                const SizedBox(height: 20.0),
                // User MIMU Township Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User MIMU Township: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 1, child: Text(_userTspMimu)),
                  ],
                ),
                const SizedBox(height: 20.0),
                // User EHO Township Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User EHO Township: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 1, child: Text(_userTspEho)),
                  ],
                ),
                const SizedBox(height: 20.0),
                // User Area Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User Area: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 1, child: Text(_userArea)),
                  ],
                ),
                const SizedBox(height: 20.0),
                // User Region Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User Region: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 1, child: Text(_userRegion)),
                  ],
                ),
                const SizedBox(height: 20.0),
                // User Village Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('User Village: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Expanded(flex: 1, child: Text(_userVil)),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Edit User Profile Button
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile()),
                            );
                            if (result == 'success') {
                              SharedPrefHelper.getUserName().then((name) {
                                setState(() {
                                  _userName = name ?? '';
                                });
                              });
                              SharedPrefHelper.getUserState().then((state) {
                                setState(() {
                                  _userState = state ?? '';
                                });
                              });
                              SharedPrefHelper.getUserTspMimu().then((tspmimu) {
                                setState(() {
                                  _userTspMimu = tspmimu ?? '';
                                });
                              });
                              SharedPrefHelper.getUserTspEho().then((tspeho) {
                                setState(() {
                                  _userTspEho = tspeho ?? '';
                                });
                              });
                              SharedPrefHelper.getUserArea().then((area) {
                                setState(() {
                                  _userArea = area ?? '';
                                });
                              });
                              SharedPrefHelper.getUserRegion().then((region) {
                                setState(() {
                                  _userRegion = region ?? '';
                                });
                              });
                              SharedPrefHelper.getUserVil().then((vil) {
                                setState(() {
                                  _userVil = vil ?? '';
                                });
                              });
                            }
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit User Profile')),
                    ),
                    const SizedBox(width: 20),

                    // Delete User Profile Button
                    if (_userName != '' ||
                        _userState != '' ||
                        _userTspMimu != '' ||
                        _userTspEho != '' ||
                        _userArea != '' ||
                        _userRegion != '' ||
                        _userVil != '')
                      Expanded(
                        flex: 1,
                        child: ElevatedButton.icon(
                            onPressed: () async {
                              bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        '??????????????????????????????????????? ??????????????????????????????????????? ?????????????????????????????? ??????????????????????????????????',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('OK'))
                                      ],
                                    );
                                  });
                              if (confirmDelete == true) {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.clear();
                                setState(() {
                                  _userName = '';
                                  _userState = '';
                                  _userTspMimu = '';
                                  _userTspEho = '';
                                  _userArea = '';
                                  _userRegion = '';
                                  _userVil = '';
                                });
                              }
                            },
                            icon: Icon(Icons.delete_forever),
                            label: const Text('Delete User Profile')),
                      )
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
