//ToDo: Make use of Keychain to store the account details
import 'package:async/async.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

import 'package:get_storage/get_storage.dart';
import 'package:sasmobile/main.dart';

void registerAccount(name, pinParameter) async {
  pin = pinParameter;
  id = name;

  final box = GetStorage();
  box.write("isInitial", "false");
  await FlutterKeychain.put(key: "accountName", value: name);
  await FlutterKeychain.put(key: "accountPin", value: pinParameter);
}

Future<List<dynamic>> getAccountData() async {
  var futureGroup = FutureGroup();
  futureGroup.add(FlutterKeychain.get(key: "accountName"));
  futureGroup.add(FlutterKeychain.get(key: "accountPin"));
  futureGroup.close();
  return await futureGroup.future;
}
