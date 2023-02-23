import 'package:flutter_easyloading/flutter_easyloading.dart';
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
              EasyLoading.showProgress(0.1,
                  status: 'အချက်အလက်များ ပေးပို့နေပါသည်');
              String dataJson = _synchronizationData.prepareDataForAPI(data);
              http.Response response =
                  await _synchronizationData.uploadDataToAPI(dataJson);
              _synchronizationData.handleResponse(response);
              EasyLoading.showSuccess('အချက်အလက်များ ပေးပို့ပြီးပါပြီ');
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
      ),
      body: FutureBuilder<List<Map>>(
        future: DatabaseHelper().getAllMalaria(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 200.0,
                      height: 150.0,
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
                  const SizedBox(height: 20),
                  const Text(
                      'ငှက်ဖျားလူနာ ဆေးကုသမှုမှတ်တမ်းများ ဖြည့်သွင်းထားခြင်းမရှိပါ။\nစေတနာ့ဝန်ထမ်း၏ အချက်အလက်များ ပထမဦးစွာ ဖြည့်သွင်းရန် Profile ကိုနှိပ်ပါ။\nငှက်ဖျားဆေးကုသမှုမှတ်တမ်းများ စတင်ဖြည့်သွင်းရန် + ကိုနှိပ်ပါ'),
                ],
              ));
            } else {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Name',
                            style: GoogleFonts.poppins(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text('Age',
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 1,
                            child: Text('Gender',
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 2,
                            child: Text('RDT Date',
                                style: GoogleFonts.poppins(
                                    fontSize: 11, fontWeight: FontWeight.bold)))
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
                    height: MediaQuery.of(context).size.height * 0.72,
                    width: MediaQuery.of(context).size.width * 0.95,
                    // Start of Malaria Record List View
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Map? malaria = snapshot.data?[index];
                        return Container(
                          // Start of Each Record
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        iconSize: 15,
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        onPressed: () async {
                                          var result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MalariaDetail(
                                                      id: malaria?['id'],
                                                      rxMonth:
                                                          malaria?['rx_month'],
                                                      rxYear:
                                                          malaria?['rx_year'],
                                                      testDate:
                                                          malaria?['test_date'],
                                                      name: malaria?['name'],
                                                      age: malaria?['age'],
                                                      address:
                                                          malaria?['address'],
                                                      sex: malaria?['sex'],
                                                      pregnancy:
                                                          malaria?['pregnancy'],
                                                      rdtBool:
                                                          malaria?['rdt_bool'],
                                                      rdtPosResult: malaria?[
                                                          'rdt_pos_result'],
                                                      symptom:
                                                          malaria?['symptom'],
                                                      medicine:
                                                          malaria?['medicine'],
                                                      medicineAmount: malaria?[
                                                          'medicine_amount'],
                                                      refer: malaria?['refer'],
                                                      death: malaria?['death'],
                                                      receiveRx: malaria?[
                                                          'receive_rx'],
                                                      travel:
                                                          malaria?['travel'],
                                                      job: malaria?['job'],
                                                      remark:
                                                          malaria?['remark'],
                                                      state: malaria?['state'],
                                                      tspMimu:
                                                          malaria?['tsp_mimu'],
                                                      tspEho:
                                                          malaria?['tsp_eho'],
                                                      area: malaria?['area'],
                                                      region:
                                                          malaria?['region'],
                                                      vil: malaria?['vil'],
                                                      usrName: malaria?[
                                                          'usr_name'])));
                                          if (result == 'success') {
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ),
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
                              ),
                              const Divider()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
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
