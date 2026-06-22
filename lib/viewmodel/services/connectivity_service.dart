import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityService {
  static void listen() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        Fluttertoast.showToast(
          msg: "🔴 No Internet Connection",
        );
      } else {
        Fluttertoast.showToast(
          msg: "🟢 Back Online",
        );
      }
    });
  }
}