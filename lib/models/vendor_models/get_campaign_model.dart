class GetCampaignModel {
  bool? status;
  String? message;
  List<CampaignData>? campaignData;

  GetCampaignModel({this.status, this.message, this.campaignData});

  GetCampaignModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['campaignData'] != null) {
      campaignData = <CampaignData>[];
      json['campaignData'].forEach((v) {
        campaignData!.add(CampaignData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (campaignData != null) {
      data['campaignData'] = campaignData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CampaignData {
  int? id;
  int? vendorId;
  int? serviceId;
  String? campaignName;
  String? address;
  String? lat;
  String? lon;
  String? areaDistance;
  String? createdAt;
  String? updatedAt;

  CampaignData(
      {this.id,
      this.vendorId,
      this.serviceId,
      this.campaignName,
      this.address,
      this.lat,
      this.lon,
      this.areaDistance,
      this.createdAt,
      this.updatedAt});

  CampaignData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    serviceId = json['service_id'];
    campaignName = json['campaign_name'];
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    areaDistance = json['area_distance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['service_id'] = serviceId;
    data['campaign_name'] = campaignName;
    data['address'] = address;
    data['lat'] = lat;
    data['lon'] = lon;
    data['area_distance'] = areaDistance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
