import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:test/test.dart';

const token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Ikd1c3Rhdm8iLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6NDczNDYxNTg1OH0.hh-TTBPS8z-UxdmfXWn7AwW2y_Lq3aPnlIQdqV2KEC4";
const expiredToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE1MjYyMzkwMjJ9.GMdV0dx1F8rZuHUebeXL5tR2DROlc03IuDc2DeDTExI";
const tokenWithoutExpirationTime =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
const tokenWithoutIatClaim =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIn0.Gfx6VO9tcxwk6xqx9yYzSfebfeakZp5JYIgP_edcw_A";

void main() {
  group('Decode', () {
    test("a valid token", () {
      expect(JwtDecoder.decode(token)["name"], "Gustavo");
    });

    test("an invalid token", () {
      expect(
        () => JwtDecoder.decode(""),
        throwsA(isA<FormatException>()
            .having((e) => e.message, 'message', 'Invalid token')),
      );
    });

    test("an invalid payload", () {
      expect(
        () => JwtDecoder.decode("a.b.c"),
        throwsA(isA<FormatException>()
            .having((e) => e.message, 'message', 'Invalid payload')),
      );
    });
  });

  group('Try decode', () {
    test("a valid token", () {
      expect(JwtDecoder.tryDecode(token)!["name"], "Gustavo");
    });

    test("an invalid token", () {
      expect(JwtDecoder.tryDecode(""), isNull);
    });

    test("an invalid payload", () {
      expect(JwtDecoder.tryDecode("a.b.c"), isNull);
    });
  });

  test("isExpired? Valid and no expired token", () {
    expect(JwtDecoder.isExpired(token), false);
  });

  test("token without exp claim is not expired", () {
    expect(JwtDecoder.isExpired(tokenWithoutExpirationTime), false);
  });

  test("isExpired? Valid but expired token", () {
    expect(JwtDecoder.isExpired(expiredToken), true);
  });

  test("isExpired? Invalid token", () {
    expect(
      () => JwtDecoder.isExpired("lñaslksa"),
      throwsA(isA<FormatException>()
          .having((e) => e.message, 'message', 'Invalid token')),
    );
  });

  test("Expiration date", () {
    expect(
        JwtDecoder.getExpirationDate(token)!.isAfter(new DateTime.now()), true);
  });

  test("expiration date from token without exp claim is null", () {
    expect(JwtDecoder.getExpirationDate(tokenWithoutExpirationTime), isNull);
  });

  test("Expiration date with invalid token", () {
    expect(
      () => JwtDecoder.getExpirationDate("an.invalid.payload"),
      throwsA(isA<FormatException>()
          .having((e) => e.message, 'message', 'Invalid payload')),
    );
  });

  test("Expiration time", () {
    expect(JwtDecoder.getTokenTime(token)!.inDays, greaterThan(1));
  });

  test("token time from token without iat claim is null", () {
    expect(JwtDecoder.getTokenTime(tokenWithoutIatClaim), isNull);
  });

  test("Expiration time with invalid token", () {
    expect(
      () => JwtDecoder.getTokenTime("invalid.token"),
      throwsA(isA<FormatException>()
          .having((e) => e.message, 'message', 'Invalid token')),
    );
  });

  test("Remaining time from now", () {
    expect(JwtDecoder.getRemainingTime(token)!.inSeconds, greaterThan(0));
  });

  test("remaining time from token without exp claim is null", () {
    expect(JwtDecoder.getRemainingTime(token)!.inSeconds, greaterThan(0));
  });
}
