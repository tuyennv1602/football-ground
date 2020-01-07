class AddressInfo {
  int id;
  String wardId;
  String wardName;
  String districtId;
  String districtName;
  String provinceId;
  String provinceName;

  AddressInfo(
      {this.id,
      this.wardId,
      this.wardName,
      this.districtId,
      this.districtName,
      this.provinceId,
      this.provinceName});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wardId = json['ward_id'];
    wardName = json['ward_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ward_id'] = this.wardId;
    data['ward_name'] = this.wardName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    return data;
  }

  String get getAddress => '$wardName, $districtName, $provinceName';
}
