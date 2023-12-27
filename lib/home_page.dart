import 'package:contact_diary_7/add_contact_page.dart';
import 'package:contact_diary_7/add_contact_provider.dart';
import 'package:contact_diary_7/contact_provider.dart';
import 'package:contact_diary_7/theme_provider.dart';
import 'package:contact_diary_7/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: Consumer<ContactListProvider>(
        builder: (context, contactListProvider, child) => ListView.builder(
          itemCount: contactListProvider.contactList.length,
          itemBuilder: (context, index) {
            var contactModel = contactListProvider.contactList[index];
            return ListTile(
              title: Text(contactModel.name ?? ""),
              subtitle: Text(contactModel.number ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<ContactListProvider>(context, listen: false).remove(index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AddContactPage(
                            index: index,
                          );
                        },
                      ));
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      // var uri = Uri.parse("tel:${contactModel.number ?? ""}");
                      var uri = Uri.parse("https://flutter.dev");

                      launchUrl(uri);
                    },
                    icon: Icon(Icons.call),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddContactPage(),
              ));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
