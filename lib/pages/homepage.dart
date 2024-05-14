import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom-widgets/custom_textfield.dart';
import 'package:social_media_app/database/firestore.dart';
import 'package:social_media_app/helper/helper_functions.dart';
import 'package:social_media_app/pages/loginpage.dart';
import 'package:social_media_app/pages/myDrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController postController = TextEditingController();

    void postMessage() {
      if (postController.text.isEmpty) {
        displayMessageToUser('No message typed', context);
      } else {
        FirestoreDatabase().postMessage(postController.text);
      }

      postController.clear();
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Homepage',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        // elevation: 15,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        actions: [
          IconButton(
              onPressed: () => logout,
              icon: Icon(
                Icons.logout,
              ))
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      hintext: 'Something on your mind?',
                      obscureText: false,
                      controller: postController),
                ),
                IconButton(
                    onPressed: () => postMessage(),
                    icon: const Icon(Icons.check)),
              ],
            ),
          ),
          StreamBuilder(
            stream: FirestoreDatabase().streamPost(),
            builder: (context, snapshot) {
              //if loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              //if has error
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }

              //if has data
              final post = snapshot.data!.docs;
              final currentUser = FirebaseAuth.instance.currentUser;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: post.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: (post[index]['UserEmail'] ==
                                        currentUser!.email)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text(post[index]['PostMessage']),
                              subtitle: Text(post[index]['UserEmail']),
                            ),
                          ),
                        );
                      }),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
