import 'package:centillion/src/models/data_model.dart';

class Apps {
  // function that returns list of apps need to display in the home page
  // lust will be dynamic if it is obtained from an API
  List<DataModel> getAppList() {
    List<DataModel> dataModelList = [];
    dataModelList.add(DataModel(
        title: 'Happay',
        subtitle: 'Expense Management',
        image: 'assets/Capture1.png',
        appId: 'com.happay.android.employee'));
    dataModelList.add(DataModel(
        title: 'Oracle',
        subtitle: 'HCM Cloud',
        image: 'assets/Capture3.png',
        appId: 'com.oracle.cloud.hcm.mobile'));
    dataModelList.add(DataModel(
        title: 'HGS',
        subtitle: 'ESS',
        image: 'assets/Capture3.png',
        appId: 'com.hgsbs.ess'));
    return dataModelList;
  }
}

final apps = Apps();
