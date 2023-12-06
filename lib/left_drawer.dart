import 'package:bookstagram/form.dart';
import 'package:bookstagram/communities/widgets/event.dart';
import 'package:flutter/material.dart';
import 'package:bookstagram/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
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
            leading: const Icon(Icons.more_vert), // Ganti dengan icon yang diinginkan
            title: const Text('Event'), // Judul dropdown
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.subdirectory_arrow_right),
                title: const Text('Event List'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyEventPage(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.subdirectory_arrow_right),
                title: const Text('Booklist'),
                onTap: () {
                  // Aksi ketika pilihan 2 diklik
                },
              ),
              // Tambahkan lebih banyak ListTile di sini untuk lebih banyak pilihan
            ],
          ),
        ],
      ),
    );
  }
}