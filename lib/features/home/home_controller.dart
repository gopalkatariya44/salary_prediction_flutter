import 'dart:developer';

import '../../common_imports.dart';
import 'home_services.dart';

class HomeController extends GetxController {
  TextEditingController workYearCont = TextEditingController();

  RxString experienceLevel = "".obs;
  RxList<String> experienceLevelList = <String>[].obs;

  RxString employmentType = "".obs;
  RxList<String> employmentTypeList = <String>[].obs;

  RxString jobTitle = "".obs;
  RxList<String> jobTitleList = <String>[].obs;

  RxString salaryCurrency = "".obs;
  RxList<String> salaryCurrencyList = <String>[].obs;

  RxString employeeResidence = "".obs;
  RxList<String> employeeResidenceList = <String>[].obs;

  TextEditingController remoteRatioCont = TextEditingController();

  RxString companyLocation = "".obs;
  RxList<String> companyLocationList = <String>[].obs;

  RxString companySize = "".obs;
  RxList<String> companySizeList = <String>[].obs;
  TextEditingController salaryCont = TextEditingController();

  RxString prediction = "".obs;

  predict() async {
    var features = [
      workYearCont.text,
      experienceLevel.value,
      employmentType.value,
      jobTitle.value,
      salaryCurrency.value,
      employeeResidence.value,
      remoteRatioCont.text,
      companyLocation.value,
      companySize.value,
    ];
    Response pred = await SalaryPredict().predictSalary(features);
    if (pred.statusCode == 200) {
      prediction.value = "\$${pred.body['prediction']}";
    } else {
      prediction.value = "Something went wrong";
    }
    log("$features -> ${prediction.value}", name: "Features -> Prediction");
  }

  @override
  void onInit() async {
    Response experienceLevelL = await SalaryPredict().experienceLevel();
    for (var element in experienceLevelL.body['experience_level_list']) {
      experienceLevelList.add(element);
    }
    experienceLevel.value = experienceLevelList[0];

    Response employmentTypeL = await SalaryPredict().employmentType();
    for (var element in employmentTypeL.body['employment_type_list']) {
      employmentTypeList.add(element);
    }
    employmentType.value = employmentTypeList[0];

    Response jobTitleL = await SalaryPredict().jobTitle();
    for (var element in jobTitleL.body['job_title_list']) {
      jobTitleList.add(element);
    }
    jobTitle.value = jobTitleList[0];

    Response salaryCurrencyL = await SalaryPredict().salaryCurrency();
    for (var element in salaryCurrencyL.body['salary_currency_list']) {
      salaryCurrencyList.add(element);
    }
    salaryCurrency.value = salaryCurrencyList[0];

    Response employeeResidenceL = await SalaryPredict().employeeResidence();
    for (var element in employeeResidenceL.body['employee_residence_list']) {
      employeeResidenceList.add(element);
    }
    employeeResidence.value = employeeResidenceList[0];

    Response companyLocationL = await SalaryPredict().companyLocation();
    for (var element in companyLocationL.body['company_location_list']) {
      companyLocationList.add(element);
    }
    companyLocation.value = companyLocationList[0];

    Response companySizeL = await SalaryPredict().companySize();
    for (var element in companySizeL.body['company_size_list']) {
      companySizeList.add(element);
    }
    companySize.value = companySizeList[0];
    super.onInit();
  }
}
