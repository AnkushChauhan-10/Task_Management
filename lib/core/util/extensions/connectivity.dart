import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityInBool on Connectivity {
  Future<bool> get isConnected async {
    var val = await checkConnectivity();
    for (var c in val) {
      if (c == ConnectivityResult.wifi || c == ConnectivityResult.mobile) {
        return true;
      }
    }
    return false;
  }
}
