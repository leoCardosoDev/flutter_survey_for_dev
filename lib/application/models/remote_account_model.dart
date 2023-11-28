import 'package:survey_for_dev/domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;
  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map<String, dynamic> json) => RemoteAccountModel(json['accessToken']);
  AccountEntity toDomain() => AccountEntity(accessToken);
}
