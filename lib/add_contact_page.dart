import 'package:contact_diary_7/add_contact_provider.dart';
import 'package:contact_diary_7/contact_model.dart';
import 'package:contact_diary_7/contact_provider.dart';
import 'package:contact_diary_7/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddContactPage extends StatefulWidget {
  // final ContactModel? contactModel;
  final int? index;

  const AddContactPage({super.key,  this.index});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  String title = "Add Contact";

  @override
  void initState() {
    super.initState();

    var cp = Provider.of<ContactProvider>(context, listen: false);

    if(widget.index!=null){
      var clp = Provider.of<ContactListProvider>(context, listen: false);
      var contactModel= clp.contactList[widget.index!];
      cp.nameController.text = contactModel?.name ?? "";
      cp.contactController.text = contactModel?.number ?? "";
      cp.emailController.text = contactModel?.email ?? "";
      title = "Edit Contact";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Form(
        key: Provider.of<ContactProvider>(context, listen: false).fk,
        child: Consumer<ContactProvider>(
          builder: (context, contactProvider, child) {
            return Stepper(
              currentStep: contactProvider.cIndex,
              onStepContinue: () {
                contactProvider.nextStep();
              },
              onStepCancel: () {
                contactProvider.previousStep();
              },
              onStepTapped: (value) {
                contactProvider.changeStep(value);
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
                    controller: contactProvider.nameController,
                    decoration: InputDecoration(hintText: "Name"),
                    onChanged: (value) {},
                  ),
                  label: Text("S1"),
                  isActive: contactProvider.cIndex >= 0,
                  state: (contactProvider.nameController.text.isEmpty &&
                          contactProvider.isEdit &&
                          contactProvider.cIndex != 0)
                      ? StepState.error
                      : StepState.complete,
                ),
                Step(
                    title: Text("Step 2"),
                    content: TextFormField(
                      controller: contactProvider.contactController,
                      decoration: InputDecoration(hintText: "Number"),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    isActive: contactProvider.cIndex >= 1),
                Step(
                    title: Text("Step 3"),
                    content: TextFormField(
                      controller: contactProvider.emailController,
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
                    isActive: contactProvider.cIndex >= 2),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // widget.changeTheme?.call();
          var cp = Provider.of<ContactProvider>(context, listen: false);
          if (cp.fk.currentState?.validate() ?? false) {
            ContactModel cm = ContactModel(
                email: cp.emailController.text, name: cp.nameController.text, number: cp.contactController.text);

            if (widget.index != null) {
              Provider.of<ContactListProvider>(context, listen: false).edit(widget.index ?? 0, cm);
            } else {
              Provider.of<ContactListProvider>(context, listen: false).add(cm);
            }

            Provider.of<ContactProvider>(context, listen: false).reset();

            Navigator.pop(context);
          }
        },
        child: Icon(widget.index != null ? Icons.edit : Icons.add),
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
