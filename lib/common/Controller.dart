import 'package:get/get_state_manager/src/simple/get_controllers.dart';

var serversite = 'http://127.0.0.1:8000/';

class ControllerPage extends GetxController {
  late String authtoken;
  void setToken(token) {
    print('*' * 20);
    print(token);
    authtoken = 'Bearer ' + token;
    update();
  }
}
