import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:said/services/models/user.dart';

class SaidSessionManager {
  static Future<void> storeUser(
      {required int id,
      required String username,
      required String email,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? sex,
      int? age}) async {
    var sessionManager = SessionManager();
    await sessionManager.set("id", id);
    await sessionManager.set("username", username);
    await sessionManager.set("email", email);

    // nullable values:
    if (firstName != null) await sessionManager.set("firstName", firstName);
    if (lastName != null) await sessionManager.set("lastName", lastName);
    if (phoneNumber != null) {
      await sessionManager.set("phoneNumber", phoneNumber);
    }
    if (sex != null) await sessionManager.set("sex", sex);
    if (age != null) await sessionManager.set("age", age);

    await sessionManager.set("isLoggedIn", true);
  }

  static Future<void> storeScreeningStatus(bool mustSeeDoctor) async {
    await SessionManager().set("mustSeeDoctor", mustSeeDoctor);
  }

  static Future<void> storeJwt(String jwtToken) async {
    await SessionManager().set("jwt", jwtToken);
  }

  static Future<dynamic> getSessionValue(String key) async {
    return await SessionManager().get(key);
  }

  static Future<void> clearSession() async {
    await clearUser();
    await clearJwt();
  }

  static Future<User?> getUser() async {
    var sessionManager = SessionManager();
    if (!(await containsKey('id'))) {
      return null;
    }

    return User(
        id: await sessionManager.get('id'),
        username: await sessionManager.get('username'),
        email: await sessionManager.get('email'),
        firstName: await sessionManager.get('firstName'),
        lastName: await sessionManager.get('lastName'),
        phoneNumber: await sessionManager.get('phoneNumber'),
        age: await sessionManager.get('age'),
        sex: await sessionManager.get('sex'));
  }

  static Future<void> clearUser() async {
    var sessionManager = SessionManager();
    await sessionManager.remove("id");
    await sessionManager.remove("username");
    await sessionManager.remove("email");
    await sessionManager.remove("firstName");
    await sessionManager.remove("lastName");
    await sessionManager.remove("phoneNumber");
    await sessionManager.remove("sex");
    await sessionManager.remove("age");
    await sessionManager.remove("isLoggedIn");
  }

  static Future<void> clearJwt() async {
    await SessionManager().remove("jwt");
  }

  static Future<bool> containsKey(String key) async {
    return await SessionManager().containsKey(key);
  }
}
