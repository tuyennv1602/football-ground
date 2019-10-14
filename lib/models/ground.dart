class Ground {
  int id;
  int status;
  int userId;
  String name;
  String rule;
  String avatar;
  double deposit;
  String address;
  double lat;
  double lng;
  double rating;
  bool rated;
  int wardId;
  int districtId;
  int provinceId;
  int countField;
  int countFreeField;

  Ground(
      {this.id,
      this.status,
      this.userId,
      this.name,
      this.rule,
      this.avatar,
      this.deposit,
      this.address,
      this.lat,
      this.lng,
      this.rating,
      this.rated,
      this.wardId,
      this.districtId,
      this.provinceId,
      this.countField,
      this.countFreeField});

  Ground.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userId = json['userId'];
    name = json['name'];
    rule = json['rule'];
    avatar = json['avatar'];
    deposit = json['deposit'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    rating = json['rating'];
    rated = json['rated'];
    wardId = json['ward_id'];
    districtId = json['district_id'];
    provinceId = json['province_id'];
    countField = json['count_field'];
    countFreeField = json['count_free_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['rule'] = this.rule;
    data['avatar'] = this.avatar;
    data['deposit'] = this.deposit;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['rating'] = this.rating;
    data['rated'] = this.rated;
    data['ward_id'] = this.wardId;
    data['district_id'] = this.districtId;
    data['province_id'] = this.provinceId;
    data['count_field'] = this.countField;
    data['count_free_field'] = this.countFreeField;
    return data;
  }

  Map<String, dynamic> createGroundJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rule'] = this.rule;
    data['deposit'] = 0;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['ward_id'] = this.wardId;
    data['district_id'] = this.districtId;
    data['province_id'] = this.provinceId;
    return data;
  }
}
