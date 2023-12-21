import 'package:contact_diary_7/add_contact_page.dart';
import 'package:contact_diary_7/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  void Function()? changeTheme;
  String? name;

  HomePage({super.key, this.changeTheme, this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Switch(
            value: isDark,
            onChanged: (value) {
              isDark = value;
              widget.changeTheme?.call();
              // setState(() {});
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          var contactModel = contactList[index];
          return ListTile(
            title: Text(contactModel.name??""),
            subtitle: Text(contactModel.number??""),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // widget.changeTheme?.call();
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage(changeTheme: widget.changeTheme),));
          setState(() {

          });
          print("back avi gya");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
