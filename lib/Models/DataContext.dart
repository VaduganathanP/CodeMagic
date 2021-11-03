// ignore_for_file: file_names

import '../objectbox.g.dart';
import 'User.dart';

class DataContext {
  /// The Store of this app.
  final Store store;

  /// A Box of users.
  late final Box<User> userBox;

  DataContext(this.store) : userBox = store.box();

  DataContext._create(this.store) {
    userBox = Box<User>(store);

    // Add some demo data if the box is empty.
    if (userBox.isEmpty()) {
      _putDemoData();
    }
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<DataContext> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final _store = await openStore();
    return DataContext._create(_store);
  }

  void _putDemoData() {
    // final demoUsers = [
    //   User(
    //       email: 'vpillappan@smart-structures.com',
    //       firstname: 'Vaduganathan',
    //       lastname: 'Pillappan',
    //       isloggedin: false,
    //       id: 0)
    // ];
    // userBox.putMany(demoUsers);
  }
}

abstract class IDatabaseRepositories {}

class ObjectBoxRepositories implements IDatabaseRepositories {
  final Store _store;

  final DataContext people;

  static Future<IDatabaseRepositories> create() async =>
      ObjectBoxRepositories._(await openStore());

  ObjectBoxRepositories._(this._store) : people = DataContext(_store);
}
