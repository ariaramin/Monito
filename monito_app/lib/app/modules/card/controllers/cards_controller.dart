import 'package:get/get.dart' show BoolExtension, Get, GetxController, Inst, ListExtension, Rx, RxList, Trans;
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/card.dart';
import 'package:monito/app/data/providers/card_repository.dart';

class CardsController extends GetxController {
  static CardsController get instance => Get.find();

  final CardRepository _cardRepository = CardRepository.instance;

  RxList<Card> cardList = <Card>[].obs;

  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    // Set dummy data to show loading
    cardList.value = [
      Card.empty,
      Card.empty,
    ];
    super.onInit();
  }

  @override
  void onReady() {
    getCards();
    super.onReady();
  }

  Future<void> getCards() async {
    isLoading.value = true;
    try {
      cardList.value = await _cardRepository.getCardList();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_cards_error'.tr).showDialog();
    } finally {
      isLoading.value = false;
    }
  }
}
