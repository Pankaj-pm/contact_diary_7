import 'package:contact_diary_7/add_contact_page.dart';
import 'package:contact_diary_7/theme_provider.dart';
import 'package:contact_diary_7/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("Home Page");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) => Switch(
                    value: themeProvider.isDark,
                    onChanged: (value) {
                      themeProvider.changeTheme();
                      // isDark = value;
                      // setState(() {});
                    },
                  )),
        ],
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          var contactModel = contactList[index];
          return ListTile(
            title: Text(contactModel.name ?? ""),
            subtitle: Text(contactModel.number ?? ""),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // widget.changeTheme?.call();
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddContactPage(),
              ));
          setState(() {});
          print("back avi gya");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
