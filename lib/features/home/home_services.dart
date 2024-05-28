import '../../common_imports.dart';

class SalaryPredict extends GetConnect {
  String rootUrl = "http://192.168.248.58:5001";
  experienceLevel() => get("$rootUrl/experience_level");
  employmentType() => get("$rootUrl/employment_type");
  jobTitle() => get("$rootUrl/job_title");
  salaryCurrency() => get("$rootUrl/salary_currency");
  employeeResidence() => get("$rootUrl/employee_residence");
  companyLocation() => get("$rootUrl/company_location");
  companySize() => get("$rootUrl/company_size");
  predictSalary(data) async {
    return await post("$rootUrl/predict", {"features": data});
  }
}
