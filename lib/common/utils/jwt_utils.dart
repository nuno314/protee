import 'package:jwt_decode/jwt_decode.dart';

class JwtUtils {
  static bool isAboutToExpire(
    String token, {
    Duration limit = const Duration(seconds: 5),
  }) {
    try {
      final seprateTokens = token.split(' ');
      var realToken = seprateTokens.first;
      for (final p in seprateTokens) {
        if (p.length > realToken.length) {
          realToken = p;
        }
      }
      final expiryDate = Jwt.getExpiryDate(realToken);
      final currentTime = DateTime.now().toUtc();
      return expiryDate?.subtract(limit).isBefore(currentTime) == true;
    } catch (e) {
      return true;
    }
  }
}
