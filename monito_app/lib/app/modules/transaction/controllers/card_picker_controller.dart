import 'package:get/get.dart' show GetxService, Rx, RxList;
import 'package:monito/app/data/models/card.dart';

abstract class CardPickerController extends GetxService {
  late RxList<Card> availableCards;

  late Rx<Card> selectedCard;

  void openCardPicker();

  Future<void> getCards();

  void selectCard(int index);
}
