class ShippingAddress {
  final String recipient;
  final String phone;
  final String? zipCode;
  final String address;
  final String? detailAddress;
  final String? memo;

  ShippingAddress({
    required this.recipient,
    required this.phone,
    this.zipCode,
    required this.address,
    this.detailAddress,
    this.memo,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      recipient: json['recipient']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      zipCode: (json['zipCode'] ?? json['zip_code'])?.toString(),
      address: json['address']?.toString() ?? '',
      detailAddress: (json['detailAddress'] ?? json['detail_address'])
          ?.toString(),
      memo: json['memo']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {'recipient': recipient, 'phone': phone, 'address': address};
    if (zipCode != null) {
      map['zipCode'] = zipCode!;
    }
    if (detailAddress != null) {
      map['detailAddress'] = detailAddress!;
    }
    if (memo != null) {
      map['memo'] = memo!;
    }
    return map;
  }
}
