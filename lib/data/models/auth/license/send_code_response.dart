import 'package:we/data/models/common/simple_response.dart';

class LicenseCodeResponse extends TimestampResponse {
  LicenseCodeResponse({required int expiresIn})
    : super(value: expiresIn, unit: 'seconds');

  factory LicenseCodeResponse.fromJson(Map<String, dynamic> json) {
    return LicenseCodeResponse(expiresIn: json['expiresIn']);
  }

  int get expiresIn => value;
}
