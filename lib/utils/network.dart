import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkOn() async {
  var connectivityResult = await(Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
}