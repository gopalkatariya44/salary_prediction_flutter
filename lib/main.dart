import 'common/controllers/language_controller.dart';
import 'common_imports.dart';
import 'features/home/home_page.dart';
import 'common/controllers/theme_controller.dart';
import 'features/settings/pages/settings_page.dart';

void main() async {
  await GetStorage.init();
  await Languages.initTranslations();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    final languageController = Get.put(LanguageController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_name'.tr,
        darkTheme: AppThemeData.dark,
        theme: AppThemeData.light,
        themeMode: themeController.themeMode.value,
        initialRoute: AppRoutes.home,
        getPages: [
          GetPage(name: AppRoutes.home, page: () => HomePage()),
          GetPage(name: AppRoutes.settings, page: () => SettingsPage()),
        ],
        locale: languageController.localLanguage.value,
        translations: Languages(),
      ),
    );
  }
}
