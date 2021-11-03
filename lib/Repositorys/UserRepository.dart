import 'package:sfs_poc/Models/User.dart';
import 'package:sfs_poc/objectbox.g.dart';

class UserRepository {
  final Store _store;
  final Box<User> _box;

  UserRepository(this._store) : _box = _store.box() {}
}

abstract class IDatabaseRepositories {
  UserRepository get users;
}

class ObjectBoxRepositories implements IDatabaseRepositories {
  final Store _store;

  final UserRepository people;

  static Future<IDatabaseRepositories> create() async =>
      ObjectBoxRepositories._(await openStore());

  ObjectBoxRepositories._(this._store) : people = UserRepository(_store);

  @override
  // TODO: implement user
  UserRepository get users => throw UnimplementedError();
}
