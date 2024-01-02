import 'package:meta/meta.dart';
import 'dart:convert';

class ContactList {
  List<ContactListElement> contactList;

  ContactList({
    required this.contactList,
  });

  factory ContactList.fromRawJson(String str) => ContactList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactList.fromJson(Map<String, dynamic> json) => ContactList(
    contactList: List<ContactListElement>.from(json["contact_list"].map((x) => ContactListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contact_list": List<dynamic>.from(contactList.map((x) => x.toJson())),
  };
}

class ContactListElement {
  String name;
  String number;
  String email;

  ContactListElement({
    required this.name,
    required this.number,
    required this.email,
  });

  factory ContactListElement.fromRawJson(String str) => ContactListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactListElement.fromJson(Map<String, dynamic> json) => ContactListElement(
    name: json["name"],
    number: json["number"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "number": number,
    "email": email,
  };
}
