import 'package:bphwt/database/shared_pref_helper.dart';
import 'package:bphwt/screen/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/nav_bar.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  // String to display value to widget
  String _userName = '';
  String _userState = '';
  String _userTspMimu = '';
  String _userTspEho = '';
  String _userArea = '';
  String _userRegion = '';
  String _userVil = '';

  @override
  void initState() {
    super.initState();
    // Get Values from Shared Preferences
    // Get User Name if present
    SharedPrefHelper.getUserName().then((name) {
      setState(() {
        _userName = name ?? 'Please Update';
      });
    });
    // Get User State if present
    SharedPrefHelper.getUserState().then((state) {
      setState(() {
        _userState = state ?? 'Please Update';
      });
    });
    // Get User MIMU Township if present
    SharedPrefHelper.getUserTspMimu().then((tspmimu) {
      setState(() {
        _userTspMimu = tspmimu ?? 'Please Update';
      });
    });
    // Get User EHO Township if present
    SharedPrefHelper.getUserTspEho().then((tspeho) {
      setState(() {
        _userTspEho = tspeho ?? 'Please Update';
      });
    });
    // Get User Area if present
    SharedPrefHelper.getUserArea().then((area) {
      setState(() {
        _userArea = area ?? 'Please Update';
      });
    });
    // Get User Region if present
    SharedPrefHelper.getUserRegion().then((region) {
      setState(() {
        _userRegion = region ?? 'Please Update';
      });
    });
    // Get User Village if present
    SharedPrefHelper.getUserVil().then((vil) {
      setState(() {
        _userVil = vil ?? 'Please Update';
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
        title: Text('User Profile'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Container(
              width: 200.0,
              height: 150.0,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Image.asset('assets/images/logo.png')),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
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
                      child: Container(
                        child: Text('User State/Division: ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Container(child: Text(_userState)),
                  ],
                ),
                SizedBox(height: 20.0),
                // User MIMU Township Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('User MIMU Township: ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Container(child: Text(_userTspMimu)),
                  ],
                ),
                SizedBox(height: 20.0),
                // User EHO Township Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('User EHO Township: ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Container(child: Text(_userTspEho)),
                  ],
                ),
                SizedBox(height: 20.0),
                // User Area Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('User Area: ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Container(child: Text(_userArea)),
                  ],
                ),
                SizedBox(height: 20.0),
                // User Region Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('User Region: ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Container(child: Text(_userRegion)),
                  ],
                ),
                SizedBox(height: 20.0),
                // User Village Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('User Village: ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Container(child: Text(_userVil)),
                  ],
                ),
                SizedBox(height: 20.0),
                // Edit User Profile Button
                ElevatedButton.icon(
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
                    icon: Icon(Icons.edit),
                    label: const Text('Edit User Profile')),

                // Delete User Profile Button
                ElevatedButton.icon(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                    },
                    icon: Icon(Icons.delete_forever),
                    label: const Text('Delete User Profile'))
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
