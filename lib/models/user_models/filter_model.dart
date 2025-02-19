// class FilterModel {
//   bool? status;
//   String? message;
//   int? guestUser;
//   List<ServiceFilter>? serviceFilter;

//   FilterModel({this.status, this.message, this.guestUser, this.serviceFilter});

//   FilterModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     guestUser = json['guest_user'];
//     if (json['serviceFilter'] != null) {
//       serviceFilter = <ServiceFilter>[];
//       json['serviceFilter'].forEach((v) {
//         serviceFilter!.add(new ServiceFilter.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = status;
//     data['message'] = message;
//     data['guest_user'] = guestUser;
//     if (serviceFilter != null) {
//       data['serviceFilter'] =
//           serviceFilter!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ServiceFilter {
//   int? id;
//   String? serviceName;
//   String? categoryName;
//   String? address;
//   String? lat;
//   String? lon;
//   List<String>? serviceImages;
//   int? isLike;
//   int? totalReviewCount;
//   String? averageReviewStar;

//   ServiceFilter(
//       {this.id,
//       this.serviceName,
//       this.categoryName,
//       this.address,
//       this.lat,
//       this.lon,
//       this.serviceImages,
//       this.isLike,
//       this.totalReviewCount,
//       this.averageReviewStar});

//   ServiceFilter.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceName = json['service_name'];
//     categoryName = json['category_name'];
//     address = json['address'];
//     lat = json['lat'];
//     lon = json['lon'];
//     serviceImages = json['service_images'].cast<String>();
//     isLike = json['isLike'];
//     totalReviewCount = json['total_review_count'];
//     averageReviewStar = json['average_review_star'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['service_name'] = serviceName;
//     data['category_name'] = categoryName;
//     data['address'] = address;
//     data['lat'] = lat;
//     data['lon'] = lon;
//     data['service_images'] = serviceImages;
//     data['isLike'] = isLike;
//     data['total_review_count'] = totalReviewCount;
//     data['average_review_star'] = averageReviewStar;
//     return data;
//   }
// }

// class FilterModel {
//   bool? status;
//   String? message;
//   int? guestUser;
//   List<ServiceFilter>? serviceFilter;
//   int? totalPage;

//   FilterModel(
//       {this.status,
//       this.message,
//       this.guestUser,
//       this.serviceFilter,
//       this.totalPage});

//   FilterModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     guestUser = json['guest_user'];
//     if (json['serviceFilter'] != null) {
//       serviceFilter = <ServiceFilter>[];
//       json['serviceFilter'].forEach((v) {
//         serviceFilter!.add(new ServiceFilter.fromJson(v));
//       });
//     }
//     totalPage = json['total_page'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = status;
//     data['message'] = message;
//     data['guest_user'] = guestUser;
//     if (serviceFilter != null) {
//       data['serviceFilter'] = serviceFilter!.map((v) => v.toJson()).toList();
//     }
//     data['total_page'] = totalPage;
//     return data;
//   }
// }

// class ServiceFilter {
//   int? id;
//   String? serviceName;
//   String? categoryName;
//   String? address;
//   String? lat;
//   String? lon;
//   List<String>? serviceImages;
//   int? isLike;
//   int? totalReviewCount;
//   String? averageReviewStar;

//   ServiceFilter(
//       {this.id,
//       this.serviceName,
//       this.categoryName,
//       this.address,
//       this.lat,
//       this.lon,
//       this.serviceImages,
//       this.isLike,
//       this.totalReviewCount,
//       this.averageReviewStar});

//   ServiceFilter.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceName = json['service_name'];
//     categoryName = json['category_name'];
//     address = json['address'];
//     lat = json['lat'];
//     lon = json['lon'];
//     serviceImages = json['service_images'].cast<String>();
//     isLike = json['isLike'];
//     totalReviewCount = json['total_review_count'];
//     averageReviewStar = json['average_review_star'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = id;
//     data['service_name'] = serviceName;
//     data['category_name'] = categoryName;
//     data['address'] = address;
//     data['lat'] = lat;
//     data['lon'] = lon;
//     data['service_images'] = serviceImages;
//     data['isLike'] = isLike;
//     data['total_review_count'] = totalReviewCount;
//     data['average_review_star'] = averageReviewStar;
//     return data;
//   }
// }

// ignore_for_file: prefer_collection_literals

// class FilterModel {
//   bool? status;
//   String? message;
//   int? guestUser;
//   List<ServiceFilter>? serviceFilter;
//   int? totalPage;

//   FilterModel(
//       {this.status,
//       this.message,
//       this.guestUser,
//       this.serviceFilter,
//       this.totalPage});

