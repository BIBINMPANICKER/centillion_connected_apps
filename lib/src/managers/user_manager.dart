import 'package:centillion/src/models/user_model.dart';

class User {

  // function that returns true if the user exists else false
  bool authUser(UserModel userModel) {
    if (userModel.email == 'siddarth.kumar@centilliontech.in' &&
        userModel.password == '123456789') {
      return true;
    }
    return false;
  }
}

final user = User();
