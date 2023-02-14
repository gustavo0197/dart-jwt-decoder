## 2.0.3
- Fixes the issue with passing `iat` and `exp` as String values. ([#17](https://github.com/gustavo0197/dart-jwt-decoder/issues/17))
- Also, ran `dart format` on the project to fix the formatting issues. ([#14](https://github.com/gustavo0197/dart-jwt-decoder/issues/14))
# [2.0.2] - Changes expiration date's API

- Makes `isExpired` return false when when there's no `exp` claim.
- Makes both `getExpirationDate` and `getRemainingTime` return null when there's no `exp` claim.
- Makes `getTokenTime` return null when there's no `iat` claim.

# [2.0.1] 

- getRemainingTime() method

# [2.0.0]

- Migration to null safety
- Updated SDK dependency version to 2.12.0+
- Avoid all null returns and replaced them with `FormatException` throws when tokens are not valid. This is a breaking change as users expecting null returns will now get an exception instead.
- Added `JwtDecoder` methods documentation.
- Replaced flutter framework dependencies to Dart only dependency.

# [1.0.4] 

- isExpired() and getExpirationDate() the expiration time is converted to int

# [1.0.3] 

- getExpirationDate() returns the expiration date of the token
- getTokenTime() you can use this method to know how old your token is

# [1.0.2] 

- License was added

# [1.0.1] 

- An example file was added

# [1.0.0] 

- decode method will decode your token's payload and return a Map<String, dynamic>
- isExpired method is used to know if a token is already expired or not