import 'package:contact_diary_7/contact_model.dart';
import 'package:flutter/material.dart';

class ContactListProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  void add(ContactModel contact) {
    contactList.add(contact);
    notifyListeners();
  }

  void remove(int i) {
    contactList.removeAt(i);
    notifyListeners();
  }

  void edit(int index, ContactModel contact) {
    contactList[index] = contact;
    notifyListeners();
  }

}
