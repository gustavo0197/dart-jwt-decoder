## JWT Decoder

You can use this library to decode a Json Web Token.
You can also know if the token is already expired or not.

## Getting Started

#### Decode a token
```dart
main() {
  String yourToken = "Your JWT";
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  
  // If the token has a valid format, you will get a Map<String, dynamic>
  // Your decoded token can look like:
  // { 
  //    "sub": "1234567890", 
  //    "name": "Gustavo", 
  //    "iat": 1516239022, 
  //    "exp": 1516239022, 
  //    "randomKey": "something else" 
  // }
}
```

#### Know if the token is expired
```dart
main() {
  String yourToken = "Your JWT";
  bool hasExpired = JwtDecoder.isExpired(yourToken);
  
  // You will get a true / false response
  // true: if the token is already expired
  // false: if the token is not expired
}
```
