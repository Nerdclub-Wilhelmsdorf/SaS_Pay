import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sasmobile/initial/first_account.dart';
import 'package:sasmobile/initial/first_account_pin.dart';
import 'package:sasmobile/utils/register_account.dart';
import 'package:sasmobile/utils/verify_account.dart';

var canContinue = false.obs;

class ContinueAccountSetup extends StatelessWidget {
  const ContinueAccountSetup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        height: MediaQuery.sizeOf(context).height * 0.08,
        child: Obx(() => FilledButton(
            onPressed: canContinue.isTrue
                ? () async {
                    Get.defaultDialog(
                        title: "Laden...",
                        onCancel: null,
                        barrierDismissible: false,
                        onWillPop: () => Future.value(false),
                        content: const CircularProgressIndicator());

                    var response = await accountverificiation(
                        valueaccount, valueaccountpin);
                    Get.back();
                    if (response.data != "account verified") {
                      showFailedDialog(response);
                    } else {
                      registerAccount(valueaccount, valueaccountpin);
                      Get.toNamed("/home");
                      Get.snackbar("Registrierung Erfolgreich!",
                          "Viel Spaß mit der App!");
                    }
                  }
                : null,
            child: const Text(
              "Weiter",
              style: TextStyle(fontSize: 18),
            ))));
  }
}

void showFailedDialog(response) async {
  switch (response.data) {
    case "account suspended":
      Get.defaultDialog(
          title: "Fehler!",
          middleText:
              "Ihr Konto wurde gesperrt. Versuchen Sie es später erneut.");
    case "account does not exist":
      Get.defaultDialog(
          title: "Fehler!",
          middleText:
              "Das Konto existiert nicht. Überprüfen Sie Ihre Eingaben.");
    case "error verifying account":
      Get.defaultDialog(
          title: "Fehler!",
          middleText:
              "Es ist ein Fehler aufgetreten. Versuchen Sie es später erneut.");
    case "failed to verify account":
      Get.defaultDialog(
          title: "Fehler!",
          middleText: "Falsche PIN. Überprüfen Sie Ihre Eingaben.");
    default:
      Get.defaultDialog(
          title: "Fehler!",
          middleText:
              "Es ist ein Fehler aufgetreten. Versuchen Sie es später erneut.");
  }
}
