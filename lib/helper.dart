import 'package:connectivity/connectivity.dart';

Future<bool> checkConnectionInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}