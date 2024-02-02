import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Address {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? role;
  @HiveField(3)
  String? username;
  @HiveField(4)
  Ing? billing;
  @HiveField(5)
  Ing? shipping;

  Address({
    this.id,
    this.email,
    this.role,
    this.username,
    this.billing,
    this.shipping,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        email: json["email"],
        role: json["role"],
        username: json["username"],
        billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
        shipping:
            json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role": role,
        "username": username,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
      };
}

@HiveType(typeId: 1)
class Ing {
  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? company;
  @HiveField(3)
  String? address1;
  @HiveField(4)
  String? address2;
  @HiveField(5)
  String? city;
  @HiveField(6)
  String? postcode;
  @HiveField(7)
  String? country;
  @HiveField(8)
  String? state;
  @HiveField(9)
  String? email;
  @HiveField(10)
  String? phone;

  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
    this.email,
    this.phone,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        postcode: json["postcode"],
        country: json["country"],
        state: json["state"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "postcode": postcode,
        "country": country,
        "state": state,
        "email": email,
        "phone": phone,
      };
}
