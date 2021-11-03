import 'package:sfs_poc/Models/DataContext.dart';
import 'package:sfs_poc/Models/User.dart';

import '../objectbox.g.dart';

class AuthRepository {
  Future<int> AddOrUpdateUser(User user) async {
    int result = 0;

    await openStore().then((Store store) {
      var _box = store.box<User>();
      user.id = 1;
      result = _box.put(user); // Add
      store.close();
    });
    return result;

    // if (kDebugMode) {
    //   print('Attempted Login');
    // }
    // await Future.delayed(const Duration(seconds: 3));
    // if (kDebugMode) {
    //   print('logged in');
    // }
    // throw Exception('Failed Login');
  }
}
