import 'package:flutter_app/utils/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSession {
  String? _token;
  dynamic _user;
  bool checkedStorage = false;

  Future<String?> get token async {
    if (_token != null) return _token;
    if (!checkedStorage) {
      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: "access_token");
      checkedStorage = true;
      if (token != null) {
        _token = token;
        return token;
      }
    }
    return _token;
  }

  dynamic get user async {
    if (_user != null) return _user;
    String? token = await this.token;
    if (token != null) {
      this.endSession();
      // var client = getIt<Client>();
      // client.token = token;
      // await client
      //     .usersApi
      //     .meGet()
      //     .then((value) => _user = value)
      //     .catchError((e) => this.endSession());
    }
    return _user;
  }

  Future startSession(String? token, user) async {
    _token = token;
    _user = user;

    final storage = new FlutterSecureStorage();
    await storage.write(key: "access_token", value: token);

    // getIt<Client>().token = token;
  }

  Future endSession() async {
    _token = null;
    _user = null;

    final storage = new FlutterSecureStorage();
    await storage.write(key: "access_token", value: null);
    checkedStorage = true;

    // getIt<Client>().token = null;
  }
}
