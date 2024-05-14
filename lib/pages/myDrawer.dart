import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
              child: Icon(
            Icons.flutter_dash,
            size: 60,
            color: Theme.of(context).colorScheme.tertiary,
          )),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, 'home');
                // print(ModalRoute.of(context).settings.name.toString());
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, 'account');
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ListTile(
              leading: Icon(
                Icons.group,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text("Users"),
              onTap: () {
                Navigator.pushNamed(context, 'user');
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, 'login');
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
