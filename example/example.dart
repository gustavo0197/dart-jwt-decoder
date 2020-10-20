import 'package:jwt_decoder/jwt_decoder.dart';

main() {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Ikd1c3Rhdm8iLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6NDczNDYxNTg1OH0.hh-TTBPS8z-UxdmfXWn7AwW2y_Lq3aPnlIQdqV2KEC4";

  /* decode() method will decode your token's payload */
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  // Now you can use your decoded token
  print(decodedToken["name"]);

  /* isExpired() - you can use this method to know if your token is already expired or not.
  An useful method when you have to handle sessions and you want the user
  to authenticate if has an expired token */
  bool isTokenExpired = JwtDecoder.isExpired(token);

  if (!isTokenExpired) {
    // The user should authenticate
  }

  /* getExpirationDate() - this method returns the expiration date of the token */
  DateTime expirationDate = JwtDecoder.getExpirationDate(token);

  // 2025-01-13 13:04:18.000
  print(expirationDate);

  /* getTokenTime() - You can use this method to know how old your token is */
  Duration tokenTime = JwtDecoder.getTokenTime(token);

  // 15
  print(tokenTime.inDays);
}
