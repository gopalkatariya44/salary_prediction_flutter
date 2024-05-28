import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:salary_prediction/features/home/home_controller.dart';

import '../../common/controllers/language_controller.dart';
import '/common/controllers/theme_controller.dart';

import '../../common_imports.dart';
import 'home_services.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final themeController = Get.put(ThemeController());
  final languageController = Get.put(LanguageController());
  final homeController = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app_name".tr),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.settings);
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Work Year"), hintText: "2020"),
              controller: homeController.workYearCont,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter work year";
                }
                return null;
              },
            ).paddingSymmetric(vertical: 14, horizontal: 10),
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      menuMaxHeight: 400,
                      decoration: const InputDecoration(
                          label: Text("Experience Level")),
                      value: homeController.experienceLevel.value,
                      items: homeController.experienceLevelList
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        homeController.experienceLevel.value = value!;
                      },
                    ).paddingSymmetric(vertical: 14, horizontal: 10),
                  ),
                ),
                Flexible(
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      menuMaxHeight: 400,
                      decoration:
                          const InputDecoration(label: Text("Employment Type")),
                      value: homeController.employmentType.value,
                      items: homeController.employmentTypeList
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        homeController.employmentType.value = value!;
                      },
                    ).paddingSymmetric(vertical: 14, horizontal: 10),
                  ),
                ),
              ],
            ),
            Obx(
              () => DropdownButtonFormField<String>(
                isExpanded: true,
                menuMaxHeight: 400,
                decoration: const InputDecoration(label: Text("Job Title")),
                value: homeController.jobTitle.value,
                items: homeController.jobTitleList
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  homeController.jobTitle.value = value!;
                },
              ).paddingSymmetric(vertical: 14, horizontal: 10),
            ),
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      menuMaxHeight: 400,
                      decoration:
                          const InputDecoration(label: Text("Salary Currency")),
                      value: homeController.salaryCurrency.value,
                      items: homeController.salaryCurrencyList
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        homeController.salaryCurrency.value = value!;
                      },
                    ).paddingSymmetric(vertical: 14, horizontal: 10),
                  ),
                ),
                Flexible(
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      menuMaxHeight: 400,
                      decoration: const InputDecoration(
                          label: Text("Employee Residence")),
                      value: homeController.employeeResidence.value,
                      items: homeController.employeeResidenceList
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        homeController.employeeResidence.value = value!;
                      },
                    ).paddingSymmetric(vertical: 14, horizontal: 10),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Remote Ratio"), hintText: "0 - 100"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter remote aatio";
                }
                return null;
              },
              controller: homeController.remoteRatioCont,
            ).paddingSymmetric(vertical: 14, horizontal: 10),
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      menuMaxHeight: 400,
                      decoration: const InputDecoration(
                          label: Text("Company Location")),
                      value: homeController.companyLocation.value,
                      items: homeController.companyLocationList
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        homeController.companyLocation.value = value!;
                      },
                    ).paddingSymmetric(vertical: 14, horizontal: 10),
                  ),
                ),
                Flexible(
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      menuMaxHeight: 400,
                      decoration:
                          const InputDecoration(label: Text("Company Size")),
                      value: homeController.companySize.value,
                      items: homeController.companySizeList
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        homeController.companySize.value = value!;
                      },
                    ).paddingSymmetric(vertical: 14, horizontal: 10),
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  homeController.predict();
                  Get.dialog(Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CloseButton(),
                          ],
                        ).paddingOnly(left: 10, right: 10),
                        SizedBox(
                          height: 150,
                          child: FittedBox(
                              child: Image.asset("assets/congratulations.gif")),
                        ),
                        const Text(
                          "Predicted Salary",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ).paddingAll(10),
                        Text(
                          homeController.prediction.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.blue,
                          ),
                        ).paddingAll(10),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ));
                }
              },
              child: const Text("Predict"),
            ).paddingSymmetric(vertical: 14, horizontal: 10),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
