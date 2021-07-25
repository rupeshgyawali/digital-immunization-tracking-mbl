class StatusModel {
  int id;
  String name;

  List<District> district;

  StatusModel({this.id, this.name, this.district});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    if (json['district'] != null) {
      district = <District>[];
      json['district'].forEach((v) {
        district.add(new District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    if (this.district != null) {
      data['district'] = this.district.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  int id;
  String name;
  int provinceId;
  List<MUNVDC> munvdc;

  District({this.id, this.name, this.provinceId, this.munvdc});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
    if (json['munvdc'] != null) {
      munvdc = <MUNVDC>[];
      json['munvdc'].forEach((v) {
        munvdc.add(new MUNVDC.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['province_id'] = this.provinceId;
    if (this.munvdc != null) {
      data['munvdc'] = this.munvdc.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MUNVDC {
  int id;
  String name;
  int districtId;
  List<Ward> ward;

  MUNVDC({this.id, this.name, this.districtId, this.ward});

  MUNVDC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    districtId = json['district_id'];
    if (json['munvdc'] != null) {
      ward = <Ward>[];
      json['ward'].forEach((v) {
        ward.add(new Ward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['district_id'] = this.districtId;
    if (this.ward != null) {
      data['ward'] = this.ward.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ward {
  String name;
  int munvdcId;

  Ward({this.name, this.munvdcId});

  Ward.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    munvdcId = json['munvdc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['munvdc_id'] = this.munvdcId;
    return data;
  }
}
