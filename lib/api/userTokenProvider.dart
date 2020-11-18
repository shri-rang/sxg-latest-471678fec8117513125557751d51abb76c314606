import 'package:flutter/cupertino.dart';
import 'package:simple_x_genius/utility/tokenStoreUtil.dart';

class UserTokenProvider extends ChangeNotifier {
  String getUserToken() {
    return StorageUtil.getString('token');
  }

 Future<bool> setUserToken(String token) async {
    var response = await StorageUtil.putString('token', token);
    notifyListeners();
    return response;
  }

  Future<bool>removeUserToken(String key)async{
     var response = await StorageUtil.removeString(key);
    notifyListeners();
      return response;
  }


}