//   FilterModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     guestUser = json['guest_user'];
//     if (json['serviceFilter'] != null) {
//       serviceFilter = <ServiceFilter>[];
//       json['serviceFilter'].forEach((v) {
//         serviceFilter!.add(ServiceFilter.fromJson(v));
//       });
//     }
//     totalPage = json['total_page'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['status'] = status;
//     data['message'] = message;
//     data['guest_user'] = guestUser;
//     if (serviceFilter != null) {
//       data['serviceFilter'] =
//           serviceFilter!.map((v) => v.toJson()).toList();
//     }
//     data['total_page'] = totalPage;
//     return data;
//   }
// }

// class ServiceFilter {
//   int? id;
//   String? serviceName;
//   String? categoryName;
//   String? address;
//   String? lat;
//   String? lon;
//   List<String>? serviceImages;
//   int? isLike;
//   int? totalReviewCount;
//   String? averageReviewStar;

//   ServiceFilter(
//       {this.id,
//       this.serviceName,
//       this.categoryName,
//       this.address,
//       this.lat,
//       this.lon,
//       this.serviceImages,
//       this.isLike,
//       this.totalReviewCount,
//       this.averageReviewStar});

//   ServiceFilter.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serviceName = json['service_name'];
//     categoryName = json['category_name'];
//     address = json['address'];
//     lat = json['lat'];
//     lon = json['lon'];
//     serviceImages = json['service_images'].cast<String>();
//     isLike = json['isLike'];
//     totalReviewCount = json['total_review_count'];
//     averageReviewStar = json['average_review_star'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['service_name'] = serviceName;
//     data['category_name'] = categoryName;
//     data['address'] = address;
//     data['lat'] = lat;
//     data['lon'] = lon;
//     data['service_images'] = serviceImages;
//     data['isLike'] = isLike;
//     data['total_review_count'] = totalReviewCount;
//     data['average_review_star'] = averageReviewStar;
//     return data;
//   }
// }


class FilterModel {
  bool? status;
  String? message;
  List<ServiceFilter>? serviceFilter;
  int? totalPage;

  FilterModel({this.status, this.message, this.serviceFilter, this.totalPage});

  FilterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['serviceFilter'] != null) {
      serviceFilter = <ServiceFilter>[];
      json['serviceFilter'].forEach((v) {
        serviceFilter!.add(ServiceFilter.fromJson(v));
      });
    }
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (serviceFilter != null) {
      data['serviceFilter'] =
          serviceFilter!.map((v) => v.toJson()).toList();
    }
    data['total_page'] = totalPage;
    return data;
  }
}

class ServiceFilter {
  int? id;
  String? serviceName;
  String? categoryName;
  String? address;
  String? lat;
  String? lon;
  int? isFeatured;
  List<String>? serviceImages;
  int? isLike;
  int? totalReviewCount;
  String? averageReviewStar;
  String? vendorFirstName;
  String? vendorLastName;
  String? vendorEmail;
  String? vendorImage;
  int? totalYearsCount;
  String? priceRange;

  ServiceFilter(
      {this.id,
      this.serviceName,
      this.categoryName,
      this.address,
      this.lat,
      this.lon,
      this.isFeatured,
      this.serviceImages,
      this.isLike,
      this.totalReviewCount,
      this.averageReviewStar,
      this.vendorFirstName,
      this.vendorLastName,
      this.vendorEmail,
      this.vendorImage,
      this.totalYearsCount,
      this.priceRange});

  ServiceFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    categoryName = json['category_name'];
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    isFeatured = json['is_featured'];
    serviceImages = json['service_images'].cast<String>();
    isLike = json['isLike'];
    totalReviewCount = json['total_review_count'];
    averageReviewStar = json['average_review_star'];
    vendorFirstName = json['vendor_first_name'];
    vendorLastName = json['vendor_last_name'];
    vendorEmail = json['vendor_email'];
    vendorImage = json['vendor_image'];
    totalYearsCount = json['total_years_count'];
    priceRange = json['price_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['service_name'] = serviceName;
    data['category_name'] = categoryName;
    data['address'] = address;
    data['lat'] = lat;
    data['lon'] = lon;
    data['is_featured'] = isFeatured;
    data['service_images'] = serviceImages;
    data['isLike'] = isLike;
    data['total_review_count'] = totalReviewCount;
    data['average_review_star'] = averageReviewStar;
    data['vendor_first_name'] = vendorFirstName;
    data['vendor_last_name'] = vendorLastName;
    data['vendor_email'] = vendorEmail;
    data['vendor_image'] = vendorImage;
    data['total_years_count'] = totalYearsCount;
    data['price_range'] = priceRange;
    return data;
  }
}
