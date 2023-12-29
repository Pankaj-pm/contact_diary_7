import 'dart:io';

import 'package:contact_diary_7/add_contact_page.dart';
import 'package:contact_diary_7/add_contact_provider.dart';
import 'package:contact_diary_7/contact_provider.dart';
import 'package:contact_diary_7/theme_provider.dart';
import 'package:contact_diary_7/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication auth = LocalAuthentication();

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
              splashColor: Colors.black12,
              onTap: () {

              },
              subtitle: Text(contactModel.number ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopupMenuButton(
                    position: PopupMenuPosition.under,
                    // padding: EdgeInsetsDirectional.symmetric(vertical: 150),
                    clipBehavior: Clip.antiAlias,
                    icon: Icon(Icons.add),
                    itemBuilder:(context) {
                      return [
                        PopupMenuItem(child:  IconButton(
                          onPressed: () {
                            // var uri = Uri.parse("tel:${contactModel.number ?? ""}");
                            var uri = Uri.parse("https://api.whatsapp.com/send/?phone=918401784759&text&type=phone_number&app_absent=0");

                            launchUrl(uri);
                          },
                          icon: Icon(Icons.call),
                        ),),
                        PopupMenuItem(child: IconButton(
                          onPressed: () {
                            Provider.of<ContactListProvider>(context, listen: false).remove(index);
                          },
                          icon: Icon(Icons.delete),
                        ),),
                        PopupMenuItem(child: IconButton(
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
                        ),),
                      ];
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

            print("isAndroid ${Platform.isAndroid}");
            print("isFuchsia ${Platform.isFuchsia}");
            print("isIOS ${Platform.isIOS}");
            print("isLinux ${Platform.isLinux}");
            print("isMacOS ${Platform.isMacOS}");
            print("isWindows ${Platform.isWindows}");
            print("isWeb ${kIsWeb}");

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => AddContactPage(),
          //     ));
          // setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
