// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bookstagram/communities/models/book.dart';
import 'package:bookstagram/login.dart';
import 'package:bookstagram/mainpage/comment.dart';
import 'package:bookstagram/mainpage/dialogbox.dart';
import 'package:bookstagram/mainpage/hottopicsdata.dart';
import 'package:bookstagram/left_drawer.dart';
import 'package:bookstagram/mainpage/show_comment.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Future<List<Book>> books;
  late Future<List<Comment>> comments;

  @override
  void initState() {
    super.initState();
    books = HotTopicBooks().fetchBooks();
    comments = ShowComment().fetchComment();
  }

  void createNewComment() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 225, 218, 198),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        drawer:
            context.watch<CookieRequest>().loggedIn ? const LeftDrawer() : null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    'lib/image/1.JPG',
                    height: 360,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to Bookstagram!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 229, 156, 53),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Let the power of words guide you on your literary journey',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 20),

                        // button "Explore Now" (guest user)
                        SizedBox(
                          width: 300, // Set the desired width for the container
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Center(
                              child: context.watch<CookieRequest>().loggedIn
                                  ? TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LeftDrawer()),
                                        );
                                      },
                                      child: const Text(
                                        'Explore Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ) // Hide the button if logged in
                                  : TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                        );
                                      },
                                      child: const Text(
                                        'Explore Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Our Top 5 Picks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Container(
                  child: FutureBuilder<List<Book>>(
                    future: books,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return Center(child: Text('No books found'));
                      } else {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                                childAspectRatio: (1 / 1.5),
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final book = snapshot.data![index];
                                return Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: Image.network(
                                          book.imageL,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                            const SizedBox(height: 4),
                                            Text(
                                              '${book.penulis}',
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ));
                      }
                    },
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          10, 0, 10, 0), // Add left and right padding
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(20), // Add rounded edges
                        child: Image.asset(
                          'lib/image/3.JPG',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50, // Adjust this value as needed
                      child: Column(
                        children: const [
                          Text(
                            'Leave us Comment!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 229, 156, 53),
                            ),
                          ),
                          Text(
                            'Thank you for your interest, and we eagerly await your message. \n We value your questions and feedback regarding our content!',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 254, 253, 253),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  createNewComment();
                },
                child: SizedBox(
                  width: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: const Center(
                      child: Text(
                        'Add Comment',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: FutureBuilder<List<Comment>>(
                  future: comments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final comment = snapshot.data![index];
                              return ListTile(
                                leading:
                                    Icon(Icons.account_circle), // Add user icon
                                title: Row(
                                  children: [
                                    Text('${comment.fields.name}'),
                                    const SizedBox(
                                        width:
                                            8), // Add spacing between name and rating
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => Icon(
                                          index < comment.fields.rate
                                              ? Icons.star_rounded
                                              : Icons.star_rounded,
                                          color: index < comment.fields.rate
                                              ? Color.fromARGB(255, 255, 247, 0)
                                              : Color.fromARGB(23, 72, 72, 67),
                                        ),
                                      ).toList(),
                                    ),
                                  ],
                                ),

                                subtitle: Text('${comment.fields.comments}'),
                              );
                            },
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
