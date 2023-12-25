import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  int cIndex = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> fk = GlobalKey<FormState>();
  bool isEdit = false;

  void nextStep() {
    isEdit = true;
    if (cIndex < 2) {
      cIndex++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (cIndex > 0) {
      cIndex--;
     notifyListeners();
    }
  }

  void changeStep(int index){
    cIndex=index;
    notifyListeners();
  }
}
