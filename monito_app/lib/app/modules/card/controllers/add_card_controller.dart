import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show FormState, GlobalKey, TextEditingController;
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/core/extensions/getx_extension.dart';
import 'package:monito/app/data/models/bank.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/data/providers/card_repository.dart';
import 'package:monito/app/widgets/status_dialog.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show Jalali;
import 'package:persian_number_utility/persian_number_utility.dart';

import 'cards_controller.dart';

class AddCardController extends GetxController {
  final AuthRepository _authRepository = AuthRepository.instance;

  final CardRepository _cardRepository = CardRepository.instance;

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // text field controllers
  final TextEditingController title = TextEditingController();
  final TextEditingController number = TextEditingController();

  RxString cardNumber = ''.obs;

  Rx<Jalali?> cardExpireDate = Rx<Jalali?>(null);

  Rx<Bank> cardBank = Bank.empty.obs;

  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    number.addListener(() => cardNumber.value = number.text);
    debounce(
      cardNumber,
      (value) {
        String cleanValue = value.removeAllWhitespace;
        if (cleanValue.isEmpty) {
          cardBank.value = Bank.empty;
        }
        if (cleanValue.length >= 6) {
          fetchCardBank(cleanValue.substring(0, 6));
        }
      },
      time: const Duration(milliseconds: 1000),
    );
  }

  @override
  void onClose() {
    title.dispose();
    number.dispose();
    super.onClose();
  }

  void addCard() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await _cardRepository.addCard({
          'user': _authRepository.user.value.id,
          'bank': cardBank.value.id,
          'title': title.text.trim(),
          'number': int.parse(number.text.removeAllWhitespace.trim()),
          'expireDate': cardExpireDate.value?.toDateTime().toIso8601String(),
        });
        Get.dialog(StatusDialog(
          message: 'add_card_success'.tr,
          status: Status.success,
        ));
        CardsController.instance.getCards();
        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } on ApiException catch (exception) {
        Failure(message: exception.message).showDialog();
      } catch (e) {
        Failure(message: 'add_card_error'.tr).showDialog();
      } finally {
        isLoading.value = false;
      }
    }
  }

  void selectExpireDate() async {
    final expireDate =
        await Get.showDatePicker(initialDate: cardExpireDate.value);
    if (expireDate != null) {
      cardExpireDate.value = expireDate;
    }
  }

  void fetchCardBank(String number) async {
    try {
      String bankName = number.getBankNameFromCardNumber();
      cardBank.value = await _cardRepository.getCardBank(bankName);
    } catch (_) {
      cardBank.value = Bank.empty;
    }
  }
}
