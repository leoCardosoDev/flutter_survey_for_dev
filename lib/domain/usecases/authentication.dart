import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class Authenticathion {
  Future<AccountEntity>? auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String secret;
  const AuthenticationParams({required this.email, required this.secret});
  
  @override
  List<Object?> get props => [email, secret];
}
