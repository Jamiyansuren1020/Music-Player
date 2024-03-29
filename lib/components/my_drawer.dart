import 'package:flutter/material.dart';
import 'package:music_player/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
                  child: Icon(
            Icons.music_note,
            size: 40,
            color: Theme.of(context).colorScheme.inversePrimary,
          ))),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10),
            child: ListTile(
                leading: const Icon(Icons.home),
                title: const Text('H O M E'),
                onTap: () {
                  Navigator.of(context).pop();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('S E T T I N G S'),
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage()));
                }),
          )
        ],
      ),
    );
  }
}
