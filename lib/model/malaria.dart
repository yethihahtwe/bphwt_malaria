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
      required String act24,
      required String act24Amount,
      required String act18,
      required String act18Amount,
      required String act12,
      required String act12Amount,
      required String act6,
      required String act6Amount,
      required String chloroquine,
      required String chloroquineAmount,
      required String primaquine,
      required String primaquineAmount,
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
      required String usrName,
      required String usrId}) {
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
      'act24': act24,
      'act24_amount': act24Amount,
      'act18': act18,
      'act18_amount': act18Amount,
      'act12': act12,
      'act12_amount': act12Amount,
      'act6': act6,
      'act6_amount': act6Amount,
      'chloroquine': chloroquine,
      'chloroquine_amount': chloroquineAmount,
      'primaquine': primaquine,
      'primaquine_amount': primaquineAmount,
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
      'usr_name': usrName,
      'usr_id': usrId
    };
  }
}
