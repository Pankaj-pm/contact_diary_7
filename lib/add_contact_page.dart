import 'package:contact_diary_7/contact_model.dart';
import 'package:contact_diary_7/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddContactPage extends StatefulWidget {
  void Function()? changeTheme;

  AddContactPage({super.key, this.changeTheme});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  int cIndex = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> fk = GlobalKey<FormState>();
  bool isEdit=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page"),
      ),
      body: Form(
        key: fk,
        child: Stepper(
          currentStep: cIndex,
          onStepContinue: () {
            isEdit=true;
            if (cIndex < 2) {
              cIndex++;
              setState(() {});
            }
          },
          onStepCancel: () {
            if (cIndex > 0) {
              cIndex--;
              setState(() {});
            }
          },
          onStepTapped: (value) {
            cIndex = value;
            setState(() {});

          },
          controlsBuilder: (context, details) {
            return Row(
              children: [
                if (details.currentStep != 2)
                  ElevatedButton(onPressed: details.onStepContinue, child: Text("Continue")),
                SizedBox(
                  width: 10,
                ),
                if (details.currentStep != 0) OutlinedButton(onPressed: details.onStepCancel, child: Text("Back")),
              ],
            );
          },
          steps: [
            Step(
              title: Text("Step 1"),
              content: TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
                onChanged: (value) {},
              ),
              label: Text("S1"),
              isActive: cIndex >= 0,
              state: (nameController.text.isEmpty && isEdit && cIndex!=0) ? StepState.error : StepState.complete,
            ),
            Step(
                title: Text("Step 2"),
                content: TextFormField(
                  controller: contactController,
                  decoration: InputDecoration(hintText: "Number"),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                isActive: cIndex >= 1),
            Step(
                title: Text("Step 3"),
                content: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter Email";
                    } else if (!isEmail(value ?? "")) {
                      return "Enter valid Email";
                    }
                    return null;
                  },
                ),
                isActive: cIndex >= 2),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // widget.changeTheme?.call();
          contactList.add(ContactModel(
            email: emailController.text,
            name: nameController.text,
            number: contactController.text,
          ));
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}
