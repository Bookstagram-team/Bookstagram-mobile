import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookstagram/communities/models/product.dart';
import 'package:bookstagram/left_drawer.dart';
import 'package:bookstagram/communities/screens/AddDiscussion.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key? key}) : super(key: key);

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  Map<int, bool> likeStatus = {};
  Map<int, bool> dislikeStatus = {};

  Future<Product> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/discussion/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return Product.fromJson(data);
  }

  // Function to handle like button click
  void handleLike(int postId) {
    setState(() {
      if (likeStatus[postId] == true) {
        likeStatus[postId] = false;
      } else {
        likeStatus[postId] = true;
        dislikeStatus[postId] = false;
      }
    });
  }

  // Function to handle dislike button click
  void handleDislike(int postId) {
    setState(() {
      if (dislikeStatus[postId] == true) {
        dislikeStatus[postId] = false;
      } else {
        likeStatus[postId] = false;
        dislikeStatus[postId] = true;
      }
    });
  }

  // Function to handle reply button click
  void handleReply() async {
    // TODO: Handle reply button click
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion Page'),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewDiscussionPage(),
                ),
              );

              if (result != null && result) {
                setState(() {});
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 228, 155, 52),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot<Product> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var product = snapshot.data!;
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewDiscussionPage(),
                      ),
                    );

                    if (result != null && result) {
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                  child: const Text(
                    'Click here to add discussion',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: product.postList.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Author: ${product.postList[index].author}",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Title: ${product.postList[index].title}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Content: ${product.postList[index].content}"),
                          const SizedBox(height: 10),
                          Text("Created On: ${product.postList[index].createdOn}"),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => handleLike(product.postList[index].id),
                                style: ElevatedButton.styleFrom(
                                  primary: likeStatus[product.postList[index].id] == true
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                child: Text('Like'),
                              ),
                              ElevatedButton(
                                onPressed: () => handleDislike(product.postList[index].id),
                                style: ElevatedButton.styleFrom(
                                  primary: dislikeStatus[product.postList[index].id] == true
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                child: Text('Dislike'),
                              ),

                            ],
                          ),
                          // Reply TextField (Hidden by default)
                          ExpansionTile(
                            title: Text('Reply to ${product.postList[index].author}'),
                            children: [
                              // Use a TextFormField for multiline input
                              TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: 'Type your reply...',
                                  contentPadding: const EdgeInsets.all(16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // TODO: Handle submitting the reply
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                ),
                                child: Text('Submit Reply'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}