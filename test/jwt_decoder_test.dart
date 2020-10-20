import 'package:flutter_test/flutter_test.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Ikd1c3Rhdm8iLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6NDczNDYxNTg1OH0.hh-TTBPS8z-UxdmfXWn7AwW2y_Lq3aPnlIQdqV2KEC4";
const expiredToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE1MjYyMzkwMjJ9.GMdV0dx1F8rZuHUebeXL5tR2DROlc03IuDc2DeDTExI";

void main() {
  test("Decode a valid token", () {
    expect(JwtDecoder.decode(token)["name"], "Gustavo");
  });

  test("Decode an invalid token", () {
    expect(JwtDecoder.decode(""), null);
  });

  test("isExpired? Valid and no expired token", () {
    expect(JwtDecoder.isExpired(token), false);
  });

  test("isExpired? Valid but expired token", () {
    expect(JwtDecoder.isExpired(expiredToken), true);
  });

  test("isExpired? Invalid token", () {
    expect(JwtDecoder.isExpired("lñaslksa"), true);
  });

  test("Expiration date", () {
    expect(
        JwtDecoder.getExpirationDate(token).isAfter(new DateTime.now()), true);
  });

  test("Expiration time", () {
    expect(JwtDecoder.getTokenTime(token).inDays, greaterThan(1));
  });
}
