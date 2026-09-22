import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:pointycastle/export.dart';
import 'dart:convert';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/api.dart';

class AuthRepository {
  final _storage =  FlutterSecureStorage();
  Future<void> saveCredentials(String email, String password) async{
    final r = Random.secure();
    final saltBytes = Uint8List.fromList(
      List.generate(32, (_)=> r.nextInt(256))
    );

    final salt = hex.encode(saltBytes);
    final passwordBytes = utf8.encode(password);

    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    final params = Pbkdf2Parameters(saltBytes, 100000, 32);
    pbkdf2.init(params);

    final hashedPasswordBytes = pbkdf2.process(passwordBytes);
    final hashedPassword = hex.encode(hashedPasswordBytes);



    await _storage.write(key: "user_email", value: email);
    await _storage.write(key: "user_password", value: hashedPassword);
    await _storage.write(key: "user_password_salt", value: salt);

  }

  Future<String?> getEmail()async{
    await _storage.read(key: "user_email");
  }

  Future<bool> isUserRegistered() async{
    final email = await _storage.read(key: "user_email");
    return email != null;
  }

  //TODO перепроверить функцию тк осуществялется вход с неправильной почтой


  Future<bool> verifyCredentials(String email, String password) async {
    try {
      // Достаем ВСЕ сохраненные данные
      final storedEmail = await _storage.read(key: "user_email");
      final storedHash = await _storage.read(key: "user_password");
      final storedSaltHex = await _storage.read(key: "user_password_salt");

      //  Если хоть чего-то нет - сразу false
      if (storedEmail == null || storedHash == null || storedSaltHex == null) {
        print("❌ ОШИБКА: Данные не найдены в хранилище");
        return false;
      }

      //Проверяем, совпадает ли email
      if (storedEmail.trim().toLowerCase() != email.trim().toLowerCase()) {
        print("❌ ОШИБКА: Email не совпадает. Введен: $email, Сохранен: $storedEmail");
        return false;
      }

      // Восстанавливаем соль и хешируем введенный пароль
      final saltBytes = Uint8List.fromList(hex.decode(storedSaltHex));
      final passwordBytes = utf8.encode(password);

      final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
      final params = Pbkdf2Parameters(saltBytes, 100000, 32);
      pbkdf2.init(params);

      final computedHashBytes = pbkdf2.process(passwordBytes);
      final computedHash = hex.encode(computedHashBytes);

      // Сравниваем хеши
      final isValid = computedHash == storedHash;
      print(" Проверка пароля: ${isValid ? 'УСПЕХ' : 'ПРОВАЛ'}");
      print("   Введенный хеш: $computedHash");
      print("   Сохраненный хеш: $storedHash");

      return isValid;

    } catch (e) {
      print(" Ошибка в verifyCredentials: $e");
      return false;
    }
  }
}