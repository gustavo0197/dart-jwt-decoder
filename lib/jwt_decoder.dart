library jwt_decoder;

import 'dart:convert';

class JwtDecoder {
  /// Decode a string JWT token into a `Map<String, dynamic>`
  /// containing the decoded JSON payload.
  ///
  /// Note: header and signature are not returned by this method.
  ///
  /// Throws [FormatException] if parameter is not a valid JWT token.
  static Map<String, dynamic> decode(String token) {
    final splitToken = token.split("."); // Split the token by '.'
    if (splitToken.length != 3) {
      throw FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      final decodedPayload = jsonDecode(payloadString);

      // Return the decoded payload
      return decodedPayload;
    } catch (error) {
      throw FormatException('Invalid payload');
    }
  }

  /// Decode a string JWT token into a `Map<String, dynamic>`
  /// containing the decoded JSON payload.
  ///
  /// Note: header and signature are not returned by this method.
  ///
  /// Returns null if the token is not valid
  static Map<String, dynamic>? tryDecode(String token) {
    try {
      return decode(token);
    } catch (error) {
      return null;
    }
  }

  /// Tells whether a token is expired.
  ///
  /// Returns true if the token is valid, false if it is expired.
  ///
  /// Throws [FormatException] if parameter is not a valid JWT token.
  static bool isExpired(String token) {
    final expirationDate = getExpirationDate(token);
    // If the current date is after the expiration date, the token is already expired
    return DateTime.now().isAfter(expirationDate);
  }

  /// Returns token expiration date
  ///
  /// Throws [FormatException] if parameter is not a valid JWT token.
  static DateTime getExpirationDate(String token) {
    final decodedToken = decode(token);

    final expirationDate = DateTime.fromMillisecondsSinceEpoch(0).add(Duration(seconds: decodedToken['exp'].toInt()));
    return expirationDate;
  }

  /// Returns token issuing date (iat)
  ///
  /// Throws [FormatException] if parameter is not a valid JWT token.
  static Duration getTokenTime(String token) {
    final decodedToken = decode(token);

    final issuedAtDate = DateTime.fromMillisecondsSinceEpoch(0).add(Duration(seconds: decodedToken["iat"]));
    return DateTime.now().difference(issuedAtDate);
  }

  /// Returns remaining time until expiry date.
  ///
  /// Throws [FormatException] if parameter is not a valid JWT token.
  static Duration getRemainingTime(String token) {
    final expirationDate = getExpirationDate(token);

    return expirationDate.difference(DateTime.now());
  }
}
