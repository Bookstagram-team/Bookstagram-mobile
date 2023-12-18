import 'package:bookstagram/left_drawer.dart';
import 'package:bookstagram/profile/models/books.dart';
import 'package:bookstagram/profile/models/profile.dart';
import 'package:bookstagram/profile/screens/bio_form.dart';
import 'package:bookstagram/profile/screens/fetch_bookdata.dart';
import 'package:bookstagram/profile/screens/fetch_profile.dart';
import 'package:flutter/material.dart';
import 'package:bookstagram/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<ProfileScreen> {
  late Future<List<BookAmbil>> books;
  late Future<List<UserProfile>> profiles;
  late TextEditingController bioController;
  bool isEditingBio = false;
  String staticBioText = 'Static Bio Text'; // Initial static bio text
  PageController _pageController = PageController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    books = FetchBook().fetchBooks();

    profiles = FetchProfile().fetchProfiles();
    //print(profiles);
    bioController = TextEditingController();

    // Inisialisasi SharedPreferences
    SharedPreferences.getInstance().then((preferences) {
      prefs = preferences;
      // Ambil bio terakhir yang disimpan (jika ada)
      setState(() {
        staticBioText = prefs.getString('bio') ?? staticBioText;
      });
    });
  }
  void _editBio(BuildContext context, UserProfile userProfile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBioForm(
          onSubmit: (updatedProfile) {
            // Handle the updated profile after editing the bio
            setState(() {
              userProfile.bio = updatedProfile.bio;
            });

            // Show a snackbar to indicate success
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bio successfully updated!")),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Profil Anda'),
      ),
      drawer: LeftDrawer(),
      body: FutureBuilder(
        future: Future.wait([books, profiles]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No books found'));
          } else {
            final List<BookAmbil> filteredBooks = (snapshot.data as List)[0]
                .where((book) =>
                    book.judul.isNotEmpty &&
                    book.judul[0].toUpperCase() ==
                        LoginPage.usernamePass[0].toUpperCase())
                .toList();

            final List<UserProfile> userProfiles = (snapshot.data as List)[1];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  // Column for user information and bio
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                           LoginPage.usernamePass,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // Display user profiles
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: userProfiles.length,
                          itemBuilder: (context, index) {
                            final UserProfile userProfile = userProfiles[index];

                            // Hanya tampilkan profil jika nama sama dengan LoginPage.usernamePass
                            if (userProfile.name == LoginPage.usernamePass) {
                              return ListTile(
                                title: Row(
                                children: [
                                  Text('${userProfile.name}'),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      // Handle edit button pressed
                                      _editBio(context, userProfile);
                                    },
                                  ),
                                ],
                              ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${userProfile.bio}'),
                                    if (userProfile.roleAuthor == true)
                                      Text("Halo penulis buku!"),
                                    if (userProfile.roleReader == true)
                                      Text("Halo pembaca"),
                                    // Text('Is Author: ${userProfile.roleAuthor}'),
                                    // Text('Is Reader: ${userProfile.roleReader}'),
                                  ],
                                ),
                              );
                            } else {
                              // Jika nama tidak sama, return widget kosong (Container)
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Ini adalah rekomendasi buku berdasarkan huruf depan anda',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];
                        return BookCard(book);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_pageController.page! > 0) {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_pageController.page! < filteredBooks.length - 1) {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final BookAmbil book;

  const BookCard(this.book);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.network(
              book.imageL,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  book.judul,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Author: ${book.penulis}',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Publisher: ${book.publisher}',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Rating: ${book.rating}',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

