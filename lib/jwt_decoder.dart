library jwt_decoder;

import 'dart:convert';

class JwtDecoder {
  static Map<String, dynamic> decode(String token) {
    try {
      List<String> splitToken = token.split("."); // Split the token by '.'
      String payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      String normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      String payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      Map<String, dynamic> decodedPayload = jsonDecode(payloadString);

      // Return the decoded payload
      return decodedPayload;
    } catch (error) {
      // If there's an error return null
      return null;
    }
  }

  static bool isExpired(String token) {
    try {
      // Decode the token
      final Map<String, dynamic> decodedToken = decode(token);
      if (decodedToken != null) {
        // Get the expiration date
        final DateTime expirationDate =
            new DateTime.fromMillisecondsSinceEpoch(0)
                .add(new Duration(seconds: decodedToken["exp"]));
        // If the current date is after the expiration date, the token is already expired
        return new DateTime.now().isAfter(expirationDate);
      } else {
        return true;
      }
    } catch (error) {
      return true;
    }
  }

  static DateTime getExpirationDate(String token) {
    final Map<String, dynamic> decodedToken = decode(token);

    if (decodedToken != null) {
      final DateTime expirationDate = new DateTime.fromMillisecondsSinceEpoch(0)
          .add(new Duration(seconds: decodedToken['exp']));
      return expirationDate;
    } else {
      return null;
    }
  }

  static Duration getTokenTime(String token) {
    final Map<String, dynamic> decodedToken = decode(token);

    if (decodedToken != null) {
      final DateTime expirationDate = new DateTime.fromMillisecondsSinceEpoch(0)
          .add(new Duration(seconds: decodedToken["iat"]));
      return new DateTime.now().difference(expirationDate);
    } else {
      return null;
    }
  }
}
