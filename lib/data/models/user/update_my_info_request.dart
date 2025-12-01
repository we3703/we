class UpdateMyInfoRequest {
  final String? memberName;
  final String? phone;

  UpdateMyInfoRequest({this.memberName, this.phone});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (memberName != null) {
      data['member_name'] = memberName;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    return data;
  }
}
