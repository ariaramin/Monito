import 'package:get/get.dart'
    show
        ExtensionBottomSheet,
        Get,
        GetNavigation,
        GetxController,
        Inst,
        RxString,
        StringExtension,
        Trans;
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/data/models/money_unit.dart';
import 'package:monito/app/data/models/settings.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/modules/auth/views/profile_screen.dart';
import 'package:monito/app/modules/auth/widgets/about.dart';
import 'package:monito/app/widgets/app_bottom_sheet.dart';
import 'package:monito/gen/assets.gen.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final AuthRepository _authRepository = AuthRepository.instance;

  final GetStorage _storage = GetStorage();

  List<MoneyUnit> moneyUnits = [
    MoneyUnit(image: Assets.images.iran, title: 'toman'.tr),
    MoneyUnit(image: Assets.images.unitedStates, title: 'dollar'.tr),
    MoneyUnit(image: Assets.images.europeanUnion, title: 'euro'.tr),
    MoneyUnit(image: Assets.images.unitedKingdom, title: 'pound'.tr),
    MoneyUnit(image: Assets.images.turkey, title: 'lire'.tr),
    MoneyUnit(image: Assets.images.unitedArabEmirates, title: 'dirham'.tr),
  ];

  List<String> dateTypes = [
    'jalali'.tr,
    'gregorian'.tr,
  ];

  RxString selectedMoneyUnit = 'toman'.tr.obs;

  RxString selectedDateType = 'jalali'.tr.obs;

  List<Settings> settings = [];

  @override
  void onInit() {
    super.onInit();
    selectedDateType.value = _loadDateTypeFromStorage();
    selectedMoneyUnit.value = _loadMoneyUnitFromStorage();
    settings = [
      Settings(
        icon: Iconsax.edit_25,
        title: 'edit_profile'.tr,
        onTap: () => Get.toNamed(AppRoutes.editProfile),
      ),
      Settings(
        icon: Iconsax.password_check5,
        title: 'change_password'.tr,
        onTap: () => Get.toNamed(AppRoutes.changePassword),
      ),
      Settings(
        icon: Iconsax.money5,
        title: 'money_unit'.tr,
        onTap: () => openMoneyUnitSheet(),
      ),
      Settings(
        icon: Iconsax.calendar5,
        title: 'date_type'.tr,
        onTap: () => openDateTypeSheet(),
      ),
      Settings(
        icon: Iconsax.information5,
        title: 'about_app'.tr,
        onTap: () => openAboutSheet(),
      ),
    ];
  }

  void openMoneyUnitSheet() => Get.bottomSheet(
        const AppBottomSheet(
          child: MoneyUnitList(),
        ),
      );

  void openDateTypeSheet() => Get.bottomSheet(
        const AppBottomSheet(
          child: DateTypeList(),
        ),
      );

  void openAboutSheet() => Get.bottomSheet(
        const AppBottomSheet(
          child: About(),
        ),
      );

  void changeDateType(String dateTyp) {
    selectedDateType.value = dateTyp;
    _storage.write('dateType', dateTyp);
    Get.back();
  }

  String _loadDateTypeFromStorage() {
    return _storage.read<String>('dateType') ?? 'jalali'.tr;
  }

  void changeMoneyUnit(MoneyUnit moneyUnit) {
    selectedMoneyUnit.value = moneyUnit.title;
    _storage.write('moneyUnit', moneyUnit.title);
    Get.back();
  }

  String _loadMoneyUnitFromStorage() {
    return _storage.read<String>('moneyUnit') ?? 'toman'.tr;
  }

  void logout() => _authRepository.logout();
}
