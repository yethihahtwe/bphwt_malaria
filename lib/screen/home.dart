import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:bphwt/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:bphwt/database/synchronize.dart';
import '../widgets/nav_bar.dart';
import 'add_malaria.dart';
import 'malaria_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Index for bottom navigation bar
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  SynchronizationData _synchronizationData = SynchronizationData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300] ?? Colors.grey,

      // Start of Sync FAB
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: "btnSync",
          // backgroundColor: Colors.blueGrey,
          onPressed: () async {
            if (await SynchronizationData.isInternet()) {
              List<Map<String, dynamic>> data =
                  await _synchronizationData.getDataFromDatabase();
              String dataJson = _synchronizationData.prepareDataForAPI(data);
              http.Response response =
                  await _synchronizationData.uploadDataToAPI(dataJson);
              _synchronizationData.handleResponse(response);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Text('No internet connection'),
                    );
                  });
            }
          },
          child: const Icon(Icons.sync),
        ),
        const SizedBox(
          height: 20.0,
        ),

        // Start of Add FAB
        FloatingActionButton(
          heroTag: "btnAdd",
          // backgroundColor: Colors.blueGrey,
          onPressed: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                    //fullscreenDialog: true,
                    builder: (context) => const AddMalaria()));
            if (result == 'success') {
              setState(() {});
            }
          },
          child: const Icon(Icons.add),
        )
      ]),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'BPHWT Malaria Case Register',
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [Colors.blueGrey, Color.fromARGB(255, 50, 65, 71)],
        //         begin: Alignment.bottomLeft,
        //         end: Alignment.topRight),
        //   ),
        // ),
      ),
      body: FutureBuilder<List<Map>>(
        future: DatabaseHelper().getAllMalaria(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  height: 50,
                  margin:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Name',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text('Age',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 1,
                          child: Text('Gender',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 1,
                          child: Text('Date',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 167, 167, 167),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 5.0),
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.95,
                  // Start of Malaria Record List View
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Map? malaria = snapshot.data?[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                        // Start of Each Record
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                color: Color.fromARGB(255, 225, 225, 225),
                                width: 1.0,
                              ))),
                          child: ListTile(
                            minLeadingWidth: 1,
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    malaria?['name'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    malaria?['age'] + ' yrs',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    malaria?['sex'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    malaria?['test_date'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                            ),

                            // Go to Detail Button
                            leading: IconButton(
                              iconSize: 15,
                              icon: const Icon(Icons.arrow_forward_ios_rounded),
                              onPressed: () async {
                                var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MalariaDetail(
                                            id: malaria?['id'],
                                            name: malaria?['name'],
                                            age: malaria?['age'],
                                            sex: malaria?['sex'])));
                                if (result == 'success') {
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
