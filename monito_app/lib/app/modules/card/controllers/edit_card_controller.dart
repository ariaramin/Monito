import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/core/extensions/getx_extension.dart';
import 'package:monito/app/data/models/bank.dart';
import 'package:monito/app/data/models/card.dart' as card_model;
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/data/providers/card_repository.dart';
import 'package:monito/app/widgets/status_dialog.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show Jalali;

import 'card_detail_controller.dart';

class EditCardController extends GetxController {
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

  late final card_model.Card card;

  @override
  void onInit() {
    super.onInit();
    card = Get.arguments as card_model.Card;

    // Set initial values
    title.text = card.title;
    number.text = card.number.toString();
    cardExpireDate.value = card.expireDate;
    cardBank.value = card.bank ?? Bank.empty;

    // Add listener to card number
    number.addListener(() => cardNumber.value = number.text);

    // Debounce card number input
    debounce(
      cardNumber,
      (value) {
        final cleanValue = value.removeAllWhitespace;
        if (cleanValue.length >= 6) {
          fetchCardBank(cleanValue.substring(0, 6));
        }
      },
      time: const Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    title.dispose();
    number.dispose();
    super.onClose();
  }

  void editCard() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await _cardRepository.editCard(card.id, {
          'user': _authRepository.user.value.id,
          'bank': cardBank.value.id,
          'title': title.text.trim(),
          'number': int.parse(number.text.removeAllWhitespace.trim()),
          'expireDate': cardExpireDate.value?.toDateTime().toIso8601String(),
        });
        Get.dialog(StatusDialog(
          message: 'edit_card_success'.tr,
          status: Status.success,
        ));
        CardDetailController.instance.getCard();
        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } on ApiException catch (exception) {
        Failure(message: exception.message).showDialog();
      } catch (e) {
        Failure(message: 'edit_card_error'.tr).showDialog();
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
