import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite/sqflite.dart';

class SynchronizationData {
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await InternetConnectionChecker().hasConnection) {
        print("Mobile data and internet connection available.");
        return true;
      } else {
        print('No internet');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await InternetConnectionChecker().hasConnection) {
        print('wifi data and internet connection available');
        return true;
      } else {
        print('No internet');
        return false;
      }
    } else {
      print('Neither mobile data or wifi avaialble');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
    Database database = await openDatabase('malaria.db');
    List<Map<String, dynamic>> data =
        await database.rawQuery('SELECT * FROM malaria');
    await database.close();
    return data;
  }

  String prepareDataForAPI(List<Map<String, dynamic>> data) {
    return jsonEncode({'data': data});
  }

  Future<http.Response> uploadDataToAPI(String data) async {
    http.Client client = new http.Client();
    http.Response response = await client.post(
        Uri.parse('https://backpackteam.org/malaria/sqflite-sync.php'),
        headers: {'Content-Type': 'application/json'},
        body: data);
    client.close();
    return response;
  }

  Future<void> handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Upload successful');
      print(response.body);
    } else {
      print('Upload failed');
      print(response.body);
    }
  }
}
