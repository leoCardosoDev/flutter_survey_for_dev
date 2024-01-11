import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../application/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;
  LocalStorageAdapter({required this.secureStorage});

  @override
  Future<void> saveSecure({required String key, required value}) async {
    await secureStorage.write(key: key, value: value);
  }
}
