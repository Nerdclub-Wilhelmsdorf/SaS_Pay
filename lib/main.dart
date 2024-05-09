import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sasmobile/initial/initial_screen.dart';
import 'package:sasmobile/routes.dart';
import "package:sasmobile/theme.dart";
import 'package:sasmobile/utils/authenticate.dart';
import 'package:sasmobile/utils/ping.dart';
import 'package:sasmobile/utils/register_account.dart';

const url = "https://saswdorf.de:8443";
const token = "test";
String pin = "";
String id = "";
void main() async {
  await GetStorage.init();
  var canConnect = await ping();
  runApp(MainPage(hasConnection: canConnect));
}

class MainPage extends StatefulWidget {
  final bool hasConnection; 
  const MainPage({Key? key, required this.hasConnection}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    if (!isInitialStart()) {
      var data = getAccountData();
      id = data[0];
      pin = data[1];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: const MaterialThemeCustom(TextTheme()).light(),
      darkTheme: const MaterialThemeCustom(TextTheme()).dark(),
      initialRoute: !widget.hasConnection ? "/loading" : isInitialStart() ? "/login" : '/home',
      getPages: appRoutes(),
    );
  }
}
