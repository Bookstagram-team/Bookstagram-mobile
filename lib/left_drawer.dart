import 'package:bookstagram/communities/screens/booklist.dart';
import 'package:bookstagram/communities/screens/discussion.dart';
import 'package:bookstagram/form.dart';
import 'package:bookstagram/communities/widgets/event.dart';
import 'package:bookstagram/login.dart';
import 'package:flutter/material.dart';
import 'package:bookstagram/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:bookstagram/communities/models/product.dart';
import 'package:bookstagram/left_drawer.dart';

import 'package:bookstagram/left_drawer.dart';



class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Bookstagram',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Catat keperluan literasimu disini",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Produk'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ShopFormPage()),
              );
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.more_vert),
            title: const Text('Event'),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.subdirectory_arrow_right),
                title: const Text('Event List'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyEventPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.subdirectory_arrow_right),
                title: const Text('Booklist'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookListPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.forum), // Add icon for Discussion
            title: const Text('Discussion'), // Add text for Discussion
            onTap: () {
              // Add your navigation logic for the Discussion page here
              // For example, Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DiscussionPage()));


               Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DiscussionPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final response = await request.logout(
                "http://localhost:8000/auth/logout/");
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
