import 'package:loggy/loggy.dart';

import '../../data/datasources/local/user_local_datasource.dart';
import '../../data/datasources/remote/user_remote_datasource.dart';
import '../../data/models/random_user_model.dart';
import '../entities/random_user.dart';

class UserRepository {
  final UserLocalDataSource _localDataSource = UserLocalDataSource();
  final UserRemoteDataSource _remoteDataSource = UserRemoteDataSource();

  UserRepository() {
    logInfo("Starting UserRepository");
  }

  Future<bool> getUser() async {
    try {
      final user = await _remoteDataSource.getUser();
      _localDataSource.addUser(user);
      return true;
    } catch (e) {
      logError("Error getting user: $e");
      return false;
    }
  }

  Future<List<RandomUser>> getAllUsers() async => await _localDataSource.getAllUsers();

  Future<void> deleteUser(id) async => await _localDataSource.deleteUser(id);

  Future<void> deleteAll() async => await _localDataSource.deleteAll();

  Future<void> updateUser(user) async => await _localDataSource.updateUser(user);

}
