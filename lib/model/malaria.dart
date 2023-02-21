class Malaria {
  static Map<String, dynamic> insertMalaria(
      {required String rxMonth,
      required String rxYear,
      required String testDate,
      required String name,
      required String age,
      required String address,
      required String sex,
      required String pregnancy,
      required String rdtBool,
      required String rdtPosResult,
      required String symptom,
      required String medicine,
      required String medicineAmount,
      required String refer,
      required String death,
      required String receiveRx,
      required String travel,
      required String job,
      required String remark,
      required String state,
      required String tspMimu,
      required String tspEho,
      required String area,
      required String region,
      required String vil,
      required String usrName}) {
    return {
      'rx_month': rxMonth,
      'rx_year': rxYear,
      'test_date': testDate,
      'name': name,
      'age': age,
      'address': address,
      'sex': sex,
      'pregnancy': pregnancy,
      'rdt_bool': rdtBool,
      'rdt_pos_result': rdtPosResult,
      'symptom': symptom,
      'medicine': medicine,
      'medicine_amount': medicineAmount,
      'refer': refer,
      'death': death,
      'receive_rx': receiveRx,
      'travel': travel,
      'job': job,
      'remark': remark,
      'state': state,
      'tsp_mimu': tspMimu,
      'tsp_eho': tspEho,
      'area': area,
      'region': region,
      'vil': vil,
      'usr_name': usrName
    };
  }
}
