import 'dart:io' show File;

import 'package:excel/excel.dart';
import 'package:get/get.dart' show ExtensionDialog, Get, Trans;
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/widgets/status_dialog.dart';
import 'package:path_provider/path_provider.dart'
    show getExternalStorageDirectory;
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show JalaliExt;

Future<void> generateExcelFile(
  String fileName,
  List<Transaction> transactions,
) async {
  // Create a new Excel document
  var excel = Excel.createExcel();

  // Add a sheet
  Sheet? sheet = excel['Sheet1'];

  // Add headers
  List<CellValue> headers = [
    TextCellValue('category'.tr),
    TextCellValue('card'.tr),
    TextCellValue('description'.tr),
    TextCellValue('amount'.tr),
    TextCellValue('date'.tr),
  ];

  // Insert the header row
  sheet.insertRowIterables(headers, 0);

  // Add data rows
  for (int i = 0; i < transactions.length; i++) {
    Transaction transaction = transactions[i];
    sheet.insertRowIterables([
      TextCellValue(transaction.category.title),
      TextCellValue(transaction.card.title),
      TextCellValue(transaction.description),
      IntCellValue(transaction.amount),
      TextCellValue(transaction.date.formatFullDate()),
    ], i + 1); // Rows start at 0, so data starts at row 1
  }

  // Save the Excel file
  var fileBytes = excel.save();

  // Get the application documents directory (valid for both iOS and Android)
  var directory = await getExternalStorageDirectory();

  if (directory != null) {
    String path = '${directory.path}/$fileName.xlsx';
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    Get.dialog(
      StatusDialog(
        message: 'excel_file_saved'.trParams({'path': path}),
        status: Status.success,
      ),
    );
  } else {
    Get.dialog(
      StatusDialog(
        message: 'storage_access_error'.tr,
        status: Status.error,
      ),
    );
  }
}
