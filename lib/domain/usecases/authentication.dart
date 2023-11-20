import '../entities/entities.dart';

abstract class Authenticathion {
  Future<AccountEntity> auth({required String email, String password});
}
