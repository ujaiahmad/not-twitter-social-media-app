import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom-widgets/custom_textfield.dart';
import 'package:social_media_app/custom-widgets/myButton.dart';
import 'package:social_media_app/helper/helper_functions.dart';
import 'package:social_media_app/pages/loginpage.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController confirmPWController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> createFutureDocument(UserCredential? userCredential) async {
      if (userCredential != null && userCredential.user != null) {
        print('creating docs');
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.email)
            .set({
          'email': userCredential.user!.email,
          'username': userNameController.text
        });
      }
    }

    Future<void> register() async {
      //show loading circle
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      //make sure password match
      if (passwordController.text != confirmPWController.text) {
        Navigator.pop(context);
        displayMessageToUser('Passwords don\'t match', context);
      } else {
        //try creating user
        try {
          UserCredential? userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          //this is to store the user in the database...got it
          createFutureDocument(userCredential);
          if (context.mounted) Navigator.pushNamed(context, 'home');
        } on FirebaseAuthException catch (e) {
          print(e);
          Navigator.pop(context);
          displayMessageToUser(e.code, context);
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.person,
                size: 80, color: Theme.of(context).colorScheme.inversePrimary),
            const SizedBox(height: 25),
            //app name

            Text(
              'M I N I M A L',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            // email textfield4
            const SizedBox(height: 25),
            CustomTextField(
                hintext: 'Username',
                obscureText: false,
                controller: userNameController),
            const SizedBox(height: 10),
            CustomTextField(
                hintext: 'Email',
                obscureText: false,
                controller: emailController),
            const SizedBox(height: 10),
            CustomTextField(
                hintext: 'Password',
                obscureText: false,
                controller: passwordController),
            const SizedBox(height: 10),
            CustomTextField(
                hintext: 'Confirm Password',
                obscureText: false,
                controller: confirmPWController),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(
            //       onPressed: () {},
            //       child: Text(
            //         'Forgot Password',
            //         style: TextStyle(
            //             color: Theme.of(context).colorScheme.secondary),
            //       ),
            //     )
            //   ],
            // ),
            const SizedBox(height: 25),
            MyButton(
              text: 'Register',
              onTap: register,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: Text(
                    ' Login Here',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
