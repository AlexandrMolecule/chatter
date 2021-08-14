import 'dart:convert';

class DataUtils{
  String createToken(String userId) {
    final payload = json.encode({'user_id': userId});
    final payloadBytes = utf8.encode(payload);
    final payloadB64 = base64.encode(payloadBytes);
    return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.$payloadB64.devtoken';
  }
}