import 'package:encrypt/encrypt.dart' as encrypt;

class Encryption {
  String generateKey() {
    final key = encrypt.Key.fromLength(32); // AES-256 key (32 bytes = 256 bits)
    return key.base64; // Return the key as a base64-encoded string
  }

  encrypt.Key getKeyFromBase64(String base64Key) {
    return encrypt.Key.fromBase64(base64Key);
  }

  String encryptCode(String code, String base64Key) {
    final key = getKeyFromBase64(base64Key);
    final iv = encrypt.IV.fromLength(16); // Generate a random IV
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Encrypt the code
    final encrypted = encrypter.encrypt(code, iv: iv);

    // Prepend the IV to the encrypted data
    return '${iv.base64}:${encrypted.base64}';
  }

  String decryptCode(String encryptedCodeWithIv, String base64Key) {
    final key = getKeyFromBase64(base64Key);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Extract IV and encrypted data
    final parts = encryptedCodeWithIv.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid encrypted code format');
    }

    final iv = encrypt.IV.fromBase64(parts[0]);
    final encryptedCode = parts[1];

    // Decrypt the code
    final decrypted = encrypter.decrypt64(encryptedCode, iv: iv);
    return decrypted;
  }

  bool compareEncryptedCode(
      String code, String encryptedCodeWithIv, String base64Key) {
    final decryptedCode = decryptCode(encryptedCodeWithIv, base64Key);
    return decryptedCode == code;
  }
}
